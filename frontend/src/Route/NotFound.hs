module Route.NotFound where

import           Frontend.Utils

render :: Html t m ()
render = text "There is no such a page"
