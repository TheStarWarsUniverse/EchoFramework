-- Echo
-- RandomMutiny
-- December 30, 2021

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EchoShared = ReplicatedStorage:WaitForChild("Echo")
local ServerPackagesFolder = script:WaitForChild("ServerPackages")
local PackagesFolder = EchoShared:WaitForChild("Packages")

local Promise = require(PackagesFolder:WaitForChild("Promise"))

local OnLoad = Instance.new("BindableEvent")
local OnStart = Instance.new("BindableEvent")

--[=[
	@class EchoServer
	@server

	The server side of the Echo Framework!

	Recommended way of loading & starting Echo Server!
	```lua
	local Echo = require(Path:WaitForChild("Echo"))

	Echo:LoadScripts():Start()
	```
]=]
local Echo = {}

--[=[
	@param Table dictionary
	@return Counter number
	@within EchoServer

	Get the length of a dictionary table.
]=]
function Echo:GetLength(Table: table)
	local Counter = 0

	for _, _ in pairs(Table) do
		Counter += 1
	end

	return Counter
end

--[=[
	@param PackageName string --The Package Name of the Wally package.
	@param Realm string --The realm of the package, either "Shared" or "Server".
	@return WallyPackage?
	@within EchoServer

	Get a wally package from its name and realm.
]=]
function Echo:GetWallyPackages(PackageName: string, Realm: string)
	if Realm == "Server" or Realm == nil then
		if ServerPackagesFolder:FindFirstChild(PackageName) then
			return require(ServerPackagesFolder[PackageName])
		end
	end
	
	if Realm == "Shared" or Realm == nil then
		if PackagesFolder:FindFirstChild(PackageName) then
			return require(PackagesFolder[PackageName])
		end
	end
end

--[=[
	@return EchoServer --Returning the Echo Server for a easiler uses of starting!
	@within EchoServer

	Loading all modules of Echo Server!
]=]
function Echo:LoadScripts()
	self.Root = script
	self.SharedRoot = EchoShared
	self.CoreModules = {}

	self.Configuration = require(self.SharedRoot:WaitForChild("Configuration"))

	require(script:WaitForChild("Core"):WaitForChild("Log"))

	-----------------------
	-- Load Core scripts --
	-----------------------
	for _, v in pairs(script:WaitForChild("Core"):GetChildren()) do
		self:DebugLog("Loading Module \"" .. v.Name .. "\"!")

		table.insert(self.CoreModules, require(v))
		
		self:DebugLog("Module Loaded \"" .. v.Name .. "\"!")
	end

	self:DebugLog(#self.CoreModules .. " modules has been loaded!")

	OnLoad:Fire()

	task.defer(function()
		OnLoad:Destroy()
	end)

	return self
end

--[=[
	@within EchoServer

	Initialize & Starts all Echo server scripts!
]=]
function Echo:Start()
	----------------
	-- Assertions --
	----------------
	assert(RunService:IsServer(), "Echo server can only be started in server-side!")
	assert(not self.Started, "Echo server could only be started once per server!")
	
	--------------
	-- On Start --
	--------------
	self.Started = true

	OnStart:Fire()

	_G.Echo = self

	task.defer(function()
		OnStart:Destroy()
	end)
end

--[=[
	@return Promise
	@within EchoServer

	Returns a promise that is resolved once Echo is loaded!
]=]
function Echo.OnLoad()
	if Echo.Loaded then
		return Promise.resolve()
	else
		return Promise.fromEvent(OnLoad.Event)
	end
end

--[=[
	@return Promise
	@within EchoServer

	Returns a promise that is resolved once Echo is started!
]=]
function Echo.OnStart()
	if Echo.Started then
		return Promise.resolve()
	else
		return Promise.fromEvent(OnStart.Event)
	end
end

return Echo