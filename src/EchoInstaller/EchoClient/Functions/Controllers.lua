-- Controllers
-- RandomMutiny
-- December 11, 2021

local Echo = require(script:FindFirstAncestor("Echo"))

--[=[
	@interface ControllerDefine
	.Name string
	.Server table?
	.[any] any
	@within EchoClient
	Used to define a controller while creating it in "CreateController"
]=]
type ControllerDefine = {
	Name: string,
	Server: {[any]: any}?,
	[any]: any
}

--[=[
	@interface Controller
	.Name string
	.Server ControllerServer
	.[any] any
	@within EchoClient
]=]
type Controller = {
	Name: string,
	Client: ControllerServer,
	[any]: any,
}

--[=[
	@interface ControllerServer
	.Client Controller
	.[any] any
	@within EchoClient
]=]
type ControllerServer = {
	Client: Controller,
	[any]: any,
}

local EchoControllers: {[string]: Controller} = {}

function IsControllerExist(ControllerName: string): boolean
	return EchoControllers[ControllerName] ~= nil
end

--[=[
	@param ControllerInfo ControllerDefine
	@return Controller
	@within EchoClient
	Constructs a new controller.
	```lua
	local EchoController = Echo:CreateController({
		Name = "EchoController",
		Server = {}
	})

	function EchoController.Server:Example(...)
		print("Example")
	end

	function EchoController:EchoStart()
		print("Echo Start")
	end

	function EchoController:EchoInit()
		print("Echo Init")
	end

	return EchoController
	```
]=]
function Echo:CreateController(ControllerInfo: ControllerDefine): Controller
	assert(type(ControllerInfo) == "table", "Controller must be a table; got" .. type(ControllerInfo))
	assert(type(ControllerInfo.Name) == "string", "Controller.Name must be a string; got" .. type(ControllerInfo.Name))
	assert(#ControllerInfo.Name > 0, "Controller.Name must be a non-empty string")
	assert(not IsControllerExist(ControllerInfo.Name), "Service \"" .. ControllerInfo.Name .. "\" already exists")

	local Controller = ControllerInfo

	if type(Controller.Server) ~= "table" then
		Controller.Server = {Client = Controller}
	else
		if Controller.Server.Client ~= Controller then
			Controller.Server.Client = Controller
		end

		for i, v in pairs(Controller.Server) do
			if type(v) == "function" then
				self:Connect(i, v)
			end
		end
	end

	EchoControllers[Controller.Name] = Controller
	return Controller
end

--[=[
	@param ControllerName string
	@return Controller?
	@within EchoClient
	Gets the controller by name. Throws an error if the controller is not found.
]=]
function Echo:GetController(ControllerName: string): Controller
	assert(type(ControllerName) == "string", "ControllerName must be a string; got " .. type(ControllerName))
	return assert(EchoControllers[ControllerName], "Could not find service \"" .. ControllerName .. "\"") :: Controller
end

function Echo:ControllerInit()
	for _, v in pairs(EchoControllers) do
		spawn(function()
			if v.EchoInit then
				v:EchoInit()
			end
		end)
	end
end

function Echo:ControllerStart()
	for _, v in pairs(EchoControllers) do
		spawn(function()
			if v.EchoStart then
				v:EchoStart()
			end
		end)
	end
end

return Echo