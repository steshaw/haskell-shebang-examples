#!/usr/bin/env stack
{- stack
    --resolver lts-6.12
    --install-ghc
    runghc
    --package aeson
    --package conceit
    --package lens
    --package lens-aeson
    --package wreq
-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent.Conceit
import Control.Lens
import Data.Aeson
import Data.Aeson.Lens (key)
import Data.Maybe (maybe)
import Data.Foldable
import Network.Wreq

echo :: Integer -> IO (Either Value String)
echo i = do
  r <- post "http://httpbin.org/post" (toJSON i)
  if i >= 3 && i <= 8 then pure $ Right "simulate failure"
  else pure $ maybe (Right "Malformed response") Left (r ^? responseBody . key "json")

main = do
  first <- mapConceit echo [1..10]
  print first
