---
sidebar_position: 5
---

# Component

## Components Defined
Bind components to Roblox instances using the Component class and CollectionService tags.

## Creating Components
In its simplest form, a worker can be created like so:
```lua
-- Example
-- RandomMutiny
-- January 8, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
local Component = Echo:GetWallyPackages("Component", "Shared")

local ExampleComponent = Component.new({Tag = "ExampleComponent"})

function MyComponent:Construct()
	self.MyData = "Hello"
end

function MyComponent:Start()
	local another = self:GetComponent(AnotherComponent)
	another:DoSomething()
end

function MyComponent:Stop()
	self.MyData = "Goodbye"
end

return ExampleComponent
```

## Style Guide
To keep your codes look clean, there is a style guide that you are recommended to follow.
```lua
-- SCRIPTNAME
-- AUTHOR
-- MONTHNAME DD, YYYY

local Echo = require(script:FindFirstAncestor("Echo"))
local Component = Echo:GetWallyPackages("Component", "Shared")

local ExampleComponent = Component.new({Tag = "ExampleComponent"})

function MyComponent:Construct()
	self.MyData = "Hello"
end

function MyComponent:Start()
	local another = self:GetComponent(AnotherComponent)
	another:DoSomething()
end

function MyComponent:Stop()
	self.MyData = "Goodbye"
end

return ExampleComponent
```