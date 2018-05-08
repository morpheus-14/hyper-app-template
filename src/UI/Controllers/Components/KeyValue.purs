module UI.Controllers.Components.KeyValue where

import Prelude
import PrestoDOM.Core
import Data.Either (Either(..))
import PrestoDOM.Types.Core
import Control.Monad.Eff (Eff)
import FRP (FRP)
import Engineering.Helpers.Commons


type ScreenInput = String

type ScreenOutput = String

data Action
	= ValueChanged String


type State = {value :: String}

initialState :: State
initialState = {value : ""}

eval
	:: Action
	-> State 
	-> State
eval (ValueChanged value)  state = state { value = value }


overrides
	:: forall i eff
	. String
	-> (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> Props i
overrides _ push state = []


