-- Components
-- RandomMutiny
-- December 30, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))
EchoServer.Components = {}

EchoServer:OnLoad(function()
	EchoServer:DebugLog("***** LOADING COMPONENTS *****")

	local ComponentsFodler = EchoServer.Root:WaitForChild("Components")

	for _, v in pairs(ComponentsFodler:GetChildren()) do
		if v:IsA("ModuleScript") then
			EchoServer:DebugLog("Loading " .. v.Name)
			require(v)
		end
	end
end)

return EchoServer