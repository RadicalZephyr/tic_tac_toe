describe("API", function() {

    it("can send AJAX move updates", function() {
        var api = new API();

        var onSuccess = jasmine.createSpy("onSuccess");
        api.sendMove("0", onSuccess);
        var request = jasmine.Ajax.requests.mostRecent();
        expect(request).not.toBeUndefined();
        expect(request.url).toBe('api/make-move');
        request.respondWith(TestResponses.sendMove.success);
        expect(onSuccess).toHaveBeenCalled();
    });

    it("can retrieve a new board via AJAX", function() {
        var api = new API();

        var onSuccess = jasmine.createSpy("onSuccess");
        api.getBoard(onSuccess);
        var request = jasmine.Ajax.requests.mostRecent();
        expect(request).not.toBeUndefined();
        expect(request.url).toBe('api/board');
        request.respondWith(TestResponses.getBoard.success);
        expect(onSuccess).toHaveBeenCalled();
    });

});
