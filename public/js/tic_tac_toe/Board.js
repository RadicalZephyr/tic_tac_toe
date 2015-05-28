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

function Board(api, submitBtn, options) {
    this.api = api;
    this.submitBtn = submitBtn;
    this.options = options;
}

Board.prototype.prepareBoard = function() {
    this.hideButton(this.submitBtn);
    var board = this;
    this.options.forEach(function(option) {
        option.addCallBack(board.makeOnClick(option));
    });
};

Board.prototype.setNewBoard = function(marks) {

};

Board.prototype.getBoard = function(callback) {
    this.api.getBoard(callback);
};

Board.prototype.sendMove = function(move, onSuccess) {
    this.api.sendMove(move, onSuccess);
};

Board.prototype.makeOnClick = function(option) {
    var move = option.value;
    var board = this;
    return function() {
        board.sendMove(move, board.getBoard);
    };
};

Board.prototype.hideButton = function(btn) {
    btn.classList.add("hidden");
};

Board.prototype.disableOptions = function() {
    this.options.forEach(function(opt) {
        opt.disable();
    });
};

Board.prototype.enableOptions = function() {
    this.options.forEach(function(opt) {
        opt.enable();
    });
};
