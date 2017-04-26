# elm

### About:

[elm-tutorial](https://www.elm-tutorial.org/ko/)でelm学習・ページ作成

### 稼働方法

elm install

-   `npm install -g elm elm-format`

Node Foreman install

-   `npm install -g foreman`

node_modules install

-   `npm install`

server 稼働

-   ServerはAPIとDEV、二つを使っている
-   json-server : jsonデータで仮想のAPIを作成（`api.js`, `db.json`）

    -   `npm run api`

-   Webpack dev server

    -   `npm run dev`

-   Node Foremanを使って、二つのserverを一緒に稼働可能
    -   `nf start`

<http://localhost:3000>で確認
