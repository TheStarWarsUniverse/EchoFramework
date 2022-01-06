-- TestService
-- RandomMutiny
-- December 30, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))


local TestService = EchoServer:CreateService({
	Name = "TestService",
	Client = {}
})

function TestService.Client:Test()
	print("Test")
end

function TestService:EchoInit()
	
end

function TestService:EchoStart()
	
end

return TestService