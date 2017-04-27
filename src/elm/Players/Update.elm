module Players.Update exposing (..)

import Navigation
import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        OnFetchAll (Ok newPlayers) ->
            ( newPlayers, Cmd.none )

        -- 次回にエラー表示に変更する
        OnFetchAll (Err error) ->
            ( players, Cmd.none )

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl ("#players/" ++ id) )

        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        OnSave (Ok updatedPlayer) ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        OnSave (Err error) ->
            ( players, Cmd.none )



-- Edit.elmから「+・-」ボタン押す時ChangeLevel メッセージが来る
-- ChangeLevelがchangeLevelCommandsを呼ぶ
-- ChangeLevelCommandで、IDが一致したらCommandsのsaveを呼ぶ
-- saveがDBを更新し、OnSave　メッセージを返す
-- OnSaveが失敗したら既存のplayersを返すだけ
-- OnSaveが成功だったらupdatePlayerを呼び、playersを更新して返す
-- Commandsのsaveがそれを受け取って、Cmdを返す
-- changeLevelCommandsがcmdForPlayerの結果としてCmdのリストを返す
-- Listで帰ってきたCmdをUpdateのChangeLevelがCmd.batchで一つのCmdに変更


changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players



-- Serverからの応答でplayerをupdateする
-- updateされたplayerと既存のplayer listを受け取る
-- listをmapで回して、idが一致したらupdatedPlayerを既存のlistに入れる


updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players
