-- Comm
-- RandomMutiny
-- December 31, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ReplicatedStorage = game:GetService("ReplicatedStorage")

Echo.CommFolder = Instance.new("Folder", ReplicatedStorage)
Echo.CommFolder.Name = "EchoCommunication"

return Echo