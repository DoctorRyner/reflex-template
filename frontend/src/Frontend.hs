module Frontend where

import           Common.Route
import           Frontend.Utils
import           Obelisk.Frontend
import           Obelisk.Route
import           Obelisk.Route.Frontend
import           Route.NotFound
import           Route.Root
import           Route.Test

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
    { _frontend_head = do
        addStyle "static/style.css"
        addStyle "static/normalize.css"

    , _frontend_body = subRoute_ $ \case
        Root     -> Route.Root.render
        Test     -> Route.Test.render
        NotFound -> Route.NotFound.render
    }
