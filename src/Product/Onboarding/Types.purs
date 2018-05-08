module Product.Onboarding.Types where

import Prelude
import Data.Foreign.NullOrUndefined (NullOrUndefined(..))
import Control.Monad.Eff.Exception (Error)
import Data.Foreign.Class (class Decode, class Encode)
import Data.Foreign.Generic (defaultOptions, genericEncode)
import Data.Generic.Rep (class Generic)
import Presto.Core.Utils.Encoding (defaultDecode)
import Data.Generic.Rep.Show (genericShow)
import Data.Newtype (class Newtype)
import Presto.Core.Types.API (ErrorPayload, ErrorResponse)

data ScreenFailure =
  FetchOperatorFailure String
  | APIError ErrorResponse
  | UserAbort
  | CLFailure ErrorPayload
  | SmsFailure FailureReasons

data FailureReasons =
  GenericFailure
  | NullPDUFailure
  | AirplaneModeFailure
  | NoServiceFailure

derive instance genericScreenFailure :: Generic ScreenFailure _
instance showScreenFailure :: Show ScreenFailure where show = genericShow

derive instance  genericScreenFailureType ::Generic FailureReasons _
instance showFailureReasons  :: Show FailureReasons where show = genericShow

