#!/usr/bin/env stack
{- stack
    --resolver lts-6.12
    --install-ghc
    runghc
    --package async
-}

import Control.Concurrent
import Control.Concurrent.Async

forever :: String -> Int -> IO ()
forever msg delay = loop
  where 
    loop = do
      putStrLn msg
      threadDelay (delay * 1000)
      loop

foo = forever "foo" 3000
bar = forever "bar" 5000

main = foo `concurrently` bar
