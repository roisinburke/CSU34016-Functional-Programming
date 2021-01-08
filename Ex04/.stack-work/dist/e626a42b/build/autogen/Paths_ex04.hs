{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_ex04 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\roisi\\my-project\\Exercise04\\.stack-work\\install\\3ab3f6d0\\bin"
libdir     = "C:\\Users\\roisi\\my-project\\Exercise04\\.stack-work\\install\\3ab3f6d0\\lib\\x86_64-windows-ghc-8.6.4\\ex04-0.1.0.0-1QJQDvZQOwjHLLAaOcEOsX"
dynlibdir  = "C:\\Users\\roisi\\my-project\\Exercise04\\.stack-work\\install\\3ab3f6d0\\lib\\x86_64-windows-ghc-8.6.4"
datadir    = "C:\\Users\\roisi\\my-project\\Exercise04\\.stack-work\\install\\3ab3f6d0\\share\\x86_64-windows-ghc-8.6.4\\ex04-0.1.0.0"
libexecdir = "C:\\Users\\roisi\\my-project\\Exercise04\\.stack-work\\install\\3ab3f6d0\\libexec\\x86_64-windows-ghc-8.6.4\\ex04-0.1.0.0"
sysconfdir = "C:\\Users\\roisi\\my-project\\Exercise04\\.stack-work\\install\\3ab3f6d0\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ex04_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ex04_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ex04_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ex04_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ex04_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ex04_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
