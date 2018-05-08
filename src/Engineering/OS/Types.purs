module OS.Types where 


import Data.Foreign.Class (class Decode, class Encode)
import Data.Generic.Rep (class Generic)
import Data.Newtype (class Newtype)
import Presto.Core.Utils.Encoding (defaultDecode, defaultEncode)

newtype PermissionData = PermissionData
  { isGranted :: Boolean
  , neverAskAgain :: Boolean
  , name :: String
  }

derive instance genericPermissionData  :: Generic PermissionData _
derive instance newtypepermissionData :: Newtype PermissionData _
instance encodePermissionData :: Encode PermissionData where
  encode = defaultEncode
instance decodegenericPermissionData :: Decode PermissionData where
  decode = defaultDecode
