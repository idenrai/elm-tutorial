module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Players.Commands exposing (fetchAll)
import Navigation exposing (Location)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


-- MODEL
-- NavigationからLocationが渡される
-- LocationをParsingしてReturnされたrouteは、modelに保存される


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN
-- Html.programではなく、Navigation.programを使う
-- Navigation.programは、browserの経路変更時メッセージを出す（ここではOnLocationChange）


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
