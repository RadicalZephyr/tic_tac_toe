describe("Board", function() {

    it("can setup the board", function() {
        var submitBtn = {};
        var options = [{}];
        var board = new Board(submitBtn, options);
        spyOn(board, "hideButton");
        spyOn(board, "setupOption");
        board.prepareBoard();
        expect(board.hideButton).toHaveBeenCalledWith(submitBtn);
        expect(board.setupOption).toHaveBeenCalledWith(options[0]);
    });

    it("can disable all the options", function() {
        var submitBtn = {};
        var opt1 = {"disable": function() {}};
        var options = [opt1];
        var board = new Board(submitBtn, options);
        spyOn(opt1, "disable");
        board.disableOptions();
        expect(opt1.disable).toHaveBeenCalled();
    });

    it("can enable all the options", function() {
        var submitBtn = {};
        var opt1 = {"enable": function() {}};
        var options = [opt1];
        var board = new Board(submitBtn, options);
        spyOn(opt1, "enable");
        board.enableOptions();
        expect(opt1.enable).toHaveBeenCalled();
    });

});
