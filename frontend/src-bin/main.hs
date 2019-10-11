import           Common.Route
import           Frontend
import           Obelisk.Frontend
import           Obelisk.Route.Frontend
import           Reflex.Dom
-- import qualified Obelisk.Run as Run


main :: IO ()
main = run $ runFrontend validFullEncoder frontend
  where
    Right validFullEncoder = checkEncoder fullRouteEncoder
