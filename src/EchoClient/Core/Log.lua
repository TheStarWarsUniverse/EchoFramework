-- Log
-- RandomMutiny
-- January 07, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
Echo.DEBUGLOGS = {}

local RunService = game:GetService("RunService")

function Echo:DebugLog(...: any)
	if Echo.Configuration.DebugMode then
		warn("[ECHO:DEBUG | CLIENT]: ", table.concat({...}, " "))
	end

	table.insert(self.DEBUGLOGS, table.concat({...}, " "))
end

return Echo