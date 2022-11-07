import Data.Char (digitToInt, ord)
import Data.List (tails)

bignumber = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
adjacent = 13 
position = 0

-- [7, 3, 1, 6, 7, 1, 7, 6, 5, 3, ...]
digits = map (\c -> (ord c) - (ord '0')) bignumber

-- (Starting from the right end) [[0,4,2,0,...,5,0], [3,0,4,2,...,4,5], [5,3,0,4,...,3,4], ...]
wantedSubstrings = map (take adjacent) $ drop adjacent $ reverse $ tails digits

-- хвостовая рекурсия
solution1 = p8_1 position 0
    where 
        p8_1 n m
            | n == 987 = m
            | otherwise 
            = p8_1 (n + 1) (max m curr_sum)
                where
                    curr_sum = product (wantedSubstrings !! n)

-- рекурсия
solution2 = p8_2 position 0
    where
        p8_2 n m = if n < 987 
        then
            if (product (wantedSubstrings !! n) > m) 
            then p8_2(n+1)(product (wantedSubstrings !! n))
            else p8_2(n+1)(m)
        else m

-- модульная реализация
solution3 = foldl1 max (map product wantedSubstrings)

-- генерация последовательности при помощи отображения (map)
a = map product (wantedSubstrings)
p8_4 n m
    | n == 987 = m
    | otherwise 
    = p8_4 (n + 1) (max m (a!!n))

solution4 = p8_4 position 0

-- работа с бесконечными списками для языков поддерживающих ленивые коллекции или итераторы как часть языка
p8_5 = (takeWhile (\n -> and (product (n) > product (last p8_5), n /= last wantedSubstrings)) wantedSubstrings) 
solution5 = foldl1 max (map product p8_5)

main = putStrLn (show solution5)