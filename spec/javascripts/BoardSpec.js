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
});
