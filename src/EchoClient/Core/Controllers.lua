-- Controllers
-- RandomMutiny
-- January 07, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
Echo.Controllers = {}
Echo.Services = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

type ControllerDefine = {
	Name: string,
	[any]: any,
}

type Controller = {
	Name: string,
	[any]: any,
}

type Service = {
	[any]: any,
}

local function BuildService(ServiceName: string): Service
	local Folder = ReplicatedStorage:WaitForChild("EchoCommunication")
	local ClientComm = Echo:GetWallyPackages("Comm").ClientComm.new(Folder, false, ServiceName)
	local Service = ClientComm:BuildObject()
	Echo.Services[ServiceName] = Service
	return Service
end

function Echo:GetService(ServiceName: string): Service?
	return self.Services[ServiceName] or BuildService(ServiceName)
end

function Echo:GetController(ControllerName: string): Controller?
	return self.Controllers[ControllerName]
end

function Echo:CreateController(ControllerDefine: ControllerDefine): Controller
	assert(type(ControllerDefine) == "table", "Controller must be a table!")
	assert(type(ControllerDefine.Name) == "string", "Controller.Name must be a string!")
	assert(#ControllerDefine.Name, "Controller.Name cannot be an empty string!")

	local Controller = ControllerDefine
	
	self.Controllers[Controller.Name] = Controller

	return Controller
end

Echo.OnLoad():andThen(function()
	local ControllersFolder = Echo.Root:WaitForChild("Controllers")

	for _, v in pairs(ControllersFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			Echo:DebugLog("Loading Controller \"" .. v.Name .. "\"!")

			Echo.Controllers[v.Name] = require(v)

			Echo:DebugLog("Controller loaded \"" .. v.Name .. "\"!")
		end
	end

	Echo:DebugLog(Echo:GetLength(Echo.Controllers) .. " controllers has been loaded!")
	Echo:DebugLog(Echo:GetLength(Echo.Services) .. " services has been loaded!")
end)

Echo.OnStart():andThen(function()
	for _, Controller in pairs(Echo.Controllers) do
		if type(Controller.EchoInit) == "function" then
			Echo:DebugLog("Initializing Controller \"" .. Controller.Name .. "\"!")
			task.spawn(Controller.EchoInit, Controller)
			Echo:DebugLog("Controller Initialized \"" .. Controller.Name .. "\"!")
		end
	end

	for _, Controller in pairs(Echo.Controllers) do
		if type(Controller.EchoStart) == "function" then
			Echo:DebugLog("Starting Controller \"" .. Controller.Name .. "\"!")
			task.spawn(Controller.EchoStart, Controller)
			Echo:DebugLog("Controller Started \"" .. Controller.Name .. "\"!")
		end
	end
	
	Echo:DebugLog(Echo:GetLength(Echo.Controllers) .. " controllers has been started!")
end)

return Echo