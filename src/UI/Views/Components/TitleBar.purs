module UI.Views.Components.TitleBar where

import Prelude
import Data.Array ((..),snoc)
import Unsafe.Coerce (unsafeCoerce)

import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Types.Core
import PrestoDOM.Properties.GetChildProps
import PrestoDOM.Properties.SetChildProps
import Halogen.VDom.DOM.Prop (Prop(..),PropValue)
import UI.Controllers.Components.TitleBar

import Control.Monad.Eff (Eff)
import DOM (DOM)
import FRP (FRP)
import Data.StrMap (StrMap(..)) as StrMap

import Data.StrMap (fromFoldable)
import Data.Tuple (Tuple(..))
import Engineering.Helpers.Commons
import Data.Array
import Simple.JSON (writeJSON)

view :: forall w eff
	. (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
    -> StrMap.StrMap GenProp 
	-> PrestoDOM Action w
view push state props =
    linearLayout
    [ width MATCH_PARENT
    , height $ V 60
    , orientation HORIZONTAL
    , padding $ Padding 20 10 20 10
    , gravity CENTER_VERTICAL
    ]
    [ linearLayout
        [ width  $ V 40
        , height $ V 40
        , margin $ MarginRight 10
        , background "#112233"
        ] []
    , textView
        [ width  $ V 0
        , height $ V 40
        , weight "1"
        , textSize 20
        , text_p "Test" props
        ]
    , linearLayout
        [ width  $ V 40
        , height $ V 40
        , background "#332211"
        ] []
    ]
    