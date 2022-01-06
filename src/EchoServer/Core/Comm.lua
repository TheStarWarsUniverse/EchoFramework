-- Comm
-- RandomMutiny
-- December 31, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

EchoServer.CommFolder = Instance.new("Folder", ReplicatedStorage)
EchoServer.CommFolder.Name = "EchoCommunication"

return EchoServer