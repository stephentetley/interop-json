/*
 * Copyright 2022 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace MonadLib {


    pub enum Evaluator[r: Region, ka: Type, st: Type, a: Type](
        st -> (a -> Result[ka, String] & r) -> Result[ka, String] & r)


    instance Functor[Evaluator[r, ka, st]] { 
        pub def map(f: a -> b & ef, x: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, b] & ef = 
            MonadLib/Evaluator.map(f, x)
    }

    instance Applicative[Evaluator[r, ka, st]] { 
        pub def point(x: a): Evaluator[r, ka, st, a] = MonadLib/Evaluator.point(x)

        pub def ap(f: Evaluator[r, ka, st, a -> b & ef], x: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, b] & ef = 
            MonadLib/Evaluator.ap(f, x)
    }

    instance Monad[Evaluator[r, ka, st]] { 
        pub def flatMap(k: a -> Evaluator[r, ka, st, b] & ef, x: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, b] & ef = 
            MonadLib/Evaluator.flatMap(k, x)
    }

}

namespace MonadLib/Evaluator {

    use MonadLib.Evaluator;
    use MonadLib.Evaluator.{Evaluator};




    def apply1(ma: Evaluator[r, ka, st, a], 
                s: st, 
                k: a -> Result[ka, String] & r): Result[ka, String] & r =
        let Evaluator(ma1) = ma;
        ma1(s, k)


    def apply1WithHandler(ma: Evaluator[r, ka, st, a], 
                            s: st, 
                            k: a -> Result[ka, String] & r, 
                            handleK: String -> Result[ka, String] & r): Result[ka, String] & r =
        let Evaluator(ma1) = ma;
        match ma1(s, k) {
            case Err(msg) => handleK(msg)
            case Ok(a)    => Ok(a)
        }


    ///
    /// Returns the result of applying `ma` to the state `s`.
    ///
    pub def runEvaluator(_: Region[r], 
                        ma: Evaluator[r, a, st, a], 
                        s: st): Result[a, String] & r =
        let Evaluator(f) = ma;
        let cont = a -> Ok(a) as & r;
        f(s, cont)

    pub def point(x: a): Evaluator[r, ka, st, a] = Evaluator((_, k) -> k(x))

    pub def map(f: a -> b & ef, ma: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, b] & ef =
        Evaluator((s, k) ->
            apply1(ma, s, a -> k(f(a) as & r))
        ) as & ef

    pub def ap(mf: Evaluator[r, ka, st, a -> b & ef], ma: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, b] & ef =
        Evaluator((s, k) ->
            apply1(mf, s, f ->
                apply1(ma, s, a ->
                    k(f(a) as & r)))
        ) as & ef


    pub def flatMap(f: a -> Evaluator[r, ka, st, b] & ef, ma: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, b] & ef =
        Evaluator((s, k) ->
            apply1(ma, s, a ->
                apply1(f(a) as & r, s, b ->
                    k(b)))
        ) as & ef

    pub def orelse(ma: Evaluator[r, ka, st, a], mb: Evaluator[r, ka, st, a]): Evaluator[r, ka, st, a] =
        Evaluator((s, k) ->
            apply1WithHandler(ma, s, a -> k(a), _ -> apply1(mb, s, b -> k(b)))
        )

    pub def throwError(msg: String): Evaluator[r, ka, st, a] = 
        Evaluator((_, _) -> Err(msg) as & r)

    pub def liftGetter(f: st -> a & ef): Evaluator[r, ka, st, a] & ef = 
        Evaluator((s, k) ->
            try {
                let ans = f(s) as & r;
                k(ans)
            } catch {
                case ex: ##java.lang.Exception => 
                    import java.lang.Throwable.getMessage(): String & r;
                    Err(getMessage(ex))
            }            
        ) as & ef

    pub def liftActionResult(f: Unit -> Result[a, String] & ef): Evaluator[r, ka, st, a] & ef = 
        Evaluator((_, k) ->
            match {f() as & r} {
                case Err(msg) => Err(msg)
                case Ok(a)    => k(a)
            }
        ) as & ef

}

