import Data.Vect
import Control.ST

readAndAdd : ConsoleIO io => (vec : Var) ->
             STrans io Bool [vec ::: State (Vect n Integer)]
                    (\res => [vec ::: State (if res then Vect (S n) Integer
                                                    else Vect n Integer)])
readAndAdd vec = do putStr "Enter a number: "
                    num <- getStr
                    if all isDigit (unpack num)
                       then do 
                         update vec ((cast num) ::)
                         pure True
                       else ?what
