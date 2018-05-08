module UI.Views.Components.ProductListItem where
  
import Data.Array
import Engineering.Helpers.Commons
import Prelude
import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Properties.GetChildProps
import PrestoDOM.Properties.SetChildProps
import PrestoDOM.Types.Core
import UI.Controllers.Components.ProductListItem

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Array ((..), snoc)
import Data.StrMap (StrMap(..)) as StrMap
import Data.StrMap (fromFoldable)
import Data.Tuple (Tuple(..))
import Debug.Trace (spy)
import FRP (FRP)
import Halogen.VDom.DOM.Prop (Prop(..), PropValue)
import Simple.JSON (writeJSON)
import Unsafe.Coerce (unsafeCoerce)

view :: forall w eff
	. (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
    -> StrMap.StrMap GenProp 
	-> PrestoDOM Action w
view push state props =
    linearLayout
    [ width MATCH_PARENT
    , height $ V 100
    , padding $ PaddingHorizontal 20 20
    , orientation VERTICAL
    ]
    [ linearLayout
        [ width MATCH_PARENT
        , height $ V 99
        , orientation HORIZONTAL
        , padding $ PaddingVertical 20 20
        , gravity CENTER_VERTICAL
        ]
        [ linearLayout
            [ width  $ V 48
            , height $ V 48
            , margin $ MarginRight 10
            , background_p "#112233" props
            , cornerRadius 10.0
            ] []
        , linearLayout
            [ width  $ V 0
            , height MATCH_PARENT
            , orientation VERTICAL
            , gravity TOP_VERTICAL
            , weight "1"
            , padding $ PaddingTop 5
            ]
            [ textView
                [ width  MATCH_PARENT
                , height $ V 24
                , gravity CENTER_VERTICAL
                , textSize 16
                , text state.itemName
                ]
            , textView
                [ width  MATCH_PARENT
                , height $ V 20
                , gravity CENTER_VERTICAL
                , textSize 12
                , text state.itemDesc
                ]
            ]
        , textView
            [ width  $ V 60
            , height $ V 24
            , gravity TOP_VERTICAL
            , text $ "Rs." <> show state.itemCost
            ]
        ]
        , linearLayout
            [ width  MATCH_PARENT
            , height $ V 1
            , background "#333333"
            , alpha 0.3 ] []
    ]
    