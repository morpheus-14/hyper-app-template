module UI.Views.Screens.SplashScreen where

import Engineering.Helpers.Commons
import Prelude
import PrestoDOM.Core
import PrestoDOM.Elements.Elements
import PrestoDOM.Events
import PrestoDOM.Properties
import PrestoDOM.Properties.SetChildProps
import PrestoDOM.Types.Core
import PrestoDOM.Types.DomAttributes
import UI.Controllers.Screens.SplashScreen

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Array ((..), replicate, reverse)
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
import Math (cos, e, pi, pow, sin)
import Simple.JSON (writeJSON)
import UI.Types (SplashScreenAction)
import UI.Views.Components.ListView as ListView
import UI.Views.Components.TitleBar as TitleBar


screen :: forall eff. ScreenInput -> Screen Action State eff SplashScreenAction
screen input =
	{ initialState: initialState input
	, view
	, eval
	}

listState s = { itemName: "ListItem " <> show s
			  , itemDesc: "Desciption for ListItem " <> show s
			  , itemCost: toNumber $ 100 * s
			  , selected: false }

view :: forall w eff
	. (Action -> Eff (frp :: FRP | eff) Unit)
	-> State
	-> PrestoDOM Action w
view push state =
	relativeLayout
	[ height MATCH_PARENT
	, width MATCH_PARENT
	] 
	[ linearLayout
		[ height MATCH_PARENT
		, width MATCH_PARENT
		, orientation VERTICAL
		, gravity CENTER_HORIZONTAL
		] 
		[ (mapDom TitleBar.view push {} BackPressed [ text_c "Animation Playground" ])
		, (demo4 push)
		-- , (mapDom (ListView.view Nothing) push state.usernameState AnimChanged [Tuple "layout" "radio"])
		]
	-- , linearLayout
	-- 	[ width MATCH_PARENT
	-- 	, height $ V 60
	-- 	, background "#3265FF"
	-- 	, alignParentBottom "true, -1"
	-- 	, onClick push $ const (SubmitPressed "loader")
	-- 	, gravity CENTER
	-- 	]
	-- 	[ textView
	-- 		[ width MATCH_PARENT
	-- 		, height $ V 30
	-- 		, text (state.buttonText)
	-- 		, textSize 22
	-- 		, gravity CENTER
	-- 		, color "#FFFFFF"
	-- 		]
	-- 	]
    ]


demo1 :: forall e. PrestoDOM Action e
demo1 =
	linearLayout
	[ width MATCH_PARENT
	, height $ V 0
	, weight "1"
	, orientation VERTICAL
	, gravity CENTER_HORIZONTAL
	]
	[ linearLayout
		[ width $ V 100
		, height $ V 100
		, margin $ MarginTop 50
		, background "#C54027"
		, alpha 0.0
		, animation (writeJSON
			[ fromFoldable
				[ Tuple "id" "loader"
				, Tuple "duration" "1500"
				, Tuple "delay" "800"
				, Tuple "easing" "linear"
				-- , Tuple "startImmediate" "true"
				, Tuple "repeatCount" "-1"
				, Tuple "props" (writeJSON
					[ { "prop": "rotation" , "from": "0", "to": "360" } ]
					)
				]
			, fromFoldable
				[ Tuple "id" "repeatLoader"
				, Tuple "duration" "1200"
				, Tuple "easing" "linear"
				, Tuple "repeatCount" "-1"
				, Tuple "props" (writeJSON
					[ { "prop": "rotation", "from": "0", "to": "360" } ]
					)
				]
			])
		] []
	, textView
		[ width MATCH_PARENT
		, height $ V 30
		, gravity CENTER
		, margin $ MarginTop 50
		, alpha 0.0
		, text "Such Delight"
		, animation (writeJSON
			[ fromFoldable
				[ Tuple "id" "loaderText"
				, Tuple "duration" "1500"
				, Tuple "delay" "800"
				, Tuple "easing" "ease-out"
				, Tuple "startImmediate" "true"
				, Tuple "props" (writeJSON
					[ { "prop": "translationY" , "from": "40", "to": "0" } 
					, { "prop": "alpha" , "from": "0", "to": "1" } ]
					)
				]
			])
		]
	, textView
		[ width MATCH_PARENT
		, height $ V 30
		, gravity CENTER
		, margin $ MarginTop 50
		, alpha 0.0
		, text "Much Happy"
		, animation (writeJSON
			[ fromFoldable
				[ Tuple "id" "loaderText"
				, Tuple "duration" "1500"
				, Tuple "delay" "1000"
				, Tuple "easing" "ease-out"
				, Tuple "startImmediate" "true"
				, Tuple "props" (writeJSON
					[ { "prop": "translationY" , "from": "40", "to": "0" } 
					, { "prop": "alpha" , "from": "0", "to": "1" } ]
					)
				]
			])
		]
	]

ball :: forall e. Int -> Int -> String -> Int -> (PrestoDOM Action e)
ball size pad color ind =
	linearLayout
		[ width $ V size
		, height $ V size
		, background color
		, borderRadius "12"
		-- , cornerRadius $ toNumber (size * 2)
		, margin $ Margin pad 100 pad 0
		, animation (writeJSON
			[ fromFoldable
				[ Tuple "id" "ball"
				, Tuple "duration" "900"
				, Tuple "delay" (show (ind * 150))
				, Tuple "easing" "ease-out"
				, Tuple "startImmediate" "true"
				, Tuple "repeatCount" "-1"
				, Tuple "repeatAlternate" "true"
				, Tuple "props" (writeJSON
					[ { "prop": "translationY" , "from": "140", "to": "0" } 
					]
					)
				]
			])
		] []

demo2 :: forall e. PrestoDOM Action e
demo2 =
	linearLayout
	[ width MATCH_PARENT
	, height $ V 0
	, weight "1"
	, gravity CENTER_HORIZONTAL
	]
	[ linearLayout
		[ width MATCH_PARENT
		, height MATCH_PARENT
		, gravity CENTER_HORIZONTAL
		] ((ball 24 8 "#993300") <$> reverse (1..6))
	]

demo3 :: forall e. PrestoDOM Action e
demo3 =
	relativeLayout
		[ width MATCH_PARENT
		, height $ V 0
		, weight "1"
		, gravity CENTER_HORIZONTAL
		]
		[ linearLayout
			[ width $ V 310
			, height $ V 310
			, margin $ MarginTop 50
			]
			[ arc
				[ cx $ V 155
				, cy $ V 155
				, radius $ V 150
				, style "STROKE"
				, hex "#3300FF"
				, startAngle (-90.0)
				, sweepAngle 0.0
				, animation (writeJSON
					[ fromFoldable
						[ Tuple "id" "samit"
						, Tuple "duration" "1000"
						, Tuple "delay" "300"
						, Tuple "easing" "linear"
						, Tuple "startImmediate" "true"
						, Tuple "repeatCount" "-1"
						, Tuple "fillMode" "forwards"
						, Tuple "props" (writeJSON
							[ { "prop": "sweepAngle" , "from": "0", "to": "360" } ]
							)
						]
					])
				]
			]
		]

demo4 :: forall e eff. (Action -> Eff (frp :: FRP | eff) Unit) -> PrestoDOM Action e 
demo4 push =
	relativeLayout
		[ width MATCH_PARENT
		, height $ V 0
		, weight "1"
		, gravity CENTER_HORIZONTAL
		]
		[ linearLayout
			[ width MATCH_PARENT
			, height $ V 250
			, background "#FF9900"
			, alpha 0.0
			, orientation VERTICAL
			, gravity CENTER
			, cornerRadius 10.0
			, padding $ Padding 20 20 20 10
			, margin $ Margin 20 100 20 0
			, animation (writeJSON
				[ fromFoldable
					[ Tuple "id" "modal"
					, Tuple "duration" "10000"
					, Tuple "delay" "300"
					, Tuple "easing" "ease-out"
					, Tuple "fillMode" "forwards"
					, Tuple "props" (writeJSON
						[ { "prop": "alpha" , "from": "0", "to": "1" } 
						, { "prop": "translationY" , "from": "100", "to": "0" } ]
						)
					]
				])
			]
			[ linearLayout
				[ width MATCH_PARENT
				, height $ V 0
				, weight "1"
				] []
			, textView
				[ width MATCH_PARENT
				, height $ V 50
				, text "Did you enjoy this animation? Any cool suggestions?" 
				, textSize 16
				, gravity CENTER
				, margin $ MarginBottom 50
				, color "#FFFFFF" ]
			, linearLayout
				[ width MATCH_PARENT
				, height $ V 60
				, orientation HORIZONTAL ]
				[ textView
					[ width $ V 0
					, height $ V 50
					, cornerRadius 5.0
					, weight "1"
					, gravity CENTER
					, margin $ MarginRight 20
					, text "No"
					, color "#FFFFFF"
					, background "#FF3300" ]
				, textView
					[ width $ V 0
					, height $ V 50
					, weight "1"
					, gravity CENTER
					, cornerRadius 5.0
					, text "Yes"
					, color "#FFFFFF"
					, background "#33FF00" ]
				]
			]
		, linearLayout
			[ width MATCH_PARENT
			, height MATCH_PARENT
			, alpha 0.0
			, background "#484848"
			, animation (writeJSON
				[ fromFoldable
					[ Tuple "id" "blur"
					, Tuple "duration" "10000"
					, Tuple "delay" "300"
					, Tuple "easing" "linear"
					, Tuple "fillMode" "forwards"
					, Tuple "props" (writeJSON
						[ { "prop": "alpha" , "from": "0", "to": "0.4" } ]
						)
					]
				])
			] []
		, textView
			[ width $ V 80
			, height $ V 80
			, margin $ Margin 0 0 20 20
			, cornerRadius 40.0
			, text "+"
			, gravity CENTER
			, textSize 28
			, color "#FFFFFF"
			, background "#FF9900"
			, alignParentBottom "true, -1"
			, alignParentRight "true, -1"
			, animation (writeJSON
				[ fromFoldable
					[ Tuple "id" "buttonFade"
					, Tuple "duration" "6000"
					, Tuple "easing" "ease-out"
					, Tuple "fillMode" "forwards"
					, Tuple "props" (writeJSON
						[ { "prop": "alpha" , "from": "1", "to": "0" } ]
						)
					]
				])
	 		, onClick push $ const FabClicked
			]
		]

-- productListItem :: forall w eff.
--   (Unit -> ListView.Rec eff)
--   -> PrestoDOM Action w
-- productListItem f = let {push, state, props, index, item} = ListView.defaultView f in
--   linearLayout
--     ([ height $ V 100
--     ,  width MATCH_PARENT
--     , orientation VERTICAL
--     , gravity "center_horizontal"
--     , padding "0,19,0,0"
--     , background "#ffffff"
--     , cornerRadius "0"
-- 		, onClick push $ ListView.itemAction index props
--     ])
--     ([ linearLayout
--       ([ height $ V 50
--       , width Match_Parent
--       , orientation "horizontal"
--       , margin "12,0,12,0"
--       , weight "1"
--       ])
--       ([ imageView
--         ([ height $ item.listImageHeight
--         , width $ item.listImageHeight
--         , imageUrl item.listImageUrl
--         ])
--       , textView
--         ([ height $ V 50
--         , width $ V 260
--         , margin "12,0,0,0"
--         , weight "1"
--         , text item.listText
--         , textSize item.listTextSize
-- 				, fontStyle item.listFontStyle
--         , gravity "left"
--         ])
--       ])
--     , linearLayout
--       ([ height $ V 1
--       , width Match_Parent
--       , background "#ffaca"
--       , margin "0,18,0,0"
--       , cornerRadius "0"
--       ])
--       []
--   ])

-- gridPadding :: Int
-- gridPadding = 20

-- cellSize :: Int
-- cellSize = 30

-- gridElem :: forall i e. Tuple Int Int -> Tuple Int Int -> PrestoDOM Action e
-- gridElem (Tuple i j) (Tuple w h) = 
-- 	linearLayout
-- 	[ width $ V cellSize
-- 	, height $ V cellSize
-- 	, background "#FF9900"
-- 	, alpha 0.0
-- 	, cornerRadius $ toNumber cellSize
-- 	, margin $ Margin x y 0 0
-- 	, animation (writeJSON 
-- 		[ fromFoldable 
-- 			[ Tuple "id" (show $ pow (toNumber x) 2.0 - pow (toNumber y) 2.0)
-- 			, Tuple "duration" "500"
-- 			, Tuple "delay" (show $ ((j * w) + i) * 50)
-- 			, Tuple "startImmediate" "true"
-- 			, Tuple "easing" "ease-out"
-- 			, Tuple "props" (writeJSON [ { "prop": "alpha", "from": "0", "to": "1" } 
-- 									   , { "prop": "scaleX", "from": "1.2", "to": "1" }
-- 									   , { "prop": "scaleY", "from": "1.2", "to": "1" } 
-- 									   , { "prop": "translationY", "from": "40", "to": "0" } ])
-- 			]
-- 		])
-- 	] []
-- 		where
-- 		  x = (i * (cellSize + gridPadding)) + gridPadding
-- 		  y = (j * (cellSize + gridPadding)) + gridPadding

-- genGrid :: forall i e. Tuple Int Int -> Int -> Array (PrestoDOM Action e)
-- genGrid gridDim@(Tuple w h) j =
-- 	if (j >= h) then []
-- 	else map (\i -> gridElem (Tuple i j) (Tuple w h)) (0..w) <> genGrid gridDim (j + 1)