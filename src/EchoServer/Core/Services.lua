-- Services
-- RandomMutiny
-- January 08, 2022

local Echo = require(script:FindFirstAncestor("Echo"))
Echo.Services = {}

local SignalMarker = newproxy(true)
getmetatable(SignalMarker).__tostring = function()
	return "SignalMarker"
end

type ServiceDefine = {
	Name: string,
	Client: {[any]: any}?,
	[any]: any
}

type Service = {
	Name: string,
	Client: ServiceClient,
	[any]: any,
}

type ServiceClient = {
	Server: Service,
	[any]: any
}

function Echo:CreateSignal()
	return SignalMarker
end

function Echo:GetService(ServiceName: string): Service?
	return self.Services[ServiceName]
end

function Echo:CreateService(ServiceDefine: ServiceDefine): Service
	assert(type(ServiceDefine) == "table", "Service must be a table!")
	assert(type(ServiceDefine.Name) == "string", "Service.Name must be a string!")
	assert(#ServiceDefine.Name, "Service.Name cannot be an empty string!")
	assert(not self.Services[ServiceDefine.Name], "Service \"".. ServiceDefine.Name .."\" already exists!")

	local Service = ServiceDefine
	Service.EchoComm = self:GetWallyPackages("Comm").ServerComm.new(self.CommFolder, ServiceDefine.Name)

	if type(Service.Client) == "table" or Service.Client.Server ~= Service then
		Service.Client.Server = Service
	end

	self.Services[Service.Name] = Service

	return Service
end

Echo.OnLoad():andThen(function()
	local ServicesFolder = Echo.Root:WaitForChild("Services")

	for _, v in pairs(ServicesFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			Echo:DebugLog("Loading Service \"" .. v.Name .. "\"!")

			Echo.Services[v.Name] = require(v)

			Echo:DebugLog("Service loaded \"" .. v.Name .. "\"!")
		end
	end

	Echo:DebugLog(Echo:GetLength(Echo.Services) .. " services has been loaded!")
end)

Echo.OnStart():andThen(function()
	for _, Service in pairs(Echo.Services) do
		if type(Service.EchoInit) == "function" then
			Echo:DebugLog("Initializing Service \"" .. Service.Name .. "\"!")
			task.spawn(Service.EchoInit, Service)
			Echo:DebugLog("Service Initialized \"" .. Service.Name .. "\"!")
		end
	end

	for _, Service in pairs(Echo.Services) do
		Service.Client = Service.Client or {Server = Service}

		for k, v in pairs(Service.Client) do
			if type(v) == "function" then
				Service.EchoComm:WrapMethod(Service.Client, k)
			elseif v == SignalMarker then
				Service.Client[k] = Service.EchoComm:CreateSignal(k)
			end
		end
	end

	for _, Service in pairs(Echo.Services) do
		if type(Service.EchoStart) == "function" then
			Echo:DebugLog("Starting Service \"" .. Service.Name .. "\"!")
			task.spawn(Service.EchoStart, Service)
			Echo:DebugLog("Service Started \"" .. Service.Name .. "\"!")
		end
	end

	Echo:DebugLog(Echo:GetLength(Echo.Services) .. " services has been started!")
end)

return Echo