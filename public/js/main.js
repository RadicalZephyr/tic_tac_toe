"use strict";

var submitBtn = document.getElementById("submit-btn");

var options = [];

for (var i = 0; i < 9; i++) {
    var opt = document.getElementById("move"+i);
    options.push(new GridSquare(opt));
}

var board = new Board(new API(), submitBtn, options);
board.prepareBoard();
