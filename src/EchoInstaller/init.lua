-- EchoInstaller
-- RandomMutiny
-- December 08, 2021

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local StarterPlayerScripts = StarterPlayer:WaitForChild("StarterPlayerScripts")

--[=[
	@class

	The class manage the installation of the Echo Framework
]=]
local EchoInstaller = {}

--[=[
	@server
	@param Parent Instance
	Installs the server modules of the framework into the target location.
]=]
function EchoInstaller:InstallServer(Parent: Instance)
	-- Validate
	assert(RunService:IsServer(), "[Echo Framework]: Echo can only be installed in a server script.")

	local EchoServer = script:WaitForChild("EchoServer")
	EchoServer.Name = "Echo"
	EchoServer.Parent = Parent

	self.EchoServer = EchoServer
end

--[=[
	@server
	@param Parent Instance
	Installs the shared modules of the framework into the target location.
]=]
function EchoInstaller:InstallShared(Parent: Instance)
	-- Validate
	assert(RunService:IsServer(), "[Echo Framework]: Echo can only be installed in a server script.")

	local EchoShared = script:WaitForChild("EchoShared")
	EchoShared.Name = "Echo"
	EchoShared.Parent = Parent

	local SharedTarget = Instance.new("ObjectValue", script)
	SharedTarget.Name = "EchoShared"
	SharedTarget.Value = EchoShared

	self.EchoShared = EchoShared
end

--[=[
	@server
	@param Parent Instance
	Installs the client modules of the framework into the target location.
]=]
function EchoInstaller:InstallClient(Parent: Instance)
	-- Validate
	assert(RunService:IsServer(), "[Echo Framework]: Echo can only be installed in a server script.")

	local EchoClient = script:WaitForChild("EchoClient")
	EchoClient.Name = "Echo"
	EchoClient.Parent = Parent

	self.EchoClient = EchoClient
end

--[=[
	@server
	@client
	Start & init the Echo framework.
]=]
function EchoInstaller:Start()
	if RunService:IsServer() then
		require(self.EchoServer):Start()
		require(self.EchoShared):Start()
	else
		-- Echo Client
		local Player = Players.LocalPlayer
		local EchoClient = Player:WaitForChild("PlayerScripts"):WaitForChild("Echo")

		require(EchoClient):Start()

		-- Echo Shared
		local EchoShared = script:WaitForChild("EchoShared").Value

		require(EchoShared):Start()

		script:Destroy()
	end
end

--[=[
	@server
	@client
	@return EchoInstaller

	Installs Echo at ServerStorage, ReplicatedStorage, and StarterPlayerScripts.
	Returning the Installer for easiler uses.
]=]
function EchoInstaller:Install()
	if RunService:IsServer() then
		script.Parent = ReplicatedStorage
		self:InstallServer(ServerStorage)
		self:InstallShared(ReplicatedStorage)
		self:InstallClient(StarterPlayerScripts)
	end
	return self
end

return EchoInstaller