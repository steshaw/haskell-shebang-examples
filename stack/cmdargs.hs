#!/usr/bin/env stack
{- stack
    --resolver lts-6.15
    --install-ghc
    runghc
    --package cmdargs
-}
{-# LANGUAGE DeriveDataTypeable #-}

import System.Console.CmdArgs.Implicit

data Options
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
  { prompt = def &=
             help "Set the prompt" &=
             opt "> " &=
             typ "PROMPT"
  , check = def &= help "Typecheck only"
  , files = def &= args &= typ "modules"
  } &=
  help "Start the console"

compileArgs = Compile
  { compile = def &= help "Compile only"
  , output = def &= help "Output file" &=
             typ "OUTPUT-FILE"
  , files = def &= args &= typ "modules"
  } &=
  help "Compile modules"

mode' = modes [consoleArgs, compileArgs] &=
  verbosity &=
  help "BabyML compiler and repl/console" &=
  program "babyml" &=
  summary "BabyML v0.1.0"

main = print =<< cmdArgs mode'
