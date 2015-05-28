describe("GridSquare", function() {
    var opt;
    var gridSquare;

    beforeEach(function() {
        opt = {};
        gridSquare = new GridSquare(opt);
    });

    it("can be disabled", function() {
        gridSquare.disable();
        expect(opt.disabled).toBeTruthy();
    });

    it("can be enabled", function() {
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

    it("can't be marked with a space", function() {
        var cl = {"add": function() {}};
        var opt = {"parentElement": {"classList": cl}};
        var gridSquare = new GridSquare(opt);
        spyOn(cl, "add");
        gridSquare.mark(" ");
        expect(cl.add).not.toHaveBeenCalled();
    });

    it("can be setup with a click handler", function() {
        var onClick = function() {};
        gridSquare.addClickHandler(onClick);
        expect(opt.onclick).toEqual(onClick);
    });
});
