-- WallySharedPackages
-- RandomMutiny
-- Feburary 08, 2022

local EchoFramework = require(script:FindFirstAncestor("EchoFramework"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Installer = {"Shared"}

function Installer:Install(Server)
	if Server then
		self.Target = EchoFramework.Root:WaitForChild("Wally"):WaitForChild("Packages")
		self.Path = ReplicatedStorage
		self.Target.Parent = self.Path
	else
		self.Target = ReplicatedStorage:WaitForChild("Packages")
	end
end

return Installer