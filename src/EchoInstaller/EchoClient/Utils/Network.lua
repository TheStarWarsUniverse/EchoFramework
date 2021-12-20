-- Network
-- RandomMutiny
-- December 12, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkFolder = ReplicatedStorage:WaitForChild("NetworkFolder")

local RemoteEvent = NetworkFolder:WaitForChild("RemoteEvent")
local RemoteFunction = NetworkFolder:WaitForChild("RemoteFunction")

local Connections = {}

--[=[
	@param Name string
	@param Function function
	@within EchoClient
	Connects a function to the signal, which will be called anytime the signal is fired.
]=]
function Echo:Connect(Name: string, Function)
	assert(type(Function) == "function", "Function must be a function.")
	assert(not Connections[Name], "Function already exist.")
	Connections[Name] = Function
end

--[=[
	@param Name string
	@within EchoClient
	Connects a function to the signal, which will be called anytime the signal is fired.
]=]
function Echo:Disconnect(Name: string)
	Connections[Name] = nil
end

--[=[
	@param Function string
	@param [any] any?
	@within EchoClient
	Fires the signal at the server with any arguments.
]=]
function Echo:FireServer(Function: string, ...)
	RemoteEvent:FireServer(Function, ...)
end

--[=[
	@param Function string
	@param [any] any?
	@within EchoClient
	Invoke the signal at the server with any arguments and expected return from the server.
]=]
function Echo:InvokeServer(Function: string, ...)
	return RemoteFunction:InvokeServer(Function, ...)
end

RemoteEvent.OnClientEvent:Connect(function(Function: string, ...)
	if Connections[Function] then
		Connections[Function](Function, ...)
	end
end)

function RemoteFunction.OnClientInvoke(Function: string, ...)
	if Connections[Function] then
		Connections[Function](Function, ...)
	end
end

return Echo