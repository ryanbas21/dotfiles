{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_my_xmonad (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
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

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ryan/.xmonad/.stack-work/install/x86_64-linux/8c0b7aca7ad214cf42cca3ece354d01b9023c560eabdbcaed210f9016d4b1cdc/9.6.6/bin"
libdir     = "/home/ryan/.xmonad/.stack-work/install/x86_64-linux/8c0b7aca7ad214cf42cca3ece354d01b9023c560eabdbcaed210f9016d4b1cdc/9.6.6/lib/x86_64-linux-ghc-9.6.6/my-xmonad-0.1.0.0-B3m9BBkUoFH4FfwdcZ41F6-my-xmonad"
dynlibdir  = "/home/ryan/.xmonad/.stack-work/install/x86_64-linux/8c0b7aca7ad214cf42cca3ece354d01b9023c560eabdbcaed210f9016d4b1cdc/9.6.6/lib/x86_64-linux-ghc-9.6.6"
datadir    = "/home/ryan/.xmonad/.stack-work/install/x86_64-linux/8c0b7aca7ad214cf42cca3ece354d01b9023c560eabdbcaed210f9016d4b1cdc/9.6.6/share/x86_64-linux-ghc-9.6.6/my-xmonad-0.1.0.0"
libexecdir = "/home/ryan/.xmonad/.stack-work/install/x86_64-linux/8c0b7aca7ad214cf42cca3ece354d01b9023c560eabdbcaed210f9016d4b1cdc/9.6.6/libexec/x86_64-linux-ghc-9.6.6/my-xmonad-0.1.0.0"
sysconfdir = "/home/ryan/.xmonad/.stack-work/install/x86_64-linux/8c0b7aca7ad214cf42cca3ece354d01b9023c560eabdbcaed210f9016d4b1cdc/9.6.6/etc"

getBinDir     = catchIO (getEnv "my_xmonad_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "my_xmonad_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "my_xmonad_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "my_xmonad_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_xmonad_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_xmonad_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
