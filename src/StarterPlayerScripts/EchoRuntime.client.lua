-- EchoRuntime
-- RandomMutiny
-- December 07, 2021

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EchoInstaller = require(ReplicatedStorage:WaitForChild("EchoInstaller"))

EchoInstaller:Install():Start()