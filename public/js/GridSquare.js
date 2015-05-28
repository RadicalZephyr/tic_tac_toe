function GridSquare(optEl) {
    this.optEl = optEl;
}

GridSquare.prototype.enable = function() {
    this.optEl.disabled = false;
};

GridSquare.prototype.disable = function() {
    this.optEl.disabled = true;
};
