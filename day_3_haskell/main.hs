import Data.Foldable
import GHC.Base (assert)
import System.Posix.Internals (puts)
import Text.PrettyPrint.HughesPJClass (Pretty (pPrint))

main :: IO ()
countZero :: String -> [Int]
countZero sq = case sq of
  [] -> []
  ('0' : q) -> 1 : countZero (q)
  ('1' : q) -> 0 : countZero (q)
  (_ : _) -> []

sumEachPos :: [Int] -> [Int] -> [Int]
sumEachPos [] [] = []
sumEachPos (i : is) [] = (i : is)
sumEachPos [] (j : js) = (j : js)
sumEachPos (i : is) (j : js) = i + j : sumEachPos is js

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
  ('0' : q) -> '1' : invert (q)
  ('1' : q) -> '0' : invert (q)

binToDec :: String -> Int
binToDec l = case l of
  [] -> 0
  ('1' : q) -> 2 ^ (length q) + (binToDec q)
  ('0' : q) -> binToDec q

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
  let gamma = (binToDec (gammaRate testReport))
  let epsilon = (binToDec (epsilonRate testReport))
  putStrLn $ show (gamma * epsilon)

  content <- readFile ("./input")
  let gamma = (binToDec (gammaRate (lines content)))
  let epsilon = (binToDec (epsilonRate (lines content)))
  putStrLn $ show (gamma * epsilon)