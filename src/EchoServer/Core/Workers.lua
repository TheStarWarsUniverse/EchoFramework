-- Workers
-- RandomMutiny
-- January 08, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
Echo.Workers = {}

Echo.OnStart():andThen(function()
	local WorkersFolder = Echo.Root:WaitForChild("Workers")

	for _, v in pairs(WorkersFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			Echo:DebugLog("Loading Worker \"" .. v.Name .. "\"!")

			Echo.Workers[v.Name] = require(v) or v.Name

			Echo:DebugLog("Worker Loaded \"" .. v.Name .. "\"!")
		end
	end

	Echo:DebugLog(Echo:GetLength(Echo.Workers) .. " workers has been loaded!")
end)

return Echo