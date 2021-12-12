-- Wally
-- RandomMutiny
-- December 11, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local SharedPackagesFolder = script.Parent.Parent:WaitForChild("Packages")

--[=[
	@param PackageName string
	@return Wally Package
	@within EchoShared
	Get a shared wally package from shared.
]=]
function Echo:GetWallySharedPackages(PackageName: string)
	local Package = SharedPackagesFolder:FindFirstChild(PackageName)
	return require(Package)
end

--[=[
	@server
	@param PackageName string
	@return Wally Package
	@within EchoShared
	Get a server wally package from server-sided shared.
]=]
function Echo:GetWallyServerPackages(PackageName: string)
	if RunService:IsServer() then
		return require(ServerStorage:WaitForChild("Echo"):WaitForChild("ServerPackages"):FindFirstChild(PackageName))
	end
end

return Echo