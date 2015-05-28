"use strict";

function API() {

}

API.prototype.getBoard = function(callback) {
    var oReq = new XMLHttpRequest();
    oReq.onload = callback;
    oReq.open("GET", "api/board", true);
    oReq.send();
};

API.prototype.sendMove = function(move, callback) {
    var oReq = new XMLHttpRequest();
    oReq.onload = callback;
    oReq.open("POST", "api/make-move", true);
    oReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    oReq.send("move="+move);
};
