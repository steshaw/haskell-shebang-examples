#!/usr/bin/env stack
{- stack
    --resolver lts-6.14
    --install-ghc
    runghc
    --package GLFW
-}

import Graphics.UI.GLFW

main = do
  initialize
  videoMode <- desktopMode
  let w = videoWidth videoMode
  let h = videoHeight videoMode
  putStrLn $ show w ++ "x" ++ show h
