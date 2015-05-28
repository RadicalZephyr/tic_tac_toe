function Board(submitBtn, options) {
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
    var oReq = new XMLHttpRequest();
    oReq.onload = callback;
    oReq.open("GET", "api/board", true);
    oReq.send();
};

Board.prototype.sendMove = function(move, onSuccess) {
    var oReq = new XMLHttpRequest();
    oReq.onload = onSuccess;
    oReq.open("POST", "api/make-move", true);
    oReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    oReq.send("move="+move);
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
