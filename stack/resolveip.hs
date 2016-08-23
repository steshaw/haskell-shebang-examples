#!/usr/bin/env runhaskell

import Control.Monad (forM_)
import Network.BSD (getHostByName, hostAddresses)
import Network.Socket (inet_ntoa)
import System.Environment (getArgs)

resolve address = do
  ent <- getHostByName address
  names <- mapM inet_ntoa (hostAddresses ent)
  return names

main = do
  args <- getArgs
  args `forM_` (\address -> do
    ips <- resolve address
    ips `forM_` (\ip -> putStrLn $ address ++ "\t" ++ ip))
