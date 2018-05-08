module Main where


import Debug.Trace
import UI.Types

import Control.Monad.Aff (Canceler, launchAff_, makeAff, nonCanceler)
import Control.Monad.Aff.AVar (makeVar)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (log)
import Control.Monad.Except.Trans (runExceptT)
import Control.Monad.State.Trans as S
import Control.Transformers.Back.Trans (runBackT)
import Data.Either (Either(..))
import Data.Function.Uncurried (runFn2)
import Data.StrMap (empty)
import Engineering.Helpers.Commons (callAPI', logAny, mkNativeRequest, showUI')
import Engineering.OS.Permission (checkIfPermissionsGranted, requestPermissions)
import Engineering.Types.App (AppEffects, CancelerEffects)
import Prelude (Unit, bind, discard, pure, unit, ($), (*>), (<<<), (>>>), (>>=))
import Presto.Core.Flow (APIRunner, Flow, PermissionCheckRunner, PermissionRunner(PermissionRunner), PermissionTakeRunner, Runtime(Runtime), UIRunner, doAff, initUI, run, showUI)
import Product.Onboarding.Flow (onBoardingFlow)

main :: Eff (AppEffects) Unit
main = do
  let runtime = Runtime uiRunner permissionRunner apiRunner
  let freeFlow = S.evalStateT (run runtime appFlow)
  launchAff_ (makeVar empty >>= freeFlow)
  where
    uiRunner :: UIRunner
    uiRunner a = makeAff (\cb -> runFn2 showUI' (Right >>> cb) a *> (pure nonCanceler))

    permissionCheckRunner :: PermissionCheckRunner
    permissionCheckRunner = checkIfPermissionsGranted

    permissionTakeRunner :: PermissionTakeRunner
    permissionTakeRunner = requestPermissions

    permissionRunner :: PermissionRunner
    permissionRunner = PermissionRunner permissionCheckRunner permissionTakeRunner

    apiRunner :: APIRunner
    apiRunner request = makeAff (\cb -> callAPI' (Left >>> cb) (Right >>> cb) (mkNativeRequest request) *> (pure nonCanceler))

appFlow :: Flow Unit
appFlow = do
  _ <- initUI
  appFlowImpl

appFlowImpl :: Flow Unit
appFlowImpl = do
  result <- (runExceptT <<< runBackT) $ onBoardingFlow
  case result of
    Right a -> pure unit
    Left a -> appFlowImpl
