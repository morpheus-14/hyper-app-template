module UI.Types where

import Control.Monad.Eff.Exception (Error)
import Data.Foreign.Class (class Decode, class Encode)
import Data.Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Data.Generic.Rep (class Generic)
import Presto.Core.Flow (class Interact, defaultInteract)
import Presto.Core.Types.API (defaultMakeRequest)
import Presto.Core.Utils.Encoding (defaultDecode, defaultEncode)
import Data.Newtype (class Newtype)

data SplashScreen = SplashScreen

data SplashScreenAction = ShowLoader Int

data LoaderScreen = LoaderScreen

data LoaderScreenAction = LoaderExit

instance splashScreenInteract :: Interact Error SplashScreen SplashScreenAction where
  interact x = defaultInteract x

derive instance genericSplashScreen :: Generic SplashScreen _
instance encodeSplashScreen :: Encode SplashScreen where
  encode = genericEncode defaultOptions
instance decodeSplashScreen :: Decode SplashScreen where
  decode = genericDecode defaultOptions

derive instance genericSplashScreenAction :: Generic SplashScreenAction _
instance encodeSplashScreenAction :: Encode SplashScreenAction where
  encode = genericEncode defaultOptions
instance decodeSplashScreenAction :: Decode SplashScreenAction where
  decode = genericDecode defaultOptions
