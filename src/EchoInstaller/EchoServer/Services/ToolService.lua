-- ToolService
-- RandomMutiny
-- December 12, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local ToolService = Echo:CreateService({
	Name = "ToolService",
	Client = {}
})

function ToolService.Client:Test()
	print("Hi")
end

function ToolService:EchoStart()
	print(self)
end

function ToolService:EchoInit()
	print(self)
end

return ToolService