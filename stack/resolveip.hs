#!/usr/bin/env stack
-- stack --resolver lts-6.13 --install-ghc runghc

import Data.Foldable (for_)
import Network.BSD (getHostByName, hostAddresses)
import Network.Socket (inet_ntoa)
import System.Environment (getArgs)

resolve address = do
  ent <- getHostByName address
  mapM inet_ntoa (hostAddresses ent)

main = do
  args <- getArgs
  for_ args $ \address -> do
    ips <- resolve address
    for_ ips $ \ip -> putStrLn $ address ++ "\t" ++ ip
