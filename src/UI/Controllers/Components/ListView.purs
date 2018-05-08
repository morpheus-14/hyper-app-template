module UI.Controllers.Components.ListView where

import Data.Array
import Data.Maybe
import Prelude
import PrestoDOM.Types.DomAttributes

import Control.Monad.Aff.Console (logShow)
import Data.Either (Either(..))
import Debug.Trace (spy)
import Engineering.Helpers.Commons (logMe)

data ListType = SingleSelect
              | MultiSelect Int Int
              | MinimumRequired Int

data Action = Selected Int
type Label = String

type ListProperty =
	{ listSelected :: Boolean
    , listText :: String
	, listIsNew :: Boolean
	}

listDefault :: ListProperty
listDefault =
    { listSelected : false
    , listText : ""
	, listIsNew : false
    }

type State =
    { list :: Array ListProperty
    , listType :: ListType
    }

initialState :: Array ListProperty -> State
initialState list =
    { list : list
    , listType : SingleSelect
    }

filterEntry :: Array ListProperty -> String
filterEntry listt = do
	let fR = filter (\x -> x.listSelected == true) listt
	case length fR of
		0 -> ""
		_ -> do
			let filterRecord = fromMaybe listDefault $ (fR !! 0)
			filterRecord.listText


eval :: Action -> State -> State
eval (Selected index) state = state {list = mapWithIndex (\idx x -> if idx == index then x {listSelected = true} else x {listSelected = false}) state.list}
