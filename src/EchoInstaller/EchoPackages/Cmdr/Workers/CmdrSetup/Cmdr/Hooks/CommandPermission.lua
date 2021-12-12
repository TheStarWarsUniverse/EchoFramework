-- CommandPermission
-- RandomMutiny
-- December 12, 2021

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Echo = ReplicatedStorage:WaitForChild("Echo")
local Cmdr = Echo:WaitForChild("Workers"):WaitForChild("CmdrSetup"):WaitForChild("Cmdr")
local Modules = Cmdr:WaitForChild("Modules")

local CmdrUtil = require(Modules:WaitForChild("CmdrUtil"))

return function(Registry)
	Registry:RegisterHook("BeforeRun", function(Context)
		local Allowed, RequiredRole = CmdrUtil:CanPlayerExecuteCommand(Context.Executor, Context)

		if not Allowed then
			return ("Only %s+ can execute this command"):format(RequiredRole)
		end
	end)
end