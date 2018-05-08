module UI.Views.Screens.LoaderScreen where

import Engineering.Helpers.Commons
import Prelude
import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Properties.SetChildProps
import PrestoDOM.Types.Core
import PrestoDOM.Types.DomAttributes
import UI.Controllers.Screens.LoaderScreen

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Array ((..))
import Data.Foreign.Generic (encodeJSON)
import Data.Int (toNumber)
import Data.Monoid (mempty)
import Data.StrMap (fromFoldable)
import Data.Tuple (Tuple(..))
import Debug.Trace (spy)
import FRP (FRP)
import FRP.Behavior (sample)
import Halogen.VDom (Machine)
import Halogen.VDom.DOM.Prop (Prop)
import Math (cos, sin, pi, pow)
import Simple.JSON (writeJSON)
import UI.Types (LoaderScreenAction)
import UI.Views.Components.ListView as ListView
import UI.Views.Components.TitleBar as TitleBar

screen :: forall eff. ScreenInput -> Screen Action State eff LoaderScreenAction
screen input =
	{ initialState: initialState input
	, view
	, eval
	}

view :: forall w eff
	. (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> PrestoDOM Action w
view push state =
    linearLayout
    [ width MATCH_PARENT
    , height MATCH_PARENT
    , orientation VERTICAL
    , gravity CENTER
    ]
    [ linearLayout
        [ width  $ V 100
        , height $ V 100
        , background "#FF2288"] []
    ]