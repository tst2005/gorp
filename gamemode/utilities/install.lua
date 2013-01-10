schema = {}

-- Load Abstracted DB Schema
include("../modules/player/playerdb.lua")
include("../modules/groups/groupsdb.lua")
include("../modules/characters/charactersdb.lua")

dbtype = 'mysql'

datatypes = {
	['serial'] = {
		-- stub
	},
	['int'] = {
		['mysql'] = 'int',
		['sqlite'] = 'integer',
	},
	['float'] = {
		-- stub	
	},
	['numeric'] = {
		-- stub
	},
	['varchar'] = {
		['mysql'] = 'varchar',
		['sqlite'] = 'varchar',	
	},
	['char'] = {
			-- stub
	},
	['text'] = {
		-- stub	
	},
	['blob'] = {
		-- stub	
	},
	['datetime'] = {
		-- stub	
	}
}

-- generateSqlFieldAttributes( table tableAttributes )
-- Input: (Table) Table with attributes
-- Output: (String) SQL Field Attributes
--
function generateAttributes(tableAttributes)
  attributes = getDbFieldType(tableAttributes['type'])
	
	if(tableAttributes['type'] == 'varchar' or tableAttributes['type'] == 'char' or tableAttributes['type'] == 'text') then
		if(tableAttributes['length']) then
			attributes = attributes..'('..tableAttributes['length']..')'
		elseif(tableAttributes['type'] == 'varchar') then 
			print('Database Error: varchar type must have length property')
		end	
	end
	-- print(tableAttributes['not null'])
	if(tableAttributes['unsigned'] == true) then
		attributes = attributes..' UNSIGNED'
	end
	if(tableAttributes['default']) then
		attributes = attributes..' DEFAULT '..'\''..tableAttributes['default']..'\''
	end	
	if(tableAttributes['not null'] == true) then
		attributes = attributes..' NOT NULL'
	end	
	if(tableAttributes['auto increment'] == true) then
		if(dbtype == 'mysql') then
			attributes = attributes..' AUTO_INCREMENT'
		elseif(dbtype == 'sqlite') then
			attributes = attributes..' AUTOINCREMENT'		
		end
	end		
	if(tableAttributes['description'] and dbtype == 'mysql') then
		attributes = attributes..' COMMENT \''..tableAttributes['description']..'\''
	end
	return attributes
end

-- getDbFieldType( string abstractType )
-- Input: (String) string Generic Type of DB Field - see datatypes table
-- Output: (String) Returns Type specific to database implementation (mysql, sqlite)
-- 
function getDbFieldType(abstractType)
	return datatypes[abstractType][dbtype]
end

-- generateInstallSql( table schema )
-- Input: (Table) Containing DB Schema elements
-- Output: (Table) SQL for creating Database Tables
--
function getSchemaSql(schema)
	local tableCount = 0
	local sqlQueryQueue = {}
	local sqlOut = ''
	-- CREATE Tables
	for tableName,columns in pairs(schema) do
		local fieldsCount = countTable(columns['fields'])
		local count = 1
		sqlOut = 'CREATE TABLE '..tableName..' ('
		for columnName, attributes in pairs(columns['fields']) do
			sqlOut =  sqlOut..columnName..' '..generateAttributes(attributes)
			-- Last Column Checks
			if(count ~= fieldsCount) then
				sqlOut = sqlOut..','
			elseif(count == fieldsCount) then -- cleanup?
				if(schema[tableName]['primary key']) then
					sqlOut = sqlOut..', PRIMARY KEY ('..schema[tableName]['primary key']..')'
				end
			end
			count = count + 1
		end
		sqlOut = sqlOut..')'
		if(dbtype == 'mysql') then 
			sqlOut = sqlOut..' ENGINE=InnoDB COMMENT \''..schema[tableName]['description']..'\';'
		elseif(dbtype == 'sqlite') then
		  sqlOut = sqlOut..';'
		end
		sqlQueryQueue[tableCount] = sqlOut
		tableCount = tableCount + 1
	end
	-- ALTER CREATED TABLES TO PROVIDE FOREIGN KEY SUPPORT

	for tableName,columns in pairs(schema) do
		if(schema[tableName]['foreign key']) then
			local count = 1
			local fieldsCount = countTable(schema[tableName]['foreign key'])
			sqlOut = 'ALTER TABLE '..tableName
			for key, foreignkey in pairs(schema[tableName]['foreign key']) do
			  sqlOut = sqlOut..' ADD CONSTRAINT fk_'..tableName..'_'..key..' FOREIGN KEY ('..key..') REFERENCES '..foreignkey..' ON UPDATE CASCADE ON DELETE CASCADE'
				if(count ~= fieldsCount) then
					sqlOut = sqlOut..','
				else 
					sqlOut = sqlOut..';'
				end
				count = count + 1
			end
			sqlQueryQueue[tableCount] = sqlOut
			tableCount = tableCount + 1
		end
	end
	return sqlQueryQueue
end

-- countTable( table )
-- Input: (Table) Table for iterating and counting entries
-- Output: (Number) The number of entries in the table
--
function countTable(table)
	local count = 0
	for  n in pairs(table) do count = count + 1 end
	return count
end
