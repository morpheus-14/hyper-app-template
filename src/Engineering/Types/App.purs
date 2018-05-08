
module Engineering.Types.App where

import Prelude (pure, ($), (<$>), (<<<))
import Data.Newtype (class Newtype)
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (kind Effect, Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Except.Trans (ExceptT(..))
import Control.Monad.Free (Free)
import Control.Transformers.Back.Trans (BackT(..), FailBack(..))
import Data.Either (Either(..))
import Data.Foreign.Class (class Decode, class Encode)
import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Generic.Rep (class Generic)
import Presto.Core.Types.App (LOCAL_STORAGE, NETWORK, STORAGE, UI)
import Presto.Core.Types.Language.Flow (Flow, FlowWrapper)
import Presto.Core.Utils.Encoding (defaultDecode, defaultEncode)
import FRP (FRP)
import DOM (DOM)
import Control.Monad.Eff.Timer (TIMER) as T

foreign import data TIMER :: Effect

type AppEffects =    ( dom :: DOM
    , frp :: FRP
    , avar :: AVAR
    , console :: CONSOLE
    , exception :: EXCEPTION
    , exception :: EXCEPTION
    , ls :: LOCAL_STORAGE
    , network :: NETWORK
    , storage :: STORAGE
    , ui :: UI
    , timer :: T.TIMER
    )

type CancelerEffects = ( dom :: DOM
    , frp :: FRP
    , avar :: AVAR
    , console :: CONSOLE
    , exception :: EXCEPTION
    , ls :: LOCAL_STORAGE
    , network :: NETWORK
    , storage :: STORAGE
    , ui :: UI
    , timer :: T.TIMER
    )


type EffStorage e = Eff (storage :: STORAGE | e)
type AffStorage e = Aff (storage :: STORAGE | e)

type FlowE e a = (ExceptT e (Free FlowWrapper) a)

type FlowBT e a = BackT (ExceptT e (Free FlowWrapper)) a

liftNoBack :: forall a e. Flow a -> FlowBT e a
liftNoBack flow = BackT <<< ExceptT $ (Right <<< NoBack) <$> flow

liftGoBack :: forall a e. FlowBT e a
liftGoBack = BackT <<< ExceptT $ (pure <<< Right) GoBack

type DeviceRec = {
  deviceId :: NullOrUndefined String
, manufacturer :: NullOrUndefined String
, model :: NullOrUndefined String
, os :: NullOrUndefined String
, packageName :: NullOrUndefined String
, version :: NullOrUndefined String
, appVersion :: NullOrUndefined String
, bundleVersion :: NullOrUndefined String
, configVersion :: NullOrUndefined String
, rootCheckStrategies :: NullOrUndefined RootCheckStrategies
, simOperators :: NullOrUndefined (Array String)
}

newtype RootCheckStrategies = RootCheckStrategies {
  buildTagStrategy :: NullOrUndefined Boolean
, pathStrategy :: NullOrUndefined Boolean
}

derive instance genericRootCheckStrategies :: Generic RootCheckStrategies _
instance decodeRootCheckStrategies :: Decode RootCheckStrategies where decode = defaultDecode
instance encodeRootCheckStrategies :: Encode RootCheckStrategies where encode = defaultEncode

newtype Device = Device DeviceRec

derive instance genericDevice :: Generic Device _
derive instance newtypeDevice :: Newtype Device _
instance decodeDevice :: Decode Device where decode = defaultDecode
instance encodeDevice :: Encode Device where encode = defaultEncode
