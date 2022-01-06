-- Workers
-- RandomMutiny
-- December 30, 2021

local EchoClient = require(script:FindFirstAncestor("EchoClient"))
EchoClient.Workers = {}

EchoClient:OnLoad(function()
	EchoClient:DebugLog("***** LOADING WORKERS *****")

	local WorkersFolder = EchoClient.Root:WaitForChild("Workers")

	for _, v in pairs(WorkersFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			EchoClient:DebugLog("Loading " .. v.Name)
			require(v)
		end
	end
end)

return EchoClient