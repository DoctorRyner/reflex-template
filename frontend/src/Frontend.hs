{-# LANGUAGE FlexibleContexts #-}
module Frontend where

-- import qualified Data.Text              as T
import           Obelisk.Frontend
import           Obelisk.Route
import           Obelisk.Route.Frontend
import           Reflex.Dom.Core

import           Common.Route
import           Utils

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
    { _frontend_head = el "title" $ text "Obelisk Minimal Example"
    , _frontend_body = subRoute_ $ \case
        Root -> do
            text "root"
            changeRouteByClick Test $ el "input" (text "Press to change route")
        Test -> text "test"
        NotFound -> text "404"
    }
