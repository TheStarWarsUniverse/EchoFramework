-- TestController
-- RandomMutiny
-- January 07, 2022

local EchoClient = require(script:FindFirstAncestor("EchoClient"))

local TestController = EchoClient:CreateController({
	Name = "TestController"
})

function TestController:EchoInit()
	self.TestService = EchoClient:GetService("TestService")
end

function TestController:EchoStart()
	self.TestService:Test()
end

return EchoClient