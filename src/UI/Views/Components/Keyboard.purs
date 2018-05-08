module UI.Views.Components.Keyboard where

import Prelude
import Data.Array ((..),snoc)
import Unsafe.Coerce (unsafeCoerce)

import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Types.Core
import PrestoDOM.Properties.GetChildProps (fromGenProp)
import PrestoDOM.Properties.SetChildProps
import Halogen.VDom.DOM.Prop (Prop(..),PropValue)

import Control.Monad.Eff (Eff)
import DOM (DOM)
import FRP (FRP)
import Data.StrMap (StrMap(..)) as StrMap

import UI.Views.Components.KeyValue as KeyValue
import UI.Controllers.Components.Keyboard (KeyboardAction(..), State, initialState, eval, overrides)
import Data.StrMap (fromFoldable)
import Data.Tuple (Tuple(..))
import Engineering.Helpers.Commons
import Data.Array
import Simple.JSON (writeJSON)

propToString :: PropValue -> String
propToString = unsafeCoerce

row :: forall w eff. (KeyboardAction -> Eff (frp :: FRP | eff) Unit) -> State ->  String -> String -> Int -> PrestoDOM KeyboardAction w
row push state background color rowIndex = 
    linearLayout
    [   
        height $ V 64
        , width MATCH_PARENT
        , orientation HORIZONTAL
        , gravity CENTER_VERTICAL
        , margin $ MarginRight 1
    ]
    (map (\i -> mapDom KeyValue.view push {value : (show i) } KeyValueAction [ background_c background, color_c color]) (((add (mul 3 (sub rowIndex 1))) 1) .. (mul 3 rowIndex)))

view :: forall w eff. (KeyboardAction -> Eff (frp :: FRP | eff) Unit) -> State -> StrMap.StrMap GenProp -> PrestoDOM KeyboardAction w
view push state parent = do
    let keyboardBackground = case (fromGenProp "background" "#FFFFFF" parent) of
                                (Property _ val) -> propToString val
                                _ -> "#FFFFFF"
    let keyColor = case (fromGenProp "color" "#00ffffff" parent) of
                                (Property _ val) -> propToString val
                                _ -> "#00ffffff"
    let backImage = if(keyboardBackground == "#FFFFFF")
                        then "ic_icon_back"
                        else "ic_icon_back_white"

    linearLayout
        [ height $ V 260
        , width MATCH_PARENT
        , orientation VERTICAL
        , gravity CENTER_HORIZONTAL
        , background keyboardBackground
        , visibility VISIBLE
        ]
        ((map (row push state keyboardBackground keyColor) (1 .. 3)) <> ([linearLayout
                [ height $ V 64
                , width MATCH_PARENT
                , margin $ Margin 0 0 1 0
                ]
                [ linearLayout
                    ([ height $ V 64
                    , width $ V 120 
                    , gravity CENTER
                    ] <> overrides "BackButton" push state)
                    [ 
                        imageView
                            [ height $ V 24
                            , width $ V 48 
                            , imageUrl backImage
                            ] 
                        
                    ]
                , (mapDom KeyValue.view push {value : "0" } KeyValueAction [ background_c keyboardBackground, color_c keyColor ])
                , linearLayout
                    ([ height $ V 64
                    , width $ V 120
                    , gravity CENTER
                    ] <> overrides "NextButton" push state)
                    [ 
                        imageView
                            [ height $ V 64
                            , width $ V 64 
                            , imageUrl "ic_icon_next"
                            ] 
                        
                    ]
                ]
            ])
        )