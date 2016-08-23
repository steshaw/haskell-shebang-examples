#!/usr/bin/env runhaskell

import Control.Monad (forM_)
import Network.BSD (getHostByName, hostAddress)
import Network.Socket (inet_ntoa)
import System.Environment (getArgs)

resolve address = do
  ent <- getHostByName address
  name <- inet_ntoa (hostAddress ent)
  return name

main = do
  args <- getArgs
  args `forM_` (\address -> do
    ip <- resolve address
    putStrLn $ address ++ "\t" ++ ip)
