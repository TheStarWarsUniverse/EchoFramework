-- EchoServer
-- RandomMutiny
-- December 30, 2021

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EchoServer = {}

function EchoServer:OnLoad(Function)
	if typeof(Function) == "function" then
		table.insert(self.LoadConnections, Function)
	else
		for _, v in pairs(self.LoadConnections) do
			v()
		end
	end
end

function EchoServer:OnStart(Function)
	if typeof(Function) == "function" then
		table.insert(self.StartConnections, Function)
	elseif EchoServer.Started then
		for _, v in pairs(self.StartConnections) do
			v()
		end
	end
end

function EchoServer:LoadScripts()
	self.Root = script
	self.EchoConfig = require(ReplicatedStorage:WaitForChild("EchoConfiguration"))
	self.LoadConnections = {}
	self.StartConnections = {}
	self.Modules = {}

	require(script:WaitForChild("Core"):WaitForChild("Log"))

	-----------------------
	-- Load Core scripts --
	-----------------------
	self:DebugLog("***** LOADING MODULES *****")

	for _, v in pairs(script:WaitForChild("Core"):GetChildren()) do
		self:DebugLog("Loading module \"" .. v.Name .. "\"!")

		table.insert(self.Modules, v)
		require(v)
	end
	self:DebugLog(#self.Modules .. " modules has been loaded!")
	self:OnLoad()

	return self
end

function EchoServer:Start()
	----------------
	-- Assertions --
	----------------
	self:Assert(RunService:IsServer(), "Echo server can only be started in server-side!")
	self:Assert(not self.Started, "Echo server could only be started once per server!")
	
	--------------
	-- On Start --
	--------------
	self.Started = true
	self:OnStart()
end

return EchoServer