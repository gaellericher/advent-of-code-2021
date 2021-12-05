import Data.Foldable
import GHC.Base (assert)
import System.Posix.Internals (puts)
import Text.PrettyPrint.HughesPJClass (Pretty (pPrint))

main :: IO ()
countZero :: String -> [Int]
countZero = map (\ i -> if i == '0' then 1 else 0)

sumEachPos :: [Int] -> [Int] -> [Int]
sumEachPos [] [] = []
sumEachPos (i : is) [] = i : is
sumEachPos [] (j : js) = j : js
sumEachPos (i : is) (j : js) = i + j : sumEachPos is js

-- Ideally some common operator would do this ;/
sumEachPosL :: [[Int]] -> [Int]
sumEachPosL [] = []
sumEachPosL (x : y : s) = sumEachPos (sumEachPos x y) (sumEachPosL s)
sumEachPosL (x : _) = x

mostCommon :: Int -> [Int] -> String
mostCommon n iq = case iq of
  [] -> []
  (i : q) -> (if i > n then "0" else "1") ++ mostCommon n q

invert :: String -> String
invert l = case l of
  [] -> []
  (i : q) -> (if i == '0' then '1' else '0') : invert q

binToDec :: String -> Int
binToDec [] = 0
binToDec ('1' : q) = 2 ^ length q + binToDec q
binToDec (_ : q) = binToDec q

gammaRate :: [String] -> String
gammaRate l = mostCommon (div (length l) 2) (sumEachPosL (map countZero l))

epsilonRate :: [String] -> String
epsilonRate l = invert (gammaRate l)

main = do
  let testReport =
        [ "00100",
          "11110",
          "10110",
          "10111",
          "10101",
          "01111",
          "00111",
          "11100",
          "10000",
          "11001",
          "00010",
          "01010"
        ]
  let gamma = binToDec (gammaRate testReport)
  let epsilon = binToDec (epsilonRate testReport)
  print (gamma * epsilon)

  content <- readFile "./input"
  let gamma = binToDec (gammaRate (lines content))
  let epsilon = binToDec (epsilonRate (lines content))
  print (gamma * epsilon)