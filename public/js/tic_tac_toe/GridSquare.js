"use strict";

function GridSquare(optEl) {
    this.optEl = optEl;
    this.value = optEl.value;
}

GridSquare.prototype.enable = function() {
    this.optEl.disabled = false;
};

GridSquare.prototype.disable = function() {
    this.optEl.disabled = true;
};

GridSquare.prototype.mark = function(mark) {
    if (mark !== " ") {
        this.optEl.parentElement.classList.add(mark.toUpperCase()+"-marker");
    }
};

GridSquare.prototype.addClickHandler = function(callback) {
    this.optEl.onclick = callback;
};
