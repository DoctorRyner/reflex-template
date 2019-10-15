{-# LANGUAGE ConstraintKinds  #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes       #-}

module Utils where

import           Common.Route
import           Control.Monad.Fix
import           Obelisk.Route.Frontend
import           Reflex
import           Reflex.Dom

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

changeRouteByClick :: FrontendRoute () -> HtmlRouted t m a -> HtmlRouted t m a
changeRouteByClick route = routeLink $ route :/ ()
