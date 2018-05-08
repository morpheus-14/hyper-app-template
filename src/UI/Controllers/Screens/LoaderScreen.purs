module UI.Controllers.Screens.LoaderScreen where

import Prelude
import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Types.Core
import PrestoDOM.Types.DomAttributes
import PrestoDOM.Utils

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
import UI.Types (LoaderScreenAction(..))

type ScreenInput = Int

data Action
	= RestartLoader
    | ChangeLoader

type State =
	{ index :: Int }


initialState :: ScreenInput -> State
initialState input =
	{ index : input }


eval 
	:: forall eff
	 . Action
	-> State 
	-> Eval eff Action LoaderScreenAction State
eval (RestartLoader) state = continue state
eval (ChangeLoader) state = exit (LoaderExit)

overrides
	:: forall i eff
	. String
	-> (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> Props Action
overrides _ push state = []