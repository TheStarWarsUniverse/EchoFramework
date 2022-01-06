-- Controllers
-- RandomMutiny
-- January 07, 2022

local EchoClient = require(script:FindFirstAncestor("EchoClient"))
EchoClient.Controllers = {}
EchoClient.Services = {}

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
	local ClientComm = EchoClient:GetWallyPackages("Comm").ClientComm.new(Folder, false, ServiceName)
	local Service = ClientComm:BuildObject()
	EchoClient.Services[ServiceName] = Service
	return Service 
end

function EchoClient:CreateController(ControllerDefine: ControllerDefine): Controller
	self:Assert(type(ControllerDefine) == "table", "Controller must be a table!")
	self:Assert(type(ControllerDefine.Name) == "string", "Controller.Name must be a string!")
	self:Assert(#ControllerDefine.Name, "Controller.Name cannot be an empty string!")

	local Controller = ControllerDefine
	
	self.Controllers[Controller.Name] = Controller

	return Controller
end

function EchoClient:GetController(ControllerName: string): Controller?
	return self.Controllers[ControllerName]
end

function EchoClient:GetService(ServiceName: string): Service?
	return self.Services[ServiceName] or BuildService(ServiceName)
end

EchoClient:OnLoad(function()
	EchoClient:DebugLog("***** LOADING CONTROLLERS *****")

	local ControllersFolder = EchoClient.Root:WaitForChild("Controllers")

	for _, v in pairs(ControllersFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			EchoClient:DebugLog("Loading " .. v.Name)
			require(v)
		end
	end

	EchoClient:DebugLog(EchoClient:Length(EchoClient.Controllers) .. " controllers has been loaded!")
	EchoClient:DebugLog(EchoClient:Length(EchoClient.Services) .. " services has been loaded!")
end)

EchoClient:OnStart(function()
	EchoClient:DebugLog("***** STARTING CONTROLLERS *****")

	for _, Controller in pairs(EchoClient.Controllers) do
		if typeof(Controller.EchoInit) == "function" then
			EchoClient:DebugLog("Initializing " .. Controller.Name)
			task.spawn(Controller.EchoInit, Controller)
		end
	end

	for _, Controller in pairs(EchoClient.Controllers) do
		if typeof(Controller.EchoStart) == "function" then
			EchoClient:DebugLog("Starting " .. Controller.Name)
			task.spawn(Controller.EchoStart, Controller)
		end
	end

	EchoClient:DebugLog(EchoClient:Length(EchoClient.Controllers) .. " controllers has been started!")
end)

return EchoClient