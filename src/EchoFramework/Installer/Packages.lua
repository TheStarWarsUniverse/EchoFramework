-- Packages
-- RandomMutiny
-- Feburary 08, 2022

local EchoFramework = require(script:FindFirstAncestor("EchoFramework"))

local Installer = {"Shared"}

function Installer:InstallPackage(Package)
	for _, v in pairs(Package:GetDescendants()) do
		if v:IsA("ModuleScript") then
			for _, Types in pairs(EchoFramework.Configuration.ExistInServer) do
				if v.Name:match(Types) then
					v:Destroy()
				end
			end

			if v:GetAttribute("Server") then
				v:Destroy()
			end
		end
	end
end

function Installer:Install(Server: boolean)
	self.Target = EchoFramework.Root:WaitForChild("Sources")
	self.Path = EchoFramework.Root.Parent

	if Server then
		self.Packages = self.Target:Clone()

		for _, v in pairs(self.Target:GetChildren()) do
			self:InstallPackage(v)
		end

		self.Target = self.Packages
	end
	
	self.Target.Parent = self.Path
end

return Installer