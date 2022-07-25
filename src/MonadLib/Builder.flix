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


    ///
    /// Mutable State which is equivalent to Reader (without local), and Error 
    /// monad in codensity style to be stack safe.
    /// 
    /// `ka` is the continuation answer type
    ///
    pub enum Builder[r: Region, ka: Type, st: Type, a: Type](
        st -> (a -> Result[ka, String] & r) -> Result[ka, String] & r)


    instance Functor[Builder[r, ka, st]] {
        pub def map(f: a -> b & ef, ma: Builder[r, ka, st, a]): Builder[r, ka, st, b] & ef = 
            MonadLib/Builder.map(f, ma)
    }


    instance Applicative[Builder[r, ka, st]] {
        pub def point(x: a): Builder[r, ka, st, a] =  MonadLib/Builder.point(x)
        pub def ap(mf: Builder[r, ka, st, a -> b & ef], ma: Builder[r, ka, st, a]): Builder[r, ka, st, b] & ef =
            MonadLib/Builder.ap(mf, ma)
    }

    instance Monad[Builder[r, ka, st]] {
        pub def flatMap(f: a -> Builder[r, ka, st, b] & ef, ma: Builder[r, ka, st, a]): Builder[r, ka, st, b] & ef =
            MonadLib/Builder.flatMap(f, ma)
    }

}


namespace MonadLib/Builder {

    use MonadLib.Builder;
    use MonadLib.Builder.{Builder};


    ///
    /// Helper function for the implementation of `map` and `ap` etc.
    ///
    def apply1(ma: Builder[r, ka, st, a], 
                s: st, 
                k: a -> Result[ka, String] & r): Result[ka, String] & r =
        let Builder(ma1) = ma;
        ma1(s, k)


    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    pub def runBuilder(_: Region[r], 
                        ma: Builder[r, a, st, a], 
                        s: st): Result[a, String] & r =
        let Builder(f) = ma;
        let cont = a -> Ok(a) as & r;
        f(s, cont)


    pub def point(x: a): Builder[r, ka, st, a] =
        Builder((_, k) -> k(x))

    pub def map(f: a -> b & ef, ma: Builder[r, ka, st, a]): Builder[r, ka, st, b] & ef =
        Builder((s, k) ->
            apply1(ma, s, a -> k(f(a) as & r))
        ) as & ef

    pub def ap(mf: Builder[r, ka, st, a -> b & ef], ma: Builder[r, ka, st, a]): Builder[r, ka, st, b] & ef =
        Builder((s, k) ->
            apply1(mf, s, f ->
                apply1(ma, s, a ->
                    k(f(a) as & r)))
        ) as & ef


    pub def flatMap(f: a -> Builder[r, ka, st, b] & ef, ma: Builder[r, ka, st, a]): Builder[r, ka, st, b] & ef =
        Builder((s, k) ->
            apply1(ma, s, a ->
                apply1(f(a) as & r, s, b ->
                    k(b)))
        ) as & ef

    pub def throwError(msg: String): Builder[r, ka, st, a] = 
        Builder((_, _) -> Err(msg) as & r)


    pub def liftGetter(f: st -> a & ef): Builder[r, ka, st, a] & ef = 
        Builder((s, k) ->
            try {
                let ans = f(s) as & r;
                k(ans)
            } catch {
                case ex: ##java.lang.Exception => 
                    import java.lang.Throwable.getMessage(): String & r;
                    Err(getMessage(ex))
            }            
        ) as & ef

    pub def liftSetter(f: st -> st & ef): Builder[r, ka, st, Unit] & ef = 
        Builder((s, k) ->
            try {
                { discard f(s); k()} as & r
            } catch {
                case ex: ##java.lang.Exception => 
                    import java.lang.Throwable.getMessage(): String & r;
                    Err(getMessage(ex))
            }            
        ) as & ef



}
