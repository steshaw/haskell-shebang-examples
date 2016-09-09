#!/usr/bin/env stack
{- stack
    --resolver lts-6.15
    --install-ghc
    runghc
    --package parsec
-}

import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Char
import Numeric.Natural

-- type Parser r = GenParser Char st r

type Identifier = String

type Expression = Integer

data Statement
  = If Expression Statement Statement
  | Assign Identifier Expression
  deriving (Show)

data Program
  = Program [Statement]
  deriving (Show)

ws = many space

lexeme p = do
  r <- p
  ws
  return r

keyword :: String -> Parser String
keyword k = try (do r <- string k
                    notFollowedBy alphaNum
                    return r)

integer = do
  digits <- many (digit)
  return $ read digits
identifier = many alphaNum

int = lexeme integer
kw s = lexeme (keyword s)
semi = lexeme $ char ';'
eq = lexeme $ char '='
ident = lexeme $ identifier

expression = int

ifStatement = do
  (kw "if")
  cond <- expression
  (kw "then")
  stat1 <- statement
  (kw "else")
  stat2 <- statement
  return $ If cond stat1 stat2

assignmentStatement = do
  i <- ident
  eq
  e <- expression
  return $ Assign i e

statements = statement `sepBy` semi

statement  = ifStatement <|> assignmentStatement

program = Program <$> (ws *> statements <* eof)

main = do
  putStr "imperative> "
  s <- getLine
  if s == ":q" then
     return ()
     else do
       let r = parse program "repl" s
       putStrLn $ show r
       main
