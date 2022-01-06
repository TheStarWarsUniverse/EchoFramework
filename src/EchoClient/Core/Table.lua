-- Table
-- RandomMutiny
-- December 31, 2021

local EchoClient = require(script:FindFirstAncestor("EchoClient"))

function EchoClient:Length(Table)
	local counter = 0

	for _, _ in pairs(Table) do
		counter = counter + 1
	end

	return counter
end

return EchoClient