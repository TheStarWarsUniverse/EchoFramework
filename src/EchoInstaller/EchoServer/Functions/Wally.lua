-- Wally
-- RandomMutiny
-- December 11, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerPackagesFolder = script.Parent.Parent:WaitForChild("ServerPackages")
local SharedPackagesFolder = ReplicatedStorage:WaitForChild("Echo"):WaitForChild("Packages")

function Echo:GetWallySharedPackages(PackageName: string)
	local Package = SharedPackagesFolder:FindFirstChild(PackageName)
	return require(Package)
end

function Echo:GetWallyServerPackages(PackageName: string)
	local Package = ServerPackagesFolder:FindFirstChild(PackageName)
	return require(Package)
end

return Echo