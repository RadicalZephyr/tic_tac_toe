function Board(submitBtn, options) {
    this.submitBtn = submitBtn;
}

Board.prototype.prepareBoard = function() {
    this.hideButton(this.submitBtn);
};

Board.prototype.hideButton = function(btn) {};
