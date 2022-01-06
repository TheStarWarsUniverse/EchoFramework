-- Wally
-- RandomMutiny
-- December 31, 2021

local EchoClient = require(script:FindFirstAncestor("EchoClient"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PackagesFolder = ReplicatedStorage:WaitForChild("EchoShared"):WaitForChild("Packages")

function EchoClient:GetWallyPackages(PackageName: string)
	if PackagesFolder:FindFirstChild(PackageName) then
		return require(PackagesFolder[PackageName])
	end
end

return EchoClient