describe("Board", function() {
    var submitBtn = {};

    it("can setup the board", function() {
        var options = [{"addCallBack": function(callback) {}}];
        var board = new Board(submitBtn, options);
        spyOn(board, "hideButton");
        spyOn(board, "makeOnClick");
        board.prepareBoard();
        expect(board.hideButton).toHaveBeenCalledWith(submitBtn);
        expect(board.makeOnClick).toHaveBeenCalledWith(options[0]);
    });

    it("can disable all the options", function() {
        var opt1 = {"disable": function() {}};
        var options = [opt1];
        var board = new Board(submitBtn, options);
        spyOn(opt1, "disable");
        board.disableOptions();
        expect(opt1.disable).toHaveBeenCalled();
    });

    it("can enable all the options", function() {
        var opt1 = {"enable": function() {}};
        var options = [opt1];
        var board = new Board(submitBtn, options);
        spyOn(opt1, "enable");
        board.enableOptions();
        expect(opt1.enable).toHaveBeenCalled();
    });

});
