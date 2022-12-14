Министерство науки и высшего образования Российской Федерации федеральное государственное автономное образовательное учреждение высшего образования

«Национальный исследовательский университет ИТМО»

---
__ФПИиКТ, Системное и Прикладное Программное Обеспечение__

__Лабораторная работа №1__

по Функциональному программированию

Выполнил: Провоторов А. В.

Группа: P34112

Преподаватель: Пенской Александр Владимирович

###### Санкт-Петербург
###### 2022 г.

---

## Описание проблемы
### [Even Fibonacci numbers](https://projecteuler.net/problem=2)

#### Problem 8
The four adjacent digits in the 1000-digit number that have the greatest product are 9 × 9 × 8 × 9 = 5832.

73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450

Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?

## Ключевые элементы реализации с минимальными комментариями
__хвостовая рекурсия__
```
solution1 = p8_1 position 0
    where 
        p8_1 n m
            | n == 987 = m
            | otherwise 
            = p8_1 (n + 1) (max m curr_sum)
                where
                    curr_sum = product (wantedSubstrings !! n)
```
В данном случае мы накапливаем в m максимальное число, проходясь по всем подстрокам, а потом возвращаем его

__рекурсия__
```
solution2 = p8_2 position 0
    where
        p8_2 n m = if n < 987 
        then
            if (product (wantedSubstrings !! n) > m) 
            then p8_2(n+1)(product (wantedSubstrings !! n))
            else p8_2(n+1)(m)
        else m
```
Здесь у нас функция возвращает либо m либо произведение чисел подстроки в зависимости от того, что из этого больше

__модульная реализация__
```
solution3 = foldl1 max (map product wantedSubstrings)
```
Функция свертки применяется к функции max, что позволяет нам выбрать 1 самое большое число произведений чисел подстрок из его списка

__генерация последовательности при помощи отображения (map)__
```
a = map product (wantedSubstrings)
p8_4 n m
    | n == 987 = m
    | otherwise 
    = p8_4 (n + 1) (max m (a!!n))

solution4 = p8_4 position 0
```
Это решение схоже с решением 1, однако в данном случае мы сначала получаем список произведений чисел подстрок, а затем уже проходимся по нему хвостовой рекурсией

__работа с бесконечными списками для языков поддерживающих ленивые коллекции или итераторы как часть языка__
```
p8_5 = (takeWhile (\n -> and (product (n) > product (last p8_5), n /= last wantedSubstrings)) wantedSubstrings)
solution5 = foldl1 max (map product p8_5)
```
В данном решении мы получаем массив значений ```product (n) > product (last p8_5)```, а затем из него выбираем самое большое

#### Problem 23
A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

## Ключевые элементы реализации с минимальными комментариями
__хвостовая рекурсия__
```
skipped due to solution structure
```

__рекурсия__
```
factor n (p:ps)
        | p * p > n = [n]
        | mod n p == 0 = p:factor (div n p) (p:ps)
        | otherwise = factor n ps
```
Здесь мы смотрим, имеет ли число делитель и если имеет, то мы его раскладываем, пока не найдем простой делитель

__модульная реализация__
```
ns x = takeWhile (\a -> a <= div x 2) abundantNumbers
```
В данной строчке перебираются все числа, сумма делителей которых больше самих чисел и смотрится, делятся ли эти числа на 2

__генерация последовательности при помощи отображения (map)__
```
sigma = product . map ((+1) . foldl1 (\a x -> x+a*x)) . group . primeFactors
```
функция sigma - произведение списка вычисленных по формуле ```x+a*x``` полученных группированных простых чисел

__работа с бесконечными списками для языков поддерживающих ленивые коллекции или итераторы как часть языка__
```
primes = 2:filter isPrime [3,5..]
```
В данном бесконечном цикле мы просто перебираем простые числа

## Выводы

В ходе выполнения данной лабораторной работы я освоил базовые приемы и абстракции языка __Haskell__. Рекурсия, функции свертки, отображения и другие потоковые функции, списки, последовательности и т. д. Формы передачи потока управления в виде различных циклов, условных форм `if` и `cond`. Формы для организации локальных привязок с помощью `let`.