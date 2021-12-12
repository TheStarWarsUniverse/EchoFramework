-- TestController
-- RandomMutiny
-- December 12, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local TestController = Echo:CreateController({
	Name = "TestController",
	Server = {}
})

function TestController:EchoStart()
	Echo:FireServer("Test")
end

function TestController:EchoInit()
	
end

return TestController