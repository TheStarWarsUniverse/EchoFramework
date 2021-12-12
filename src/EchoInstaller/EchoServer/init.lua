-- EchoServer
-- RandomMutiny
-- December 09, 2021

--[=[
	@class EchoServer
	@server
	The server script of Echo framework.
]=]
local EchoServer = {}

function EchoServer:LoadFunctions()
	for _, v in pairs(script:WaitForChild("Functions"):GetChildren()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") then
			require(v)
		end
	end
end

function EchoServer:LoadServerScripts()
	for _, v in pairs(script:GetDescendants()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") and not v:IsDescendantOf(script:WaitForChild("ServerPackages")) and not v:IsDescendantOf(script:WaitForChild("Functions")) then
			require(v)
		end
	end
end

function EchoServer:Start()
	-- Load Functions
	self:LoadFunctions()
	-- Load Server Scripts
	self:LoadServerScripts()
	-- Init Service
	self:ServiceInit()
	-- Start Service
	self:ServiceStart()
end

return EchoServer