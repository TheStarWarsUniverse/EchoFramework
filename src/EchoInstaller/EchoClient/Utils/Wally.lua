-- Wally
-- RandomMutiny
-- December 11, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedPackagesFolder = ReplicatedStorage:WaitForChild("Echo"):WaitForChild("Packages")

--[=[
	@param PackageName string
	@return Wally Package
	@within EchoClient
	Get a shared wally package from client.
]=]
function Echo:GetWallySharedPackages(PackageName: string)
	local Package = SharedPackagesFolder:FindFirstChild(PackageName)
	return require(Package)
end

return Echo