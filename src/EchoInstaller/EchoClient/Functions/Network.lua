-- Network
-- RandomMutiny
-- December 12, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkFolder = ReplicatedStorage:WaitForChild("NetworkFolder")

local RemoteEvent = NetworkFolder:WaitForChild("RemoteEvent")
local RemoteFunction = NetworkFolder:WaitForChild("RemoteFunction")

local Connections = {}

function Echo:Connect(Name: string, Function)
	assert(type(Function) == "function", "Function must be a function.")
	assert(not Connections[Name], "Function already exist.")
	Connections[Name] = Function
end

function Echo:Disconnect(Name: string)
	Connections[Name] = nil
end

function Echo:FireServer(Function: string, ...)
	RemoteEvent:FireServer(Function, ...)
end

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