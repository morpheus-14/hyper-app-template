module Remote.APIHelper where

import Prelude (bind, flip, pure, ($), (<$>), (<<<), (<>))

import Control.Monad.Except.Trans (lift, throwError)
import Control.Transformers.Back.Trans (BackT(..), FailBack(..))
import Data.Array (concatMap)
import Data.Either (Either(..))
import Data.Foreign (Foreign)
import Data.Generic.Rep (class Generic)
import Presto.Core.Flow (class Interact, defaultInteract)
import Presto.Core.Utils.Encoding (defaultDecode)
import Data.Foreign.Class (class Decode, class Encode, encode, decode)
import Data.List (List(..), fromFoldable)
import Data.Map hiding (fromFoldable)
import Data.StrMap hiding (fromFoldable)
import Data.Tuple (Tuple(..))
import Engineering.Helpers.Commons (defaultHeaders)
import Engineering.Types.App (FlowBT)
import Global (encodeURIComponent)
import Control.Monad.Except
import Presto.Core.Flow (callAPI)
import Presto.Core.Types.API (class RestEndpoint, Headers, Method, Request(Request), URL, makeRequest)
import Product.Onboarding.Types (ScreenFailure(..))
import Data.StrMap (StrMap)

foreign import toKeyVals' :: forall a. a -> Array ({key :: String, val :: String})
foreign import getErrorScreenType' :: String -> Foreign

getErrorScreenType :: String ->  ErrorScreenType
getErrorScreenType errorCode = do
  case runExcept $ decode $ getErrorScreenType' errorCode of
    Right val -> val
    Left err -> SNACKBAR ""

-- Converts a type to Array of Key value pairs (using toKeyVal')
toKeyVals :: forall a. Encode a => a -> Array (Tuple String String)
toKeyVals a = concatMap (\a -> [Tuple a.key a.val]) (toKeyVals' $ encode a)

-- Converts a type (record) to a urlEncoded string
urlEncode :: forall a. Encode a => a -> String
urlEncode = toUrlEncoded <<< fromFoldable <<< toKeyVals
  where toUrlEncoded :: List (Tuple String String) -> String
        toUrlEncoded Nil = ""
        toUrlEncoded (Cons (Tuple key val) Nil) = encodeVal key val
        toUrlEncoded (Cons (Tuple key val) as) = encodeVal key val <> "&" <> toUrlEncoded as

        encodeVal :: String -> String -> String
        encodeVal x y = encodeURIComponent x <> "=" <> encodeURIComponent y

-- Takes a request type and converts it to a urlEncoded string.
urlEncodedMakeRequest :: forall a. Encode a => Method -> URL -> Headers -> a -> Request
urlEncodedMakeRequest method url headers req = Request
  { method
  , url: url <> urlEncode req
  , headers
  , payload: ""
  }

mkRestClientCall :: forall a b. Encode a => Decode b => RestEndpoint a b => a -> Headers -> FlowBT ScreenFailure (Either ScreenFailure b)
mkRestClientCall req headers = do
 result <- lift $ lift $ callAPI headers req
 case result of
  Left err -> BackT $ NoBack <$> (pure <<< Left) (APIError err)
  Right r -> BackT $ NoBack <$> (pure <<< Right) r

mkAPICall :: forall a b. Encode a => Decode b => RestEndpoint a b => a -> FlowBT ScreenFailure (Either ScreenFailure b)
mkAPICall = flip mkRestClientCall defaultHeaders

data ErrorScreenType = SNACKBAR String | POPUP (StrMap String) | NOINTERNET | Nill

derive instance genericErrorScreenType :: Generic ErrorScreenType _
instance decodeErrorScreenType :: Decode ErrorScreenType where 
  decode = defaultDecode
