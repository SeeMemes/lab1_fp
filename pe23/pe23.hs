import Data.List
import Data.Array.ST
import Control.Monad.ST
import Control.Monad
import Data.Array.Unboxed

maxNo = 28123

obtainNonAbundantSums abNos= runSTUArray $ do
    arr <- newArray (1, maxNo) True
    forM_ abNos $ \m -> do
        let xs = takeWhile (\a -> m + a <= maxNo) $ dropWhile (< m) abNos
        forM_ xs $ \n -> writeArray arr (m + n) False
    return arr

abundantNos n = filter (\n -> sumProperDivisors n > n) [1..n] 

sumProperDivisors n 
  | n == 1    = 0
  | otherwise = sum factors - n
    where 
        factors = concatMap (\(x,y)-> if x /= y then [x,y] else [x]) $ factorPairs n
     
factorPairs x = [ (y, x `div` y) | y <- [1..truncate (sqrt (fromIntegral x))], x `mod` y == 0]

euler23 = sum [x | (x, True) <- (assocs . obtainNonAbundantSums) $ abundantNos maxNo]

main = putStrLn (show euler23)