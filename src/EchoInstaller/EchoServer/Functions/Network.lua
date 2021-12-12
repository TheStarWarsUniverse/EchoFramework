-- Network
-- RandomMutiny
-- December 12, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkFolder = Instance.new("Folder", ReplicatedStorage)
NetworkFolder.Name = "NetworkFolder"

local RemoteEvent = Instance.new("RemoteEvent", NetworkFolder)
local RemoteFunction = Instance.new("RemoteFunction", NetworkFolder)

local Connections = {}

function Echo:Connect(Name: string, Function)
	assert(type(Function) == "function", "Function must be a function.")
	assert(not Connections[Name], "Function already exist.")
	Connections[Name] = Function
end

function Echo:Disconnect(Name: string)
	Connections[Name] = nil
end

function Echo:FireClient(Client: Instance, Function: string, ...)
	RemoteEvent:FireClient(Client, Function, ...)
end

function Echo:FireAllClients(Function: string, ...)
	RemoteEvent:FireAllClients(Function, ...)
end

function Echo:InvokeClient(Client: Instance, Function: string, ...)
	return RemoteFunction:InvokeClient(Client, Function, ...)
end

RemoteEvent.OnServerEvent:Connect(function(Player: Instance, Function: string, ...)
	if Connections[Function] then
		Connections[Function](Player, Function, ...)
	else
		print(Connections)
		Player:Kick("Nice try.")
	end
end)

function RemoteFunction.OnServerInvoke(Player: Instance, Function: string, ...)
	if Connections[Function] then
		Connections[Function](Player, Function, ...)
	else
		Player:Kick("Nice try.")
	end
end

return Echo