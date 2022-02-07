-- EchoFramework
-- RandomMutiny
-- Feburary 08, 2022

local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")

local StarterPlayerScripts = StarterPlayer:WaitForChild("StarterPlayerScripts")
local Installers = script:WaitForChild("Installer")

local Server = RunService:IsServer()

local EchoFramework = {}
EchoFramework.Root = script
EchoFramework.Configuration = require(script:WaitForChild("Configuration"))
EchoFramework.Installers = {}

function EchoFramework:DebugLog(...)
	warn("ECHO FRAMEWORK " .. (Server and "SERVER" or "CLIENT") .. " DEBUG:", ...)
end

function EchoFramework:GetWallyPackages(PackageName)
	local Package

	if Server then
		Package = self.Installers.WallyServerPackages.Target:FindFirstChild(PackageName)
		if Package then
			return require(Package)
		end
	end

	Package = self.Installers.WallySharedPackages.Target:FindFirstChild(PackageName)
	if Package then
		return require(Package)
	end
end

function EchoFramework:Install()
	-- Load Installer Scripts:
	for _, v in pairs(Installers:GetChildren()) do
		if v:IsA("ModuleScript") then
			local Modules = require(v)
			local Realm = Modules and Modules[1]

			if (Realm == "Server" and Server) or Realm == "Shared" then
				if type(Modules) == "table" and type(Modules.Install) == "function" then
					self:DebugLog("Installing " .. v.Name)
					task.spawn(Modules.Install, Modules, Server)
					self.Installers[v.Name] = Modules
				end
			end
		end
	end

	-- Clone Echo framework to client
	if Server then
		script:Clone().Parent = StarterPlayerScripts
	end

	-- Returns the framework for easiler starts
	return self
end

function EchoFramework:Start()
	
end

return EchoFramework