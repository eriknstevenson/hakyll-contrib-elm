{-# LANGUAGE OverloadedStrings #-}

module Hakyll.Contrib.Elm (elmMake) where

import qualified Data.ByteString.Char8 as BS
import           Data.Monoid
import           Hakyll
import           System.Directory (getCurrentDirectory)
import           System.IO.Temp (withTempFile)
import           System.Process (callCommand)

-- | Use the 'elm-make' tool to build a elm source file and
-- generate javascript. (Requires you have elm-make installed and available on your PATH.)
elmMake :: Compiler (Item String)
elmMake =
  cached "Hakyll.Contrib.Elm.elmMake" $ do
    inputFile <- getResourceFilePath
    elmOutput <- unsafeCompiler $ do
      dir <- getCurrentDirectory
      withTempFile dir "output.js" $ \fp h -> do
        let outputFile = "--output=" <> fp
            warn = "--warn"
            args = unwords [inputFile, warn, outputFile]
            cmd = "elm-make" <> " " <> args
        putStrLn $ "Running command: " <> cmd
        callCommand cmd
        fmap BS.unpack $ BS.hGetContents h
    makeItem elmOutput