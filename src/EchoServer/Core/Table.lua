-- Table
-- RandomMutiny
-- December 31, 2021

local EchoServer = require(script:FindFirstAncestor("EchoServer"))

function EchoServer:Length(Table)
	local counter = 0

	for _, _ in pairs(Table) do
		counter = counter + 1
	end

	return counter
end

return EchoServer