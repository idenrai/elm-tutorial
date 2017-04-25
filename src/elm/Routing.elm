module Routing exposing (..)

import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)


-- navigation：browserのURL変更に対応
-- elm package install elm-lang/navigation
-- url-parser：Root Matcherを提供
-- elm package install evancz/url-parser


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute



-- Matcher（Parserは、url-parserで提供）
-- http://package.elm-lang.org/packages/evancz/url-parser/2.0.1


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
