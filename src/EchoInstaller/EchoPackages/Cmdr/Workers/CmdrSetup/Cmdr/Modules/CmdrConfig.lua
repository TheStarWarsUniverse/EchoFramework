-- CmdrConfig
-- RandomMutiny
-- December 12, 2021

return {
	AdminLevels = {
		CoHost = {
			Level = 1,
			CommandGroups = {},
			GroupAccess = {},
			Whitelist = {}
		},
		Host = {
			Level = 2,
			CommandGroups = {},
			GroupAccess = {},
			Whitelist = {}
		},
		Supervisor = {
			Level = 3,
			CommandGroups = {},
			GroupAccess = {},
			Whitelist = {},
		},
		Administrator = {
			Level = 4,
			CommandGroups = {},
			GroupAccess = {},
			Whitelist = {},
		},
		Developer = {
			Level = 5,
			CommandGroups = { "DefaultDebug", "Admin", "DefaultUtil", "Help", "UserAlias"},
			GroupAccess = {{11112054, 2}},
			Whitelist = {},
		},
		Owner = {
			Level = 6,
			CommandGroups = {},
			GroupAccess = {},
			Whitelist = {},
		}
	},
	ChatCommandPrefixes = {
		":",
		"-",
		".",
	},
	ShouldEnableCmdrGuiToNonAdmins = false
}