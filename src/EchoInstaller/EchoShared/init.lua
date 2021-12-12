-- EchoShared
-- RandomMutiny
-- December 12, 2021

--[=[
	@class EchoShared
	@server
	@client
	The shared script of Echo framework.
]=]
local EchoShared = {}

function EchoShared:LoadFunctions()
	for _, v in pairs(script:WaitForChild("Functions"):GetChildren()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") then
			require(v)
		end
	end
end

function EchoShared:LoadSharedScripts()
	for _, v in pairs(script:GetDescendants()) do
		if not v:GetAttribute("NoAutoLoad") and v:IsA("ModuleScript") and not v:IsDescendantOf(script:WaitForChild("Packages")) and not v:IsDescendantOf(script:WaitForChild("Functions")) then
			require(v)
		end
	end
end

function EchoShared:Start()
	-- Load Functions
	self:LoadFunctions()
	-- Load Shared Scripts
	self:LoadSharedScripts()
end

return EchoShared