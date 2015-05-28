describe("GridSquare", function() {
    it("can be disabled", function() {
        var opt = {};
        var gridSquare = new GridSquare(opt);
        gridSquare.disable();
        expect(opt.disabled).toBeTruthy();
    });

    it("can be enabled", function() {
        var opt = {};
        var gridSquare = new GridSquare(opt);
        gridSquare.enable();
        expect(opt.disabled).toBeFalsy();
    });
});
