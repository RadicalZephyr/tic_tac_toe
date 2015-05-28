describe("Board", function() {
    var submitBtn;
    var options;
    jasmine.Ajax.install();

    beforeEach(function() {
        submitBtn = {};
        options = [{}];
    });

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

    it("can create appropriate callback functions", function() {
        var board = new Board(submitBtn, options);
        spyOn(board, "sendMove");
        var val = {};
        var callback = board.makeOnClick({"value": val});
        callback.call();
        expect(board.sendMove).toHaveBeenCalledWith(val, board.getBoard);
    });

    it("can send AJAX move updates", function() {
        var board = new Board(submitBtn, options);

        var onSuccess = jasmine.createSpy("onSuccess");
        board.sendMove("0", onSuccess);
        var request = jasmine.Ajax.requests.mostRecent();
        expect(request).not.toBeUndefined();
        expect(request.url).toBe('api/make-move');
        request.respondWith(TestResponses.sendMove.success);
        expect(onSuccess).toHaveBeenCalled();
    });

    it("can retrieve a new board via AJAX", function() {
        var board = new Board(submitBtn, options);

        spyOn(board, "setNewBoard");
        board.getBoard();
        var request = jasmine.Ajax.requests.mostRecent();
        expect(request).not.toBeUndefined();
        expect(request.url).toBe('api/board');
        request.respondWith(TestResponses.getBoard.success);
        expect(board.setNewBoard).toHaveBeenCalled();
    });
});
