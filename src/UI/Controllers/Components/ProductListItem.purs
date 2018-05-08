module UI.Controllers.Components.ProductListItem where
  
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
	= Selected | Unselected


type State = { itemName :: String
             , itemDesc :: String
             , itemCost :: Number
             , selected :: Boolean
             }

initialState :: State
initialState = { itemName: ""
               , itemDesc: ""
               , itemCost: 0.0
               , selected: false }

eval
	:: Action
	-> State 
	-> State
eval Selected state = state { selected =  true }
eval Unselected state = state { selected =  false }


overrides
	:: forall i eff
	. String
	-> (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> Props i
overrides _ push state = []


