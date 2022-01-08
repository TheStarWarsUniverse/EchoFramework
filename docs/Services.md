---
sidebar_position: 6
---

# Services

## Services Defined

Services are singleton provider objects that serve a specific purpose on the server. For instance, a game might have a PointsService, which manages in-game points for the players.

A game might have many services. They will serve as the backbone of a game.

For the sake of example, we will slowly develop PointsService to show how a service is constructed.

## Creating Services

In its simplest form, a service can be created like so:

```lua
local PointsService = Echo:CreateService({
	Name = "PointsService",
	Client = {}
})

return PointsService
```

:::note Client table optional
The `Client` table is optional for the constructor. However, it will be added by Echo if left out. For the sake of code clarity, it is recommended to keep it in the constructor as shown above.
:::

:::caution No client table forces server-only mode
If the `Client` table is omitted, the service will be interpreted as server-side only. This means that the client will _not_ be able to access this service using `Echo:GetService` on the client.
:::caution

The `Name` field is required. This name is how code outside of your service will find it. This name must be unique from all other services. It is best practice to name your variable the same as the service name (e.g. `local PointsService` matches `Name = "PointsService"`).

The last line (`return PointsService`) assumes this code is written in a ModuleScript, which is best practice for containing services.

## Style Guide
To keep your codes look clean, there is a style guide that you are recommended to follow.
```lua
-- ExampleService
-- RandomMutiny
-- January 8, 2021

local Echo = script:FindFirstAncestor("Echo")

local ExampleService = Echo:CreateService({
	Name = "ExampleService",
	Client = {}
})

function ExampleService:EchoInit()

end

function ExampleService:EchoStart()

end

return ExampleService
```