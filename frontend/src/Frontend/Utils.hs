{-# LANGUAGE ConstraintKinds  #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes       #-}

module Frontend.Utils where

import           Common.Route
import           Control.Monad.Fix
import           Obelisk.Route.Frontend
import           Reflex
import           Reflex.Dom
import           Data.Text as T

type Html t m a = DomBuilder t m => m a

type HtmlRouted t m a =
    ( DomBuilder t m
    , RouteToUrl (R FrontendRoute) m
    , SetRoute t (R FrontendRoute) m
    ) => m a

type HtmlRouter t m a =
    ( DomBuilder t m
    , RouteToUrl (R FrontendRoute) m
    , SetRoute t (R FrontendRoute) m
    , MonadFix m
    , MonadHold t m
    ) => RoutedT t (R FrontendRoute) m a

type HtmlWidget t m a =
    ( DomBuilder t m
    , MonadFix m
    , MonadHold t m
    , PostBuild t m
    ) => m a

changeRouteByClick :: FrontendRoute () -> HtmlRouted t m a -> HtmlRouted t m a
changeRouteByClick route = routeLink $ route :/ ()

addStyle :: Text -> Html t m ()
addStyle file = elAttr "link"
    (  "rel"  =: "stylesheet"
    <> "href" =: file
    ) blank

tshow :: Show a => a -> Text
tshow = T.pack . show

(<>~) :: Show a => Text -> a -> Text
(<>~) tx = (tx <>) . tshow
