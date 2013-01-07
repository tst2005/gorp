schema['groups'] = {
	['description'] = 'Base table for Groups',
	['fields'] = {
		['id'] = {
			['description'] = 'Primary identifier for a groupr',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['name'] = {
			['description'] = 'Name of the group',
			['type'] = 'varchar',
			['not null'] = TRUE,
			['length'] = '20',
			['default'] = ''			
		},
		['description'] = {
			['description'] = 'Group description',
			['type'] = 'varchar',
			['not null'] = TRUE,
			['length'] = '255',
			['default'] = ''			
		}
	},
	['primary key'] = {'id'}
}

schema['groupRoster'] = {
	['description'] = 'Tabke for identifying player to their group and rank',
	['fields'] = {
		['groupId'] = {
			['description'] = 'Foreign key for group identifier',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['characterId'] = {
			['description'] = 'Foreign key for character identifier',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},		
		['rankId'] = {
			['description'] = 'Foreign key for rank identifier',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		}
	},
}

schema['groupRanks'] = {
	['description'] = 'Base table for Group Ranks',
	['fields'] = {
		['id'] = {
			['description'] = 'Primary identifier for a groupr',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['groupId'] = {
			['description'] = 'Foreign key for group identifier',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},		
		['name'] = {
			['description'] = 'Name of the rank',
			['type'] = 'varchar',
			['not null'] = TRUE,
			['length'] = '20',
			['default'] = ''			
		},
		['description'] = {
			['description'] = 'Group description',
			['type'] = 'varchar',
			['not null'] = TRUE,
			['length'] = '255',
			['default'] = ''
		},
		['isDefault'] = {
			['description'] = 'Identifies whether this is the default rank for the group',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE,
			['default'] = '0'
		},	
		['spawnGroup'] = {
			['description'] = 'Identifies which spawngroup members of this rank are in',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE,
			['default'] = '0'
		},				
	},
	['primary key'] = {'id'}
}