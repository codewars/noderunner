
try{
    (function(_export){
        _export.$$_SUCCESS__ = null

        var _expect = function(passed, msg){
            if (typeof(msg) !== 'string')
                msg = null
            else if (msg && (msg.indexOf('$$_SUCCESS') >= 0 || msg.indexOf('mdtf_qend__') >= 0)){
                msg = null
            }

            // mdtf_qend__ is a generated token unique to each request. It is used so that users
            // can't just set the $$_SUCCESS__ variable to something easy to guess (like true).
            // It may be removed as its probably overkill. The only thing its really useful for at this point
            // is to check that at least one test case passed.
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

iDontExist()

Test.expect(result, "Mystery did not return an object");
Test.expect(result.sanity === 'Hello', 'Mystery has not returned to sanity');

$$_SUCCESS__

