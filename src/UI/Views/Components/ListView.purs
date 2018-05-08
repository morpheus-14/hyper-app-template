module  UI.Views.Components.ListView where

import Prelude
import PrestoDOM.Elements.Elements
import PrestoDOM.Properties
import PrestoDOM.Types.Core
import PrestoDOM.Types.DomAttributes

import Control.Monad.Cont (runCont)
import Control.Monad.Cont.Trans (ContT(ContT))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import DOM (DOM)
import DOM.HTML.HTMLElement (offsetHeight)
import Data.Array (mapWithIndex)
import Data.Maybe (Maybe(..))
import Data.Set (properSubset)
import Data.StrMap (StrMap, lookup)
import FRP (FRP)
import PrestoDOM.Events (onChange, onClick)
import PrestoDOM.Types.Core (GenProp, PrestoDOM, VDom)
import UI.Controllers.Components.ListView

-- type Rec eff =
--   { push :: Action -> Eff (frp :: FRP | eff) Unit
--   , state :: State
--   , props :: StrMap String
--   , index :: Int
--   , item :: ListProperty
--   }

-- contFunc :: forall r m. ContT r m Unit
-- contFunc = ContT (\f -> f unit)

-- getRec :: forall a eff.
--   (Action -> Eff (frp :: FRP | eff) Unit)
--   -> State
--   -> StrMap String
--   -> Int
--   -> ListProperty
--   -> a
--   -> Rec eff
-- getRec push state props index item u = {push, state, props, index, item}

-- defaultView :: forall a. (Unit -> a) -> a
-- defaultView = runCont contFunc

-- radioImage :: Boolean -> String
-- radioImage true = "ic_radio_button_active"
-- radioImage false = "ic_radio_button_inactive"

-- checkImage :: Boolean -> String
-- checkImage true = "ic_tick"
-- checkImage false = "ic_empty"

-- itemImage :: StrMap String -> ListProperty -> String
-- itemImage props item =
--   case lookup "layout" props of
--     Just _ -> do
--       if item.listSelected == true then radioImage item.listSelected else checkImage item.listSelected
--     Nothing -> ""

-- itemAction :: forall a. Int -> StrMap String -> a -> Action
-- itemAction index props =
--   const $ case lookup "layout" props of
--     _ -> Selected index

-- addAction :: forall eff i w
-- 	. (Action -> Eff (frp :: FRP | eff) Unit)
--   -> Int
--   -> StrMap GenProp 
--   -> Array (VDom (Array (Prop i)) w)
-- addAction push index props =
--   case lookup "type" props of
--     Just (SingleSelect) -> [onClick push $ const $ Selected index]
--     Just (MultiSelect min max) -> [onClick push $ const $ Selected index]
--     Just (MinimumRequired min) -> [onClick push $ const $ Selected index]
--     _ -> []

-- listItem :: forall w eff.
--   (Unit -> Rec eff)
--   -> PrestoDOM Action w
-- listItem f = let {push, state, props, index, item} = defaultView f in
--   linearLayout
--   ([ height $ V 100
--   ,  width MATCH_PARENT
--   , orientation VERTICAL
--   , gravity CENTER_HORIZONTAL
--   , padding $ Padding 0 19 0 0
--   , background "#FFFFFF"
--   , cornerRadius 0.0
--   ] <> (addAction push index props))
--   [ linearLayout
--       [ height $ V 24
--       , width MATCH_PARENT
--       , orientation HORIZONTAL
--       , margin $ Margin 12 0 12 0
--       , weight "1"
--       ]
--       [ imageView
--         [ height $ 24
--         , width $ 24
--         , imageUrl (itemImage props item)
--         , visibility if item.listRadioOrTick == true then VISIBLE else GONE
--         ]
--       , textView
--           [ height $ V 24
--           , width $ V 260
--           , margin $ Margin 12 0 0 0
--           , weight "1"
--           , text $ "why" <> show index
--           , textSize 12
--           , gravity LEFT
--           ]
--       , linearLayout
--           [ height $ V 16
--           , width $ V 40
--           , orientation HORIZONTAL
--           , gravity CENTER
--           , margin $ Margin 10 6 10 0
--           , background "#FF26BC5B"
--           , cornerRadius 2.0
--           , visibility if item.listIsNew == true then VISIBLE else GONE
--           ]
--           [ textView
--             [ height $ V 14
--   					, width $ V 40
--   					, text "NEW"
--   					, textSize 11
--   					, color "#FFFFFFFF"
--   					, gravity CENTER
--             ]
--           ]
--         , imageView
--             [ height $ 24
--             , width $ 24
--             , imageUrl (itemImage props item)
--             ]
--       ]
--   , linearLayout
--       [ height $ V 1
--       , width MATCH_PARENT
--       , background "#ffacacac"
--       , margin $ Margin 0 18 0 0
--       , cornerRadius 0.0
--       ]
--       []
--   ]

-- list :: forall w eff a.
--   (Action -> Eff (frp :: FRP | eff) Unit)
--   -> State
--   -> StrMap String
--   -> ((a -> Rec eff) -> PrestoDOM Action w)
--   -> PrestoDOM Action w
-- list push state props listVal =
--   linearLayout
--     [ height $ V 150
--     , width MATCH_PARENT
--     , orientation VERTICAL
--     , margin $ Margin 20 20 20 20
--     , background "#00ffff"
--     ]
--     (mapWithIndex (\index item -> listVal $ getRec push state props index item) state.list)

-- view :: forall a w eff.
--   Maybe ((a -> Rec eff) -> PrestoDOM Action w)
--   -> (Action -> Eff (frp :: FRP | eff) Unit)
--   -> State
--   -> StrMap String
--   -> PrestoDOM Action w
-- view (Just customView) push state props = list push state props customView
-- view Nothing push state props =
--  case lookup "layout" props of
--     Just _ -> list push state props listItem
--     Nothing -> list push state props listItem
