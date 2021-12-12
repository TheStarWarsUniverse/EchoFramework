-- EchoClient
-- RandomMutiny
-- December 09, 2021

--[=[
	@class

	The client script of Echo framework.
]=]
local EchoClient = {}

--[=[
	@client

	Require all echo functions.
]=]
function EchoClient:LoadFunctions()
	for _, v in pairs(script:WaitForChild("Functions"):GetChildren()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") then
			require(v)
		end
	end
end

--[=[
	@client

	Require all module scripts
]=]
function EchoClient:LoadClientScripts()
	for _, v in pairs(script:GetDescendants()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") and not v:IsDescendantOf(script:WaitForChild("Functions")) then
			require(v)
		end
	end
end

--[=[
	@client

	Start & init the client scripts.
]=]
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