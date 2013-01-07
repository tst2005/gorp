schema['players'] = {
	['description'] = 'Base table for Players',
	['fields'] = {
		['id'] = {
			['description'] = 'Primary identifier for a player',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['steamid'] = {
			['description'] = 'SteamID identifier for a player',
			['type'] = 'varchar',
			['unsigned'] = TRUE,
			['not null'] = TRUE,
			['length'] = '25'
		},
		['characterLimit'] = {
			['description'] = 'How many characters this player may create',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE,
			['default'] = '1'
		}
	},
	['primary key'] = {'id'}
}
	
schema['roles'] = {
	['description'] = 'Player Roles Definitions',
	['fields'] = {
		['id'] = {
			['description'] = 'Primary identifier for a role',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
			},
		['title'] = {
			['description'] = 'Name of the role for permissions',
			['type'] = 'varchar',
			['length'] = '60',
			['not null'] = TRUE
		},
		['description'] = {
			['description'] =	'Description of this role',
			['type'] = 'varchar',
			['length'] = '255',
			['not null'] = TRUE,
			['default'] = ''
		}
	}
	['primary key'] = {'id'}
}

schema['playerRoles'] = {
	['description'] = 'Index of players and respective role assignments',
	['fields'] = {
		['playerId'] = {
			['description'] = 'Player Identifier',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
		},
		['roleId'] = {
			['description'] = 'Role Identifier',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE,
			['default'] = '0'
			
		}
	}
}

schema['permissions'] = {
	['description'] = 'Permissions settings',
	['fields'] = {
		['id'] = {
			['description'] = 'Primary identifier for permission',
			['type'] = 'int',
			['unsigned'] = TRUE,
			['not null'] = TRUE
			},
		['title'] = {
			['description'] = 'Description of permission for role',
			['type'] = 'varchar',
			['length'] = '60',
			['not null'] = TRUE
		}
		['name'] = {
			['description'] = 'Name of permission to be returned to gamemode',
			['type'] = 'varchar',
			['length'] = '60',
			['not null'] = TRUE
		}	
	}
	['primary key'] = {'id'}
}
