-- EchoClient
-- RandomMutiny
-- January 05, 2022

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EchoClient = {}

function EchoClient:OnLoad(Function)
	if typeof(Function) == "function" then
		table.insert(self.LoadConnections, Function)
	else
		for _, v in pairs(self.LoadConnections) do
			v()
		end
	end
end

function EchoClient:OnStart(Function)
	if typeof(Function) == "function" then
		table.insert(self.StartConnections, Function)
	elseif EchoClient.Started then
		for _, v in pairs(self.StartConnections) do
			v()
		end
	end
end

function EchoClient:LoadScripts()
	self.Root = script
	self.EchoConfig = require(ReplicatedStorage:WaitForChild("EchoConfiguration"))
	self.LoadConnections = {}
	self.StartConnections = {}
	self.Modules = {}
	self.Player = Players.LocalPlayer

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

function EchoClient:Start()
	----------------
	-- Assertions --
	----------------
	self:Assert(RunService:IsClient(), "Echo client can only be started in client-side!")
	self:Assert(not self.Started, "Echo client could only be started once per client!")
	
	--------------
	-- On Start --
	--------------
	self.Started = true
	self:OnStart()
end

return EchoClient