module Players.Commands exposing (..)

import Http
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
