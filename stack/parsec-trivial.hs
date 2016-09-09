#!/usr/bin/env stack
{- stack
    --resolver lts-6.15
    --install-ghc
    runghc
    --package parsec
-}

import System.Environment
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Char

ws = many space

nat :: Parser Integer
nat = read <$> many digit

parseProgram = ws *> nat <* ws <* eof

main = do
  args <- getArgs
  let filename = head args
  contents <- readFile filename
  let c = parse parseProgram filename contents
  putStrLn "------------------------------------------------"
  putStrLn "THE PROGRAM WE HAVE PARSED"
  putStrLn "------------------------------------------------"
  putStrLn $ show c
