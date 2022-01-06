-- Services
-- RandomMutiny
-- December 30, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))
EchoServer.Services = {}

local SIGNAL_MARKER = newproxy(true)
getmetatable(SIGNAL_MARKER).__tostring = function()
	return "SIGNAL_MARKER"
end

local PROPERTY_MARKER = newproxy(true)
getmetatable(PROPERTY_MARKER).__tostring = function()
	return "PROPERTY_MARKER"
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

function EchoServer.CreateSignal()
	return SIGNAL_MARKER
end

function EchoServer.CreateProperty(initialValue: any)
	return {PROPERTY_MARKER, initialValue}
end

function EchoServer:CreateService(ServiceDefine: ServiceDefine): Service
	self:Assert(type(ServiceDefine) == "table", "Service must be a table!")
	self:Assert(type(ServiceDefine.Name) == "string", "Service.Name must be a string!")
	self:Assert(#ServiceDefine.Name, "Service.Name cannot be an empty string!")
	self:Assert(not self.Services[ServiceDefine.Name], "Service \"".. ServiceDefine.Name .."\" already exists!")

	local Service = ServiceDefine
	Service.EchoComm = self:GetWallyPackages("Comm").ServerComm.new(self.CommFolder, ServiceDefine.Name)

	if type(Service.Client) == "table" or Service.Client.Server ~= Service then
		Service.Client.Server = Service
	end

	self.Services[Service.Name] = Service

	return Service
end

function EchoServer:GetService(ServiceName: string): Service?
	return self.Services[ServiceName]
end

EchoServer:OnLoad(function()
	EchoServer:DebugLog("***** LOADING SERVICES *****")

	local ServicesFolder = EchoServer.Root:WaitForChild("Services")

	for _, v in pairs(ServicesFolder:GetChildren()) do
		if v:IsA("ModuleScript") then
			EchoServer:DebugLog("Loading " .. v.Name)
			require(v)
		end
	end

	EchoServer:DebugLog(EchoServer:Length(EchoServer.Services) .. " services has been loaded!")
end)

EchoServer:OnStart(function()
	EchoServer:DebugLog("***** STARTING SERVICES *****")

	for _, Service in pairs(EchoServer.Services) do
		for k, v in pairs(Service.Client) do
			if type(v) == "function" then
				Service.EchoComm:WrapMethod(Service.Client, k)
			elseif v == SIGNAL_MARKER then
				Service.Client[k] = Service.KnitComm:CreateSignal(k)
			elseif type(v) == "table" and v[1] == PROPERTY_MARKER then
				Service.Client[k] = Service.KnitComm:CreateProperty(k, v[2])
			end
		end
	end

	for _, Service in pairs(EchoServer.Services) do
		if typeof(Service.EchoInit) == "function" then
			EchoServer:DebugLog("Initializing " .. Service.Name)
			task.spawn(Service.EchoInit, Service)
		end
	end

	for _, Service in pairs(EchoServer.Services) do
		if typeof(Service.EchoStart) == "function" then
			EchoServer:DebugLog("Starting " .. Service.Name)
			task.spawn(Service.EchoStart, Service)
		end
	end

	EchoServer:DebugLog(EchoServer:Length(EchoServer.Services) .. " services has been started!")
end)

return EchoServer