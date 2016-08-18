#!/usr/bin/env stack
{- stack
    --resolver lts-6.12
    --install-ghc
    runghc
    --package aeson
    --package lens
    --package lens-aeson
    --package wreq
-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent.Async
import Control.Lens
import Data.Aeson
import Data.Aeson.Lens (key)
import Data.Foldable
import Network.Wreq

echo :: Integer -> IO (Maybe Value)
echo s = do
  r <- post "http://httpbin.org/post" (toJSON s)
  pure $ r ^? responseBody . key "json"

posts = map echo [1..100]

main = do
  first <- runConcurrently $ asum (map Concurrently posts)
  print first
