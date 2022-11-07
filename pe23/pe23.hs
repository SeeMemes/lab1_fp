import Data.List
import Data.IntSet (toList, fromList)
import Data.Array

primes = 2:filter isPrime [3,5..]
isPrime = null . tail . primeFactors
primeFactors n = factor n primes
    where
    factor n (p:ps)
        | p * p > n = [n]
        | mod n p == 0 = p:factor (div n p) (p:ps)
        | otherwise = factor n ps

sigma = product . map ((+1) . foldl1 (\a x -> x+a*x)) . group . primeFactors
aliquot n = sigma n - n

maxN = 28123

isAbundants = listArray (1,maxN) $ map (\n -> aliquot n > n) [1..maxN]
isAbundant x = isAbundants ! x
abundantNumbers = filter isAbundant [1..maxN]

solution = sum [x | x <- [1..maxN], f x] 
    where f x = null [() | a <- ns x, isAbundant (x-a)]
ns x = takeWhile (\a -> a <= div x 2) abundantNumbers

main = putStrLn $ show solution