# Use Elm and Hakyll

Elm has changed significantly since v0.10, and using the compiler as a library is no longer viable/preferred. This hakyll extension works with Elm v0.17 and improves upon previous similar solutions by working with multi-module elm programs (via `elm-make`).

## Usage

Verify you have the `elm-make` build tool installed: `npm install -g elm`

```haskell
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Hakyll
import Hakyll.Contrib.Elm

main :: IO ()
main = hakyll $ do

  match "elm/*.elm" $ do
    route $ setExtension "js" `composeRoutes` gsubRoute "elm/" (const "js/")
    compile elmMake

  match "index.html" $ do
    route idRoute
    compile $
      getResourceBody
      >>= loadAndApplyTemplate "templates/layout.html" defaultContext

  match "templates/*" $ compile templateCompiler
```
