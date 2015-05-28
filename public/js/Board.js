function Board(submitBtn, options) {
    this.submitBtn = submitBtn;
    this.options = options;
}

Board.prototype.prepareBoard = function() {
    this.hideButton(this.submitBtn);
    this.options.forEach(function(item) { this.setupOption(item); }, this);
};

Board.prototype.hideButton = function(btn) {
    btn.classList.add("hidden");
};

Board.prototype.setupOption = function(option) {

};
