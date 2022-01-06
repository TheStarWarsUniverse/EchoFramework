-- Workers
-- RandomMutiny
-- December 30, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))
EchoServer.Workers = {}

EchoServer:OnLoad(function()
	EchoServer:DebugLog("***** LOADING WORKERS *****")

	local WorkersFolder = EchoServer.Root:WaitForChild("Workers")

	for _, v in pairs(WorkersFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			EchoServer:DebugLog("Loading " .. v.Name)
			require(v)
		end
	end
end)

return EchoServer