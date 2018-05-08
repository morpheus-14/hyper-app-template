module UI.Controllers.Screens.SplashScreen where

import Prelude
import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Types.Core
import PrestoDOM.Types.DomAttributes
import PrestoDOM.Utils

import Engineering.Helpers.Commons

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Array (singleton)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import FRP (FRP)
import Halogen.VDom.DOM.Prop (Prop)
import UI.Controllers.Components.ListView as ListView
import UI.Controllers.Components.TitleBar as TitleBar
import UI.Types (SplashScreenAction(..))

type ScreenInput = String

data Action
	= SubmitPressed String
	| AnimChanged ListView.Action
	| BackPressed TitleBar.Action
	| FabClicked

type State =
	{ buttonText :: String
	, selectedAnim :: Maybe String }


initialState :: ScreenInput -> State
initialState input =
	{ buttonText: input
	, selectedAnim: Nothing }


eval 
	:: forall eff
	 . Action
	-> State 
	-> Eval eff Action SplashScreenAction State
eval action@(SubmitPressed animId) state = let _ = startAnim animId
											in continue state
eval action@(BackPressed a) state = continue state
eval action@(AnimChanged a) state = continue state
eval action@(FabClicked) state =  do
					let _ = startAnim "modal"
					let	a = startAnim "blur"
					let	b = startAnim "buttonFade"
					continue state

overrides
	:: forall i eff
	. String
	-> (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> Props Action
overrides _ push state = []