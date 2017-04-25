'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// index.html 를 require 하여 dist 에 복사 되도록 한다.
require('./index.html');

var Elm = require('./elm/Main.elm');
var mountNode = document.getElementById('main');

// .embed() 는 두번째 인자를 받을 수 있다. 이는 프로그램에 필요한 데이터가 될 수 있다. (예: userID, 토큰 등)
var app = Elm.Main.embed(mountNode);
