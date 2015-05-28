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
    var api = this.api;
    return function() {
        board.disableOptions();
        api.sendMove(move, function() {
            api.getBoard(function() {
                var boardInfo = JSON.parse(this.responseText);
                if (boardInfo.marks) {
                    setNewBoard(boardInfo.marks);
                }
                board.enableOptions();
            });
        });
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
