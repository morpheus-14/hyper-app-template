
module Product.Onboarding.Flow where

import Prelude
import Control.Monad.Eff.Class (liftEff)
import Engineering.Helpers.Commons
import Engineering.Types.App (FlowBT)
import Product.Onboarding.Types (ScreenFailure)
import Remote.Flow as Remote
import UI.Flow as UI
import Storage as K
import UI.Types
import Presto.Core.Flow (delay , doAff)
import Control.Monad.Except.Trans (lift)
import Data.Time.Duration (Milliseconds (..))
import Debug.Trace (spy)
import Engineering.Helpers.Commons

onBoardingFlow :: FlowBT ScreenFailure Unit
onBoardingFlow = do
    result <- UI.splashScreen "START"
    case result of
        (ShowLoader ind) -> do
                                _ <- UI.loaderScreen ind
                                pure unit
        _ -> pure unit
    pure unit