-- Components
-- RandomMutiny
-- January 08, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
Echo.Components = {}

Echo.OnStart():andThen(function()
	local ComponentsFolder = Echo.Root:WaitForChild("Components")

	for _, v in pairs(ComponentsFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			Echo:DebugLog("Loading Component \"" .. v.Name .. "\"!")

			Echo.Components[v.Name] = require(v) or v.Name

			Echo:DebugLog("Component Loaded \"" .. v.Name .. "\"!")
		end
	end

	Echo:DebugLog(Echo:GetLength(Echo.Components) .. " components has been loaded!")
end)

return Echo