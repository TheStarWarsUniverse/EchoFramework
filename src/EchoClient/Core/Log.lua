-- Log
-- RandomMutiny
-- December 30, 2021

local EchoClient = require(script:FindFirstAncestor("EchoClient"))

--[=[
	Throw an error if the provided value resolves to false or nil.

	@param Value boolean
	@param Message string?
]=]
function EchoClient:Assert(Value: boolean, Message: string)
	if not Value then
		error("[Echo Client]: " .. tostring(Message))
	end
end

--[=[
	Print the message when debug mode is on.

	@param Message string
	@param Type string? -- Error/Warn/nil
]=]
function EchoClient:DebugLog(Message: string, Type: string)
	if self.EchoConfig.DebugMode then
		if Type == "Error" then
			error("[Echo Client DEBUG]: " .. tostring(Message))
		elseif Type == "Warn" then
			warn("[Echo Client DEBUG]: " .. tostring(Message))
		else
			print("[Echo Client DEBUG]: " .. tostring(Message))
		end
	end
end


return EchoClient