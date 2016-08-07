#!/usr/bin/env nix-shell
#!nix-shell -i runghc -p 'haskellPackages.ghcWithPackages (p: [p.HTTP])'

import Network.HTTP

main = do
  resp <- simpleHTTP (getRequest "http://nixos.org/")
  body <- getResponseBody resp
  print (take 100 body)
