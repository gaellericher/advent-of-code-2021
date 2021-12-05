main :: IO ()

main = do
    content <- readFile ("./input")
    let (k:_) = lines content
    putStrLn $ k