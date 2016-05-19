# Use Elm and Hakyll

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