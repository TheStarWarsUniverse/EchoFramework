-- Wally
-- RandomMutiny
-- December 31, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerPackagesFolder = EchoServer.Root:WaitForChild("ServerPackages")
local PackagesFolder = ReplicatedStorage:WaitForChild("EchoShared"):WaitForChild("Packages")

function EchoServer:GetWallyPackages(PackageName: string)
	if ServerPackagesFolder:FindFirstChild(PackageName) then
		return require(ServerPackagesFolder[PackageName])
	elseif PackagesFolder:FindFirstChild(PackageName) then
		return require(PackagesFolder[PackageName])
	end
end

return EchoServer