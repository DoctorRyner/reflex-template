{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Frontend where

-- import qualified Data.Text              as T
import           Obelisk.Frontend
import           Obelisk.Route
import           Obelisk.Route.Frontend
import           Reflex.Dom.Core
import           Types
import           Common.Route
import           Frontend.Utils

root :: HtmlWidget t m ()
root = elAttr "div" ("class" =: "button-container") $ mdo
    counts   <- foldDyn (+) (0 :: Int) $ leftmost [1 <$ plusVal, -1 <$ minusVal]
    plusVal  <- button "+"
    el "label" $ display counts
    -- elDynClass "label" (tshow <$> counts) $ display counts
    minusVal <- button "-"
    blank

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
    { _frontend_head = do
        addStyle "static/style.css"
        addStyle "static/normalize.css"
        
    , _frontend_body = subRoute_ $ \case
        Root -> root
        Test -> text "test"
        NotFound -> text "404"
    }
