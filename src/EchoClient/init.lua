-- Echo
-- RandomMutiny
-- January 05, 2022

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PackagesFolder = ReplicatedStorage:WaitForChild("Echo"):WaitForChild("Packages")

local Promise = require(PackagesFolder:WaitForChild("Promise"))

local OnLoad = Instance.new("BindableEvent")
local OnStart = Instance.new("BindableEvent")

--[=[
	@class EchoClient
	@client

	The client side of the Echo Framework

	Recommended way of loading & starting Echo Client!
	```lua
	local Echo = require(Path:WaitForChild("Echo"))

	Echo:LoadScripts():Start()
	```
]=]
local Echo = {}

--[=[
	@param Table dictionary
	@return Counter number
	@within EchoClient

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
	@return WallyPackage?
	@within EchoClient

	Get a wally package from its name.
]=]
function Echo:GetWallyPackages(PackageName: string)
	if PackagesFolder:FindFirstChild(PackageName) then
		return require(PackagesFolder[PackageName])
	end
end

--[=[
	@return EchoClient --Returning the Echo Client for a easiler uses of starting!
	@within EchoClient

	Loading all modules of Echo Client!
]=]
function Echo:LoadScripts()
	self.Root = script
	self.CoreModules = {}
	self.Player = Players.LocalPlayer

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
	@within EchoClient

	Initialize & Starts all Echo server scripts!
]=]
function Echo:Start()
	----------------
	-- Assertions --
	----------------
	assert(RunService:IsClient(), "Echo client can only be started in client-side!")
	assert(not self.Started, "Echo client could only be started once per client!")
	
	--------------
	-- On Start --
	--------------
	self.Started = true
	
	OnStart:Fire()

	task.defer(function()
		OnStart:Destroy()
	end)
end

--[=[
	@return Promise
	@within EchoClient

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
	@within EchoClient

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