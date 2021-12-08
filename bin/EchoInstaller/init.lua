-- EchoInstaller
-- RandomMutiny
-- December 07, 2021

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

--[=[
	@class

	The class manage the installation of the Echo Framework
]=]
local EchoInstaller = {}

--[=[
	@server
	@param PackageName string
	@return Package Instance
]=]
function EchoInstaller:GetWallyServerPackage(PackageName: string)
	local ServerPackage = self.EchoServer:WaitForChild("ServerPackages")
	
	if ServerPackage:FindFirstChild(PackageName) and ServerPackage:FindFirstChild(PackageName):IsA("ModuleScript") then
		return require(ServerPackage:FindFirstChild(PackageName))
	end
	return
end

--[=[
	@server
	@param Package Instance
	Installs given package. Echo must be started.

	A valid package should contain a manifest file called "Echo.json".
]=]
function EchoInstaller:InstallPackage(Package: Instance)
	-- Validate
	assert(RunService:IsServer(), "[Echo Framework]: Packages can only be installed by the server.")
	assert(not self.SetupCompleted, "[Echo Framework]: Packages can only be installed before Echo had started.")

	-- Get the package
	if Package:IsA("ModuleScript") then
		require(Package)
	end

	-- Find manifest & validate
	local Manifest = Package:FindFirstChild("Echo")
	assert(Manifest and Manifest:IsA("ModuleScript"), "The target package has no valid manifest module.")

	-- Remove the manifest
	Manifest.Parent = nil

	-- Read the manifest
	Manifest = require(Manifest)

	-- Get the target from the package realm
	local realmTarget
	if Manifest.realm == "server" then
		realmTarget = self.EchoServer
	elseif Manifest.realm == "shared" then
		realmTarget = self.EchoShared
	end

	-- Validate target
	assert(realmTarget, "Package realm invalid (" .. tostring(Manifest.realm) ..  "). Valid realms are 'server' & 'shared'.")

	local function MergePackageFolder(Folder: Instance, ParentFolder: Instance)
		local Target = ParentFolder:FindFirstChild(Folder.Name)

		-- No folder exists in the parent so simply use the package folder
		if not Target then
			Folder.Parent = ParentFolder
			return
		end

		-- Merge children into the target folder
		for _, v in ipairs(Folder:GetChildren()) do
			MergePackageFolder(v, Target)
		end
	end

	-- Merge each child folder & instance
	for _, v in ipairs(Package:GetChildren()) do
		MergePackageFolder(v, realmTarget)
	end

	-- Delete the package instance
	Package:Destroy()
end

--[=[
	@server
	@param Parent Instance
	Installs the server modules of the framework into the target location.
]=]
function EchoInstaller:InstallServer(Parent: Instance)
	-- Validate
	assert(RunService:IsServer(), "[Echo Framework]: Echo can only be installed in a server script.")

	-- Install the server module
	local EchoServer = script:WaitForChild("EchoServer")
	EchoServer.Name = "EchoFramework"
	EchoServer.Parent = Parent

	self.EchoServer = EchoServer

	-- Change the script parent to ReplicatedStorage to install shared modules for clients
	script.Parent = ReplicatedStorage
end

--[=[
	@server
	@param Parent Instance
	Installs the shared modules of the framework into the target location.
	Creates an "ObjectValue" in the module to point the location of the shared module.
]=]
function EchoInstaller:InstallShared(Parent: Instance)
	-- Validate
	assert(self.EchoServer, "[Echo Framework]: Echo server must be installed before installing shared.")
	assert(RunService:IsServer(), "[Echo Framework]: Echo can only be installed in a server script.")

	local EchoShared = script:WaitForChild("EchoShared")

	-- Creates shared reference.
	local SharedTarget = Instance.new("ObjectValue", script)
	SharedTarget.Name = "SharedTarget"
	SharedTarget.Value = EchoShared

	-- Creates server reference.
	local ServerTarget = Instance.new("ObjectValue", EchoShared)
	ServerTarget.Name = "ServerTarget"
	ServerTarget.Value = self.EchoServer
	ServerTarget:SetAttribute("IsShortcut", true)

	-- Install Default Packages.
	local DefaultPackages = script:WaitForChild("Packages")

	for _, v in pairs(DefaultPackages:GetChildren()) do
		self:InstallPackage(v)
	end

	DefaultPackages:Destroy()

	-- Rename and change the parent of the echo shared module.
	EchoShared.Name = "EchoFramework"
	EchoShared.Parent = Parent

	self.EchoShared = EchoShared
end

--[=[
	@server
	@client
	Start & init the Echo Framework.
]=]
function EchoInstaller:Start()
	local EchoShared = script:WaitForChild("SharedTarget").Value
	local EchoFramework = require(EchoShared)

	self.SetupCompleted = true

	EchoFramework:Init()
end

--[=[
	@server
	@client
	@return EchoInstaller

	Installs Echo at ServerStorage & ReplicatedStorage, returning the installer for easiler use.
]=]
function EchoInstaller:Install()
	if RunService:IsServer() then
		self:InstallServer(ServerStorage)
		self:InstallShared(ReplicatedStorage)
	end
	return self
end

return EchoInstaller