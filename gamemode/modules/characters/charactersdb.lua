schema['characters'] = {
	['description'] = 'Base table for Characters',
	['fields'] = {
		['id'] = {
			['description'] = 'Primary identifier for a character',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['playerId'] = {
			['description'] = 'Foreign key identifier for player',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},		
		['health'] = {
			['description'] = 'Characters health',
			['type'] = 'int',
			['default'] = '100',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['gender'] = {
			['description'] = 'Character Gender',
			['type'] = 'int',
			['default'] = '0',
			['unsigned'] = TRUE
			['not null'] = TRUE
		},
		['model'] = {
			['description'] = 'Character Model',
			['type'] = 'int',
			['default'] = '0',
			['unsigned'] = TRUE
			['not null'] = TRUE
		},
		['lastonline'] = {
			['description'] = 'Unix timestamp when character was last online',
			['type'] = 'int',
			['default'] = '0',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['description'] = {
			['description'] = 'Character Description',
			['type'] = 'varchar',
			['length'] = '80',
			['not null'] = TRUE
		},
		['name'] = {
			['description'] = 'Character Name',
			['type'] = 'varchar',
			['length'] = '30',
			['not null'] = TRUE
		},	
	},
	['primary key'] = {'id'}
}