-- CmdrSetup
-- RandomMutiny
-- December 12, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if RunService:IsServer() then
	local Cmdr = Echo:GetWallyServerPackages("Cmdr")

	Cmdr:RegisterCommandsIn(script.Cmdr.Commands)
	Cmdr:RegisterTypesIn(script.Cmdr.Types)
	Cmdr:RegisterHooksIn(script.Cmdr.Hooks)
else
	local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))
	Cmdr:SetActivationKeys({ Enum.KeyCode.BackSlash })
end

return nil