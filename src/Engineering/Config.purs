module Config where

import Data.Foreign.Class (class Decode, class Encode)
import Data.Generic.Rep (class Generic)
import Prelude ((<>))
import Presto.Core.Utils.Encoding (defaultDecode, defaultEncode)

runnerEnv :: String
runnerEnv = "SANDBOX"

newtype Config = Config
  { protocol :: String
  , host :: String
  }

derive instance genericConfig :: Generic Config _
instance decodeConfig :: Decode Config where
  decode = defaultDecode
instance encodeConfig :: Encode Config where
  encode = defaultEncode

getConfig :: String -> Config
getConfig "SANDBOX" = Config
    { protocol : "http"
    , host: "galileo-beta-env.ap-south-1.elasticbeanstalk.com"
    }

getConfig "UAT" = Config
    { protocol : "http"
    , host: "103.14.161.204:8080"
    }

getConfig "PROD" = Config
    { protocol : "https"
    , host: "upi.npci.org.in"
    }

getConfig _ = Config
    { protocol : ""
    , host: ""
    }

getBaseUrl :: String
getBaseUrl =
  let
    envVar = runnerEnv
    Config config = getConfig envVar
  in
    config.protocol <> "://" <> config.host
