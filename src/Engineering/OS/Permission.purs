module Engineering.OS.Permission where

import Control.Monad.Aff (Canceler(..), makeAff, nonCanceler)
import Control.Monad.Eff.Exception (Error, error)
import Control.Monad.Except (runExcept, throwError)
import Data.Array (zip)
import Data.Either (Either(..))
import Data.Foreign.Generic (decodeJSON)
import Data.Function.Uncurried (Fn4, runFn4)
import Data.List (List(..), all, fromFoldable, (:))
import Data.List (fromFoldable)
import Data.Newtype (class Newtype, unwrap)
import Data.Tuple (Tuple(..))
import Engineering.Types.App (EffStorage, AffStorage)
import OS.Types (PermissionData)
import Prelude (class Applicative, class Bind, Unit, bind, ifM, map, pure, show, ($), (<<<), (=<<), (==))
import Presto.Core.Types.App (STORAGE)
import Presto.Core.Types.Language.Flow (Flow, checkPermissions, takePermissions)
import Presto.Core.Types.Permission (Permission(PermissionWriteStorage, PermissionReadStorage, PermissionReadPhoneState, PermissionSendSms), PermissionResponse, PermissionStatus(PermissionDeclined, PermissionDeclinedForever, PermissionGranted))

foreign import getPermissionStatus' :: forall e sc er a b. Fn4 (Either Error String -> EffStorage e Unit) String (a -> Either er a) (b -> Either b sc) (EffStorage e (Canceler (storage :: STORAGE | e))) 
foreign import requestPermission' :: forall e sc er a b. Fn4 (Either Error String -> EffStorage e Unit) (Array String) (a -> Either er a) (b -> Either b sc) (EffStorage e (Canceler (storage :: STORAGE | e)))

toAndroidPermission :: Permission -> String
--toAndroidPermission PermissionCoarseLocation = ""
toAndroidPermission PermissionSendSms = "android.permission.READ_SMS"
toAndroidPermission PermissionReadPhoneState = "android.permission.READ_PHONE_STATE"
toAndroidPermission PermissionWriteStorage = "android.permission.WRITE_EXTERNAL_STORAGE"
toAndroidPermission PermissionReadStorage = "android.permission.READ_EXTERNAL_STORAGE"

allPermissionGranted :: Array PermissionResponse -> Boolean
allPermissionGranted = all (\(Tuple _ status) -> status == PermissionGranted)

getStoragePermission :: Flow Boolean
getStoragePermission =
  ifM (storageGranted) (pure true) (askForStorage)
  where
    storageGranted :: Flow Boolean
    storageGranted = do
       status <- checkPermissions [PermissionWriteStorage]
       case status of
        PermissionGranted -> pure true
        _ -> pure false
    askForStorage :: Flow Boolean
    askForStorage = pure <<< allPermissionGranted =<< takePermissions [PermissionWriteStorage]

storagePermissionGranted :: Flow Boolean
storagePermissionGranted = do
   status <- checkPermissions [PermissionWriteStorage]
   case status of
    PermissionGranted -> pure true
    _ -> pure false

getPermissionStatus :: forall e. Permission -> AffStorage e PermissionData
getPermissionStatus permission = do
  permissionStr <- makeAff (\cb -> runFn4 getPermissionStatus' cb (toAndroidPermission permission) Right Left)
  case (runExcept (decodeJSON permissionStr)) of
    Right x -> pure x
    Left err -> throwError (error (show err))

-- allMHelper :: forall a  m b.Monad m => Newtype b => (a -> m b) -> List a -> m b
allMHelper :: forall a m e b. Applicative m => Bind m => Newtype b
                                         { neverAskAgain :: Boolean
                                         , isGranted :: Boolean
                                         | e
                                         }
                                        => (a -> m b) -> List a -> m PermissionStatus
allMHelper _ Nil =  pure PermissionGranted

allMHelper fn (x:xs) = do
    val <- fn x
    if (_.neverAskAgain <<< unwrap) val then
        pure PermissionDeclinedForever
        else if(_.isGranted <<< unwrap)val then allMHelper fn xs else pure PermissionDeclined

checkIfPermissionsGranted :: forall e. Array Permission -> AffStorage e PermissionStatus
checkIfPermissionsGranted permissions = allMHelper getPermissionStatus $ fromFoldable permissions

requestPermissions :: forall e. Array Permission -> AffStorage e (Array PermissionResponse)
requestPermissions permissions = do
  response <- makeAff (\cb -> runFn4 requestPermission' cb jPermission Right Left)
  case runExcept $ decodeJSON response of
    Right (statuses :: Array PermissionData) -> pure $ zip permissions (map toResponse statuses)
    Left err -> throwError (error (show err))
  where
    toResponse wasGranted = if (_.isGranted <<< unwrap) wasGranted then PermissionGranted else if (_.neverAskAgain <<< unwrap)wasGranted then PermissionDeclinedForever else PermissionDeclined
    jPermission = map toAndroidPermission permissions
