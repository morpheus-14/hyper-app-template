module UI.Flow where


import Control.Transformers.Back.Trans (BackT(..), FailBack(..))
import Engineering.Helpers.Commons (liftRunUI',liftRunUI'')
import Engineering.Types.App (FlowBT)
import Prelude
import Product.Onboarding.Types (ScreenFailure)
import UI.Views.Screens.SplashScreen as SplashScreen
import UI.Views.Screens.LoaderScreen as LoaderScreen
import UI.Types

splashScreen :: String -> FlowBT ScreenFailure SplashScreenAction
splashScreen helloText = liftRunUI' (SplashScreen.screen helloText)

loaderScreen :: Int -> FlowBT ScreenFailure LoaderScreenAction
loaderScreen ind = liftRunUI' (LoaderScreen.screen ind)