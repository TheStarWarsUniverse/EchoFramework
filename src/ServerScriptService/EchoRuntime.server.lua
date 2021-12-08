-- EchoRuntime
-- RandomMutiny
-- December 07, 2021

local ServerScriptService = game:GetService("ServerScriptService")

local EchoInstaller = require(ServerScriptService:WaitForChild("EchoInstaller"))

EchoInstaller:Install():Start()