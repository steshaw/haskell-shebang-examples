#! /usr/bin/env nix-shell
#! nix-shell -i runghc -p haskellPackages.ghc haskellPackages.HTTP

import Network.HTTP

main = do
  resp <- Network.HTTP.simpleHTTP (getRequest "http://nixos.org/")
  body <- getResponseBody resp
  print (take 100 body)
