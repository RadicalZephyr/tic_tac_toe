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

    it("can be marked", function() {
        var cl = {"add": function() {}};
        var opt = {"parentElement": {"classList": cl}};
        var gridSquare = new GridSquare(opt);
        spyOn(cl, "add");
        gridSquare.mark("X");
        expect(cl.add).toHaveBeenCalledWith("X-marker");
    });
});