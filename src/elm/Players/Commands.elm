module Players.Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (field)
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)


-- Requestを生成し、Http.sendに送ってコマンド化する


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"



-- Listの核メンバーをmemberDecoderで処理する


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder



-- PlayerをreturnするJsonDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)


saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = saveUrl player.id
        , body = memberEncoded player |> Http.jsonBody -- PlayerをJSON文字列でEncode
        , expect = Http.expectJson memberDecoder -- 答えをどうParsingするか指定（今はJSONが返ってくるとElmにDecoding）
        , timeout = Nothing
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
