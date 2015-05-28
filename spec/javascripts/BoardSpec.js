describe("Board", function() {

    it("can setup the board", function() {
        var submitBtn = {};
        var options = [{}];
        var board = new Board(submitBtn, options);
        spyOn(board, "hideButton");
        board.prepareBoard();
        expect(board.hideButton).toHaveBeenCalledWith(submitBtn);

    });
});
