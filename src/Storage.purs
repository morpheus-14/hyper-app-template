module Storage where

import Presto.Core.Types.Language.Storage (Key)

-- | Whenever you add a key in this file, add it to the `allKeys` array without fail

registrationTokenIdKey :: Key
registrationTokenIdKey = "registrationTokenId"

loginTokenKey :: Key
loginTokenKey = "loginToken"

directTokenKey :: Key
directTokenKey = "directToken"

language :: Key
language = "language"

userEducatedKey :: Key
userEducatedKey = "userEducated"

userOnboarded :: Key
userOnboarded = "userOnboarded"

passcodeSet :: Key
passcodeSet = "passcodeSet"

accountExists :: Key
accountExists = "accountExists"

registrationDeviceId :: Key
registrationDeviceId = "registrationDeviceId"

registrationDeviceIdExpiry :: Key
registrationDeviceIdExpiry = "registrationDeviceIdExpiry"

registrationDeviceIdCreatedAt :: Key
registrationDeviceIdCreatedAt  = "registrationDeviceIdCreatedAt"

-- passcodeSet :: Key
-- passcodeSet = "passcodeSet"

registrationDeviceContent :: Key
registrationDeviceContent  = "registrationDeviceContent"

defaultVal :: Key
defaultVal = "__failed"

mobileNumber :: Key
mobileNumber = "mobileNumber"

directTokenExpiryKey :: Key
directTokenExpiryKey = "directTokenExpiry"

accountNumber :: Key
accountNumber = "accountNumber"

passcode :: Key
passcode = "passcode"

primaryVpa :: Key
primaryVpa = "primaryVpa"

ussdState :: Key
ussdState = "ussdState"

agents :: Key
agents = "agents"
-- | This array is used to clear all data(local storage and state) for the specified keys
-- | Language and userEducated are exempted so don't add them to the array
-- | Maintain the sorted order while adding a new key to the array
allKeys :: Array Key
allKeys =
  [ accountNumber
  , agents
  , directTokenExpiryKey
  , directTokenKey
  , loginTokenKey
  , mobileNumber
  , passcode
  , registrationDeviceContent
  , registrationDeviceId
  , registrationDeviceIdCreatedAt
  , registrationDeviceIdExpiry
  , registrationTokenIdKey
  , primaryVpa
  , ussdState
  , passcodeSet
  , accountExists
  , userOnboarded
  ]
