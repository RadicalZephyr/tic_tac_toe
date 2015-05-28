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
