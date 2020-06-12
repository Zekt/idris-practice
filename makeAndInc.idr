import Control.ST
increment : (x : Var) -> STrans m () [(x ::: State Integer)]
                                     (const [(x ::: State String)])
increment x = do num <- read x
                 write x "test"

makeAndIncrement : Integer -> STrans m String [] (const [])
makeAndIncrement init = do var <- new init
                           increment var
                           x <- read var
                           delete var
                           pure x
