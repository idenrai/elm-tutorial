module Players.Update exposing (..)

import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        OnFetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        -- 次回にエラー表示に変更する
        OnFetchAll (Err error) ->
            ( players, Cmd.none )
