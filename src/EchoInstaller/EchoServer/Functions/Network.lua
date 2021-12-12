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

--[=[
	@param Name string
	@param Function function
	@within EchoServer
	Connects a function to the signal, which will be called anytime the signal is fired.
]=]
function Echo:Connect(Name: string, Function)
	assert(type(Function) == "function", "Function must be a function.")
	assert(not Connections[Name], "Function already exist.")
	Connections[Name] = Function
end

--[=[
	@param Name string
	@within EchoServer
	Disconnects a function from listening to remote event.
]=]
function Echo:Disconnect(Name: string)
	Connections[Name] = nil
end

--[=[
	@param Client Client Instance
	@param Name string
	@param [any] any?
	@within EchoServer
	Fires the signal at the specified client with any arguments.
]=]
function Echo:FireClient(Client: Instance, Name: string, ...)
	RemoteEvent:FireClient(Client, Name, ...)
end

--[=[
	@param Name string
	@param [any] any?
	@within EchoServer
	Fires the signal at the clients with any arguments.
]=]
function Echo:FireAllClients(Name: string, ...)
	RemoteEvent:FireAllClients(Name, ...)
end

--[=[
	@param Client Client Instance
	@param Name string
	@param [any] any?
	@within EchoServer
	Invoke the signal at the client with any arguments and expected return from the client.
]=]
function Echo:InvokeClient(Client: Instance, Name: string, ...)
	return RemoteFunction:InvokeClient(Client, Name, ...)
end

RemoteEvent.OnServerEvent:Connect(function(Player: Instance, Name: string, ...)
	if Connections[Name] then
		Connections[Name](Player, ...)
	else
		print(Connections)
		Player:Kick("Nice try.")
	end
end)

function RemoteFunction.OnServerInvoke(Player: Instance, Name: string, ...)
	if Connections[Name] then
		Connections[Name](Player, ...)
	else
		Player:Kick("Nice try.")
	end
end

return Echo