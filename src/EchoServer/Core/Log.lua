-- Log
-- RandomMutiny
-- December 30, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))

--[=[
	Throw an error if the provided value resolves to false or nil.

	@param Value boolean
	@param Message string?
]=]
function EchoServer:Assert(Value: boolean, Message: string)
	if not Value then
		error("[Echo Server]: " .. tostring(Message))
	end
end

--[=[
	Print the message when debug mode is on.

	@param Message string
	@param Type string? -- Error/Warn/nil
]=]
function EchoServer:DebugLog(Message: string, Type: string)
	if self.EchoConfig.DebugMode then
		if Type == "Error" then
			error("[Echo Server DEBUG]: " .. tostring(Message))
		elseif Type == "Warn" then
			warn("[Echo Server DEBUG]: " .. tostring(Message))
		else
			print("[Echo Server DEBUG]: " .. tostring(Message))
		end
	end
end


return EchoServer