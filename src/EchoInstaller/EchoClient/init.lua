local Players = game:GetService("Players")
-- EchoClient
-- RandomMutiny
-- December 09, 2021

local Players = game:GetService("Players")

--[=[
	@class EchoClient
	@client
	The client script of Echo framework.
]=]
local EchoClient = {
	Player = Players.LocalPlayer
}

function EchoClient:LoadFunctions()
	for _, v in pairs(script:WaitForChild("Functions"):GetChildren()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") then
			require(v)
		end
	end
end

function EchoClient:LoadClientScripts()
	for _, v in pairs(script:GetDescendants()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") and not v:IsDescendantOf(script:WaitForChild("Functions")) then
			require(v)
		end
	end
end

function EchoClient:Start()
	-- Load Functions
	self:LoadFunctions()
	-- Load Client Scripts
	self:LoadClientScripts()
	-- Init Controller
	self:ControllerInit()
	-- Start Controller
	self:ControllerStart()
end

return EchoClient