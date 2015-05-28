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

Board.prototype.sendMove = function(move) {

};

Board.prototype.makeOnClick = function(option) {
    var move = option.value;
    var board = this;
    return function() {
        board.sendMove(move);
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
