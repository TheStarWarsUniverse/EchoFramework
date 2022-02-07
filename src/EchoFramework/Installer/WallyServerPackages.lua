-- WallyServerPackages
-- RandomMutiny
-- Feburary 08, 2022

local EchoFramework = require(script:FindFirstAncestor("EchoFramework"))

local ServerScriptService = game:GetService("ServerScriptService")

local Installer = {"Server"}

function Installer:Install()
	self.Target = EchoFramework.Root:WaitForChild("Wally"):WaitForChild("ServerPackages")
	self.Path = ServerScriptService
	self.Target.Parent = self.Path
end

return Installer