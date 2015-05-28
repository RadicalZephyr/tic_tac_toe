"use strict";

function Board(api, submitBtn, options) {
    this.api = api;
    this.submitBtn = submitBtn;
    this.options = options;
}

Board.prototype.prepareBoard = function() {
    this.hideButton(this.submitBtn);
    var board = this;
    this.options.forEach(function(option) {
        option.addClickHandler(board.makeOnClick(option));
    });
};

Board.prototype.setNewBoard = function(marks) {
    for (var i = 0; i < marks.length && i < this.options.length; i++) {
        this.options[i].mark(marks[i]);
    }
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
                    board.setNewBoard(boardInfo.marks);
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
