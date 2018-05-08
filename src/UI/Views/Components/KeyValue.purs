module UI.Views.Components.KeyValue where

import Prelude
import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Types.Core

import Control.Monad.Eff (Eff)
import DOM (DOM)
import FRP (FRP)
import Data.StrMap (StrMap(..)) as StrMap
import PrestoDOM.Properties.GetChildProps
import PrestoDOM.Properties.SetChildProps

import UI.Controllers.Components.KeyValue (Action(..), State, initialState, eval, overrides)

view :: forall w eff. (Action -> Eff (frp :: FRP | eff) Unit) -> State -> StrMap.StrMap GenProp -> PrestoDOM Action w
view push state parent = do 
    linearLayout
        [ height $ V 64
        , width $ V 119 
        , orientation HORIZONTAL
        , gravity CENTER
        , background_p "#ffffffff" parent 
        , weight "0" 
        , onClick push (const (ValueChanged state.value))
        ]
        [ textView
            [ height $ V 64
            , width MATCH_PARENT
            , text state.value
            , textSize 38 
            , color_p "#ff000000" parent
            , gravity CENTER
            ]
        ]