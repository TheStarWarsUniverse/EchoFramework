-- Services
-- RandomMutiny
-- December 11, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

--[=[
	@interface ServiceDefine
	.Name string
	.Client table?
	.[any] any
	@within EchoServer
	Used to define a service while creating it in "CreateService"
]=]
type ServiceDefine = {
	Name: string,
	Client: {[any]: any}?,
	[any]: any
}

--[=[
	@interface Service
	.Name string
	.Client ServiceClient
	.[any] any
	@within EchoServer
]=]
type Service = {
	Name: string,
	Client: ServiceClient,
	[any]: any,
}

--[=[
	@interface ServiceClient
	.Server Service
	.[any] any
	@within EchoServer
]=]
type ServiceClient = {
	Server: Service,
	[any]: any,
}

local EchoServices: {[string]: Service} = {}

function IsServiceExist(ServiceName: string): boolean
	return EchoServices[ServiceName] ~= nil
end

--[=[
	@param ServiceInfo ServiceDefine
	@return Service
	@within EchoServer
	Constructs a new service.
	```lua
	local EchoService = Echo:CreateService({
		Name = "EchoService",
		Client = {}
	})

	function EchoService.Client:Example(Player: Instance, ...)
		print("Example")
	end

	function EchoService:EchoStart()
		print("Echo Start")
	end

	function EchoService:EchoInit()
		print("Echo Init")
	end

	return EchoService
	```
]=]
function Echo:CreateService(ServiceInfo: ServiceDefine): Service
	assert(type(ServiceInfo) == "table", "Service must be a table; got" .. type(ServiceInfo))
	assert(type(ServiceInfo.Name) == "string", "Service.Name must be a string; got" .. type(ServiceInfo.Name))
	assert(#ServiceInfo.Name > 0, "Service.Name must be a non-empty string")
	assert(not IsServiceExist(ServiceInfo.Name), "Service \"" .. ServiceInfo.Name .. "\" already exists")

	local Service = ServiceInfo

	if type(Service.Client) ~= "table" then
		Service.Client = {Server = Service}
	else
		if Service.Client.Server ~= Service then
			Service.Client.Server = Service
		end

		for i, v in pairs(Service.Client) do
			if type(v) == "function" then
				self:Connect(i, v)
			end
		end
	end

	EchoServices[Service.Name] = Service
	return Service
end

--[=[
	@param ServiceName string
	@return Service?
	@within EchoServer
	Get Services by its name.
]=]
function Echo:GetService(ServiceName: string): Service
	assert(type(ServiceName) == "string", "Service Name must be a string; got" .. type(ServiceName))
	return assert(EchoServices[ServiceName], "Could not find service \"" .. ServiceName .. "\"") :: Service
end

function Echo:ServiceInit()
	for _, Service in pairs(EchoServices) do
		for i, v in pairs(Service.Client) do
			if type(v) == "function" then
				self:Connect(i, v)
			end
		end
	end

	for _, v in pairs(EchoServices) do
		if type(v.EchoInit) == "function" then
			task.spawn(v.EchoInit, v)
		end
	end
end

function Echo:ServiceStart()
	for _, v in pairs(EchoServices) do
		if type(v.EchoStart) == "function" then
			task.spawn(v.EchoStart, v)
		end
	end
end

return Echo