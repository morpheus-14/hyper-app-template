module UI.Controllers.Components.TitleBar where
  
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
	= BackPressed


type State = { }

initialState :: State
initialState = { }

eval
	:: Action
	-> State 
	-> State
eval BackPressed state = state


overrides
	:: forall i eff
	. String
	-> (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> Props i
overrides _ push state = []


