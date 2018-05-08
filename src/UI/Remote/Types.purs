module Remote.Types where


import Config (getBaseUrl)
import Control.Monad.Eff (Eff)
import Data.Foreign.Class (class Decode, class Encode)
import Data.Foreign.Generic (genericDecode, genericEncode)
import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Generic.Rep (class Generic)
import Data.Interval.Duration.Iso (Error)
import Data.Newtype (class Newtype)
import Prelude
import Presto.Core.Types.API (class RestEndpoint, Method(..), decodeResponse, defaultDecodeResponse, defaultMakeRequest, defaultMakeRequest_, makeRequest)
import Presto.Core.Utils.Encoding (defaultDecode, defaultEncode)

import Control.Monad.Eff (Eff)
import Presto.Core.Types.Language.Flow (FlowWrapper(..))
import Presto.Core.Flow (doAff, Flow)
import Engineering.Types.App (AppEffects, CancelerEffects)
import Control.Monad.Aff (launchAff, makeAff, Canceler)

type AffSuccess s = (s -> Flow Unit)
type Route a b = (String -> String -> {|a} -> (AffSuccess ({|b})) -> Eff (AppEffects) (Canceler (CancelerEffects)))