#!/usr/bin/env stack
-- stack --resolver lts-6.13 --install-ghc runghc

import Control.Monad (forM_)
import Network.BSD (getHostByName, hostAddresses)
import Network.Socket (inet_ntoa)
import System.Environment (getArgs)

resolve address = do
  ent <- getHostByName address
  mapM inet_ntoa (hostAddresses ent)

main = do
  args <- getArgs
  args `forM_` (\address -> do
    ips <- resolve address
    ips `forM_` (\ip -> putStrLn $ address ++ "\t" ++ ip))
