-- Components
-- RandomMutiny
-- December 30, 2021

local EchoClient = require(script:FindFirstAncestor("EchoClient"))
EchoClient.Components = {}

EchoClient:OnLoad(function()
	EchoClient:DebugLog("***** LOADING COMPONENTS *****")

	local ComponentsFodler = EchoClient.Root:WaitForChild("Components")

	for _, v in pairs(ComponentsFodler:GetChildren()) do
		if v:IsA("ModuleScript") then
			EchoClient:DebugLog("Loading " .. v.Name)
			require(v)
		end
	end
end)

return EchoClient