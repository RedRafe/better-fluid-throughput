data:extend({
	{
		name = 'bft:factor',
		type = 'int-setting',
		setting_type = 'startup',
		default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
		order = 'a'
	},
	{
		name = 'bft:tanks',
		type = 'bool-setting',
		setting_type = 'startup',
		default_value = false,
		order = 'b'
	}
})
