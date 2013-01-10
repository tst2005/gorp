require("mysqloo")
 
 
 --[[
mysqloo table

-- mysqloo.connect( host, username, password [, database, port, socket, flags] )
returns [Database]
Initializes the database object, note that this does not actually connect to the database.
 
-- mysqloo.VERSION -- [Number] Current MySQLOO version
-- mysqloo.MYSQL_VERSION -- [Number] Current MySQL version
-- mysqloo.MYSQL_INFO -- [String] Fancy version string
 
-- mysqloo.DATABASE_CONNECTED -- [Number] 0 - Database is connected
-- mysqloo.DATABASE_CONNECTING -- [Number] 1 - Datbase is connecting
-- mysqloo.DATABASE_NOT_CONNECTED -- [Number] 2 - Database is not connected
-- mysqloo.DATABASE_INTERNAL_ERROR -- [Number] 3 - Internal error
 
-- mysqloo.QUERY_NOT_RUNNING -- [Number] 0 - Query not running
-- mysqloo.QUERY_RUNNING -- [Number] 1 - Query running
-- mysqloo.QUERY_READING_DATA -- [Number] 2 - Query is reading data
-- mysqloo.QUERY_COMPLETE -- [Number] 3 - Query is complete
-- mysqloo.QUERY_ABORTED -- [Number] 4 - Query was aborted
 
-- mysqloo.OPTION_NUMERIC_FIELDS -- [Number] 1 - ?
-- mysqloo.OPTION_NAMED_FIELDS -- [Number] 2 - ?
-- mysqloo.OPTION_INTERPRET_DATA -- [Number] 4 - ?
-- mysqloo.OPTION_CACHE -- [Number] 8 - ?
 
Database object
 
Functions
-- Database:connect()
Returns nothing
Connects to the database
 
-- Database:query( sql )
Returns [Query]
Initializes a query to the database, [String] sql is the SQL query to run.
 
-- Database:escape( str )
Returns [String]
Escapes [String] str so that it is safe to use in a query.
 
-- Database:abortAllQueries()
Returns nothing
Aborts all running queries to the database
 
-- Database:status()
Returns [Number] (mysqloo.DATABASE_* enums)
Checks the connection to the database
USE THIS FUNCTION CONSERVATIVELY - it forces the main thread to wait for all running queries to finish
If you call this before each query it will cause lag on your server!
Instead you should wait for a query to timeout, THEN check the connection.
 
-- Database:wait()
Returns nothing
Forces the server to wait for the connection to finish.
 
-- Database:serverVersion()
Returns [Number]
Gets the MySQL servers version
 
-- Database:serverInfo()
Returns [String]
Fancy string of the MySQL servers version
 
-- Database:hostInfo()
Returns [String]
Gets information about the connection.
 
Callbacks
-- Database.onConnected( db )
Called when the connection to the MySQL server is successful
 
-- Database.onConnectionFailed( db, err )
Called when the connection to the MySQL server fails, [String] err is why.
 
Query object
 
Functions
-- Query:start()
Returns nothing
Starts the query.
 
-- Query:isRunning()
Returns [Boolean]
True if the query is running, false if it isn't.
 
-- Query:getData()
Returns [Table]
Gets the data the query returned from the server
Format: { row1, row2, row3, ... }
Row format: { field_name = field_value }
 
-- Query:abort()
Returns nothing
Cancels the running query.
 
-- Query:lastInsert()
Returns [Number]
Gets the autoincrement index of the last inserted row.
 
-- Query:status()
Returns [Number] (mysqloo.QUERY_* enums)
Gets the status of the query.
 
-- Query:affectedRows()
Returns [Number]
Gets the number of rows the query has affected.
 
-- Query:setOption( option )
Returns nothing
Changes how the query runs/returns data (mysqloo.OPTION_* enums).
 
-- Query:wait()
Returns nothing
Forces the server to wait for the query to finish.
 
-- Query:error()
Returns [String]
Gets the error caused by the query (if any).
 
Callbacks
-- Query.onAborted( q )
Called when the query is aborted.
 
-- Query.onError( q, err, sql )
Called when the query errors, [String] err is the error and [String] sql is the SQL query that caused it.
 
-- Query.onSuccess( q, data )
Called when the query is successful, [Table] data is the data the query returned.
 
-- Query.onData( q, data )
Called when the query retrieves a row of data, [Table] data is the row.

--]]

db = mysqloo.connect("127.0.0.1","gorp","gorp","gorp",3306)


function db:onConnected()
    print( "Database has connected!" )
		iterateSchemaTable(getSchemaSql(schema))
end
 
function db:onConnectionFailed( err )
    print( "Connection to database failed!" )
    print( "Error:", err )
end

function iterateSchemaTable(schemaTable) 
		PrintTable(schemaTable)
		for order,sql in pairs(schemaTable) do
			installSchema(sql)
		end
end


function installSchema(sql) 
		local q = db:query(sql)

		function q:onSuccess(q,data)
				print( "Query successful!" )
		end
 
		function q:onError( err, sql )
 
				print( "Query errored!" )
				print( "Query:", sql )
				print( "Error:", err )
 
		end
		
		q:start()
		q:wait()
end
	
db:connect()

