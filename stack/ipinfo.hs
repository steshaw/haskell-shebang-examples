#!/usr/bin/env stack
-- stack --resolver lts-6.14 --install-ghc runghc
-- stack --package classy-prelude
-- stack --package lens
-- stack --package wreq

-- Blah Blah words about this single file executable README goes here.

{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

-- explain explain

import ClassyPrelude
import Control.Lens
import Network.Wreq
import Data.Aeson

-- more explaining

data IPInfo = IPInfo
  { ip :: Text
  , hostname :: Text
  , city :: Text
  , region :: Text
  , country :: Text
  , loc :: Text
  , org :: Text
  , postal :: Text
  } deriving (Show, Generic, ToJSON, FromJSON)

-- you are probably confused right now. let me explain

main = do
  let opts = defaults & header "User-Agent" .~ ["curl/7.47.0"]
  eInfo <- eitherDecode . view responseBody <$> getWith opts "http://ipinfo.io"
--  either print (putStrLn . city) (eInfo :: Either String IPInfo)
  either print print (eInfo :: Either String IPInfo)

--
-- when I run it like this:
-- 
-- user@computer:~/src% ./README.lhs
-- Portland
-- 
-- you can see that I'm in Portland
