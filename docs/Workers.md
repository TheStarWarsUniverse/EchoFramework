---
sidebar_position: 4
---

# Workers

## Workers Defined
Workers are basically `LocalScript` and `Script` from Roblox. 

## Creating Workers
In its simplest form, a worker can be created like so:
```lua
-- Example
-- RandomMutiny
-- January 8, 2022

local Echo = require(script:FindFirstAncestor("Echo"))

-- codes...

return nil
```

## Style Guide
To keep your codes look clean, there is a style guide that you are recommended to follow.
```lua
-- SCRIPTNAME
-- AUTHOR
-- MONTHNAME DD, YYYY

local Echo = require(script:FindFirstAncestor("Echo"))

local Service = game:GetService("ServiceName")

local Variables = "Variables"

return nil

```