#!/usr/bin/env stack
{- stack
    --resolver lts-6.15
    --install-ghc
    runghc
    --package cmdargs
-}
{-# LANGUAGE DeriveDataTypeable #-}

import System.Console.CmdArgs.Implicit

data Args
  = Console 
      { prompt :: String
      , check :: Bool
      , files :: [FilePath]
      } 
  | Compile 
      { compile :: Bool
      , output :: FilePath
      , files :: [FilePath]
      }
  deriving (Show, Data, Typeable)

consoleArgs = Console 
  { prompt = def &= help "Set the prompt" &= opt "> "
  , check = def &= help "Typecheck only"
  , files = def &= args &= typ "modules"
  } &= 
  help "Start the console"

compileArgs = Compile 
  { compile = def &= help "Compile only"
  , output = def &= help "Output file"
  , files = def &= args &= typ "modules"
  } &=
  help "Compile modules"

-- modes :: Data val => [val] -> val
--
--

mode' = modes [consoleArgs, compileArgs] &=
  verbosity &=
  help "BabyML compiler and repl/console" &=
  program "babyml" &=
  summary "BabyML v0.1.0"

main = print =<< cmdArgs mode'
