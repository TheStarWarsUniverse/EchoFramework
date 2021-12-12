---
sidebar_position: 3
---

# Style Guide

## Service

The Echo service works almost the same with Knit service. Styles are almost the same.

```lua
-- ScriptName
-- AuthorName
-- MonthFullName DD, YYYY

local Echo = require(script:FindFirstAncestor("Echo"))

local ExampleService = Echo:CreateService({
	Name = "ExampleService",
	Client = {}
})

function ExampleService.Client:Example(Player: Instance, ...)
	print(Player, "Example")
end

function ExampleService:EchoStart()

end

function ExampleService:EchoInit()

end

return ExampleService
```

## Controller
The Echo controller works almost the same with Knit controller. Styles are almost the same.

```lua
-- ScriptName
-- AuthorName
-- MonthFullName DD, YYYY

local Echo = require(script:FindFirstAncestor("Echo"))

local ExampleController = Echo:CreateController({
	Name = "ExampleController",
	Server = {}
})

function ExampleController.Server:Example(...)
	print("Example")
end

function ExampleController:EchoStart()

end

function ExampleController:EchoInit()

end

return ExampleController
```