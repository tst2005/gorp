require("mysqloo")
local db = mysqloo.connect("127.0.0.1","gorp","gorp","gorp",3306)

function db:onConnected()
 
    print( "Database has connected!" )
 
    local q = self:query( "SELECT 5+5;" )
    function q:onSuccess( data )
 
        print( "Query successful!" )
        PrintTable( data )
 
    end
 
    function q:onError( err, sql )
 
        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )
 
    end
 
    q:start()
 
end
 
function db:onConnectionFailed( err )
 
    print( "Connection to database failed!" )
    print( "Error:", err )
 
end
 
db:connect()