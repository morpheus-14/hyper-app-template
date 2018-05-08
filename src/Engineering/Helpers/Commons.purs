module Engineering.Helpers.Commons where

import Data.Foreign.Class
import Data.Newtype
import Prelude
import Product.Onboarding.Types

import Control.Monad.Aff (Canceler(..), makeAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (Error)
import Control.Monad.Except.Trans (ExceptT(..))
import Control.Monad.Trans.Class (lift)
import Control.Transformers.Back.Trans (BackT(..), FailBack(..))
import DOM (DOM)
import Data.Either (Either(..))
import Data.Foreign (Foreign)
import Data.Function.Uncurried (Fn2)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(Just, Nothing))
import Engineering.Types.App (FlowBT)
import Engineering.Types.App as App
import Presto.Core.Flow (runUI, doAff, Flow, oneOf, runScreen, forkScreen)
import Presto.Core.Types.API (Header(..), Headers(..), Request(..), URL)
import Presto.Core.Types.App (UI)
import Presto.Core.Types.Language.Interaction (class Interact)
import Presto.Core.Utils.Encoding (defaultDecode, defaultEncode)
import PrestoDOM (Screen)

foreign import showUI' :: forall e. Fn2 (String -> Eff (ui :: UI | e) Unit) String (Eff (ui :: UI | e) Unit)
foreign import callAPI' :: forall e. (AffError e) -> (AffSuccess String e) -> NativeRequest -> (Eff e Unit)
foreign import logAny' :: forall a eff. a -> Eff eff Unit
foreign import onBackPress' :: forall e er sc a b. (Either Error Unit -> Eff e Unit) -> (a -> Either a sc) -> (b -> Either er b) -> Eff e (Canceler e)
foreign import logMe :: forall a b. a -> b -> b
foreign import startAnimation :: String -> Unit
foreign import cancelAnimation :: String -> Unit
foreign import getScreenHeight' :: forall e. Eff e String
foreign import mkPureType :: forall a b .{|a} -> b
foreign import pxTodp :: Int -> Int
foreign import pxTodpF :: Number -> Number
foreign import _getValueFromWindowWithEff :: forall eff resp . (Maybe resp) -> (resp -> Maybe resp) -> String -> Eff eff (Maybe resp)
foreign import startAnim :: String -> Unit
foreign import cancelAnim :: String -> String -> Unit
foreign import updateAnim :: String -> String -> Unit

type NativeHeader = { field :: String , value :: String}
type NativeHeaders = Array NativeHeader
type AffError e = (Error -> Eff e Unit)
type AffSuccess s e = (s -> Eff e Unit)

newtype NativeRequest = NativeRequest
  { method :: String
  , url :: URL
  , payload :: String
  , headers :: NativeHeaders
  }


mkNativeRequest :: Request -> NativeRequest
mkNativeRequest (Request request@{headers: Headers hs}) = NativeRequest
                                          { method : show request.method
                                            , url: request.url
                                            , payload: request.payload
                                            , headers: mkNativeHeader <$> hs
                                            }

mkNativeHeader :: Header -> NativeHeader
mkNativeHeader (Header field val) = { field: field, value: val}

onBackPress :: forall a. Flow (FailBack a)
onBackPress = doAff do
 makeAff (\cb -> onBackPress' cb Left Right) *> pure GoBack

liftRunUI' :: forall action state s. (forall eff. Screen action state eff s) -> FlowBT ScreenFailure s
liftRunUI' a = BackT <<< ExceptT $ Right <$> (((<$>) id) <$> oneOf [ (BackPoint <$> runScreen a) , onBackPress ])

liftRunUI'' :: forall action state. (forall eff. Screen action state eff Unit) -> FlowBT ScreenFailure Unit
liftRunUI'' a = BackT <<< ExceptT $ Right <$> (((<$>) id) <$> oneOf [ (BackPoint <$> forkScreen a) , onBackPress ])

liftToFlowBT :: forall a . (forall eff. Eff eff a) -> FlowBT ScreenFailure a
liftToFlowBT val = lift $ lift $ doAff do liftEff val

defaultHeaders :: Headers
defaultHeaders = Headers [ Header "Content-Type" "application/json"]

logAny :: forall a. a -> FlowBT ScreenFailure Unit
logAny value = lift $ lift $ doAff do liftEff $ logAny' value

-- cancelAnimation :: String -> FlowBT ScreenFailure Number
-- cancelAnimation value = lift $ lift $ doAff do makeAff (\err sc -> cancelAnimation value sc)

getValueFromWindowWithEff :: forall eff resp . String -> Eff eff (Maybe resp)
getValueFromWindowWithEff = _getValueFromWindowWithEff Nothing Just