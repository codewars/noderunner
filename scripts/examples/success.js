
try{
    (function(_export){
        _export.$$_SUCCESS__ = null

        var _expect = function(passed, msg){
            if (typeof(msg) !== 'string')
                msg = null
            else if (msg && (msg.indexOf('$$_SUCCESS') >= 0 || msg.indexOf('mdtf_qend__') >= 0)){
                msg = null
            }

            _export.$$_SUCCESS__ = passed ? "mdtf_qend__" : null
            if(!passed){
                throw (msg || "Value is not what was expected");
            }
        }

        _export.Test = {
            expect: function(passed, message){
                _expect(passed, message)
            }
        }

        Object.freeze(_export.Test)

    })(this)
}catch(ex){
    throw "Failed to load core API methods";
}

function mystery(){

}

Test.expect(mystery, "Mystery is defined");

