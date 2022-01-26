-- Log
-- RandomMutiny
-- January 07, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
Echo.DEBUGLOGS = {}

function Echo:DebugLog(...: any)
	if Echo.Configuration.DebugMode then
		warn("[ECHO:DEBUG | SERVER]: ", table.concat({...}, " "))
	end

	table.insert(self.DEBUGLOGS, table.concat({...}, " "))
end

return Echo