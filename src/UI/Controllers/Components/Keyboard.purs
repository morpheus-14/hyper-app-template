module UI.Controllers.Components.Keyboard where

import Prelude
import PrestoDOM.Core
import Data.Either (Either(..))
import PrestoDOM.Types.Core
import Control.Monad.Eff (Eff)
import FRP (FRP)
import PrestoDOM.Events
import Data.String as S
import Data.Maybe (fromMaybe)
import Engineering.Helpers.Commons
import Data.Array

import UI.Controllers.Components.KeyValue as KeyValue

type ScreenInput = String

type ScreenOutput = String

data KeyboardAction
	= KeyValueAction KeyValue.Action
	| NextButtonAction String
	| BackButtonAction String


type State = {oneState :: { value :: String}, length :: Int}


initialState :: Int -> State
initialState input = {oneState : {value:""}, length : input}

eval
	:: KeyboardAction
	-> State 
	-> State
eval (KeyValueAction action) state = onKeyboardChange state action
eval (NextButtonAction action) state = state 
eval (BackButtonAction action) state = backFunction state

backFunction :: State -> State
backFunction state = do
	if eq (S.length $ state.oneState.value) 0 
		then state
		else let cvvState = fromMaybe {before : "", after : ""} $ S.splitAt ((S.length state.oneState.value) - 1) state.oneState.value
			 in state { oneState {value = cvvState.before} }


onKeyboardChange :: State -> KeyValue.Action -> State
onKeyboardChange state action = do
	let oldState = state
	let temp = state {oneState = (KeyValue.eval action state.oneState)}
	let newState = temp { oneState { value = oldState.oneState.value <> temp.oneState.value } }
	case newState.oneState.value of
		_ ->  if (S.length $ newState.oneState.value) > state.length 
				then state
				else newState 
onKeyboardChange state _ = state 


overrides
	:: forall i eff
	. String
	-> (KeyboardAction -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> Props KeyboardAction
overrides "NextButton" push state = [onClick push (const $ NextButtonAction "next")]
overrides "BackButton" push state = [onClick push (const $ BackButtonAction "back")]
overrides _ push state = []


