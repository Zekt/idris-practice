import Data.Vect
import Control.ST

data Access = LoggedIn | LoggedOut

LoginResult : Type
LoginResult = Bool

interface DataStore (m : Type -> Type) where
  Store : Access -> Type
  connect : ST m Var [add (Store LoggedOut)]
  disconnect : (store : Var) -> ST m () [remove store (Store LoggedIn)]
  readSecret : (store : Var) -> ST m String [store ::: Store LoggedIn]
  login : (store : Var) -> ST m LoginResult [store ::: Store LoggedOut :->
                                             (\res => Store (case res of True => LoggedIn
                                                                         False => LoggedOut))]
  logout : (store : Var) -> ST m () [store ::: Store LoggedIn :-> Store LoggedOut]

implementation DataStore IO where
  Store x = State String
  connect = ?con
  disconnect = ?dis
  readSecret = ?rea
  login = ?log
  logout = ?logo
