-- CmdrUtil
-- RandomMutiny
-- December 12, 2021

local CmdrUtil = {}

local Echo = require(script:FindFirstAncestor("Echo"))

local GroupService = game:GetService("GroupService")

local Promise = Echo:GetWallySharedPackages("Promise")

local Cache = require(script.Cache)
local CmdrConfig = require(script.Parent.CmdrConfig)

function GetMinAdminRoleRequiredToExecuteCommand(CommandGroup)
	for i, v in pairs(CmdrConfig.AdminLevels) do
		if table.find(v.CommandGroups, CommandGroup) then
			return i
		end
	end

	-- The command group wasn't found in any of the white listed admin levels, assume the first
	-- minimum level required to execute the command:
	return (next(CmdrConfig.AdminLevels))
end

function GetPlayerGroupRank(PlayerUserId, GroupId)
	return Promise.retry(function()
		return Promise.new(function(Resolve, Reject)
			local CacheResponse = Cache.PlayerGroupRankCache[PlayerUserId] and Cache.PlayerGroupRankCache[PlayerUserId][GroupId]

			if CacheResponse then
				return Resolve(CacheResponse)
			end

			local Success, Response = pcall(GroupService.GetGroupsAsync, GroupService, PlayerUserId)

			if Success then
				for _, v in ipairs(Response) do
					if v.Id == GroupId then
						Response = v.Rank
						break
					end
				end

				if type(Response) ~= "number" then
					Response = 0
				end

				Cache.PlayerGroupRankCache[PlayerUserId] = Cache.PlayerGroupRankCache[PlayerUserId] or {}
				Cache.PlayerGroupRankCache[PlayerUserId][GroupId] = Response
				Resolve(Response)
			else
				warn(("player:GetRankInGroup() failed because: %s"):format(Response))
				Reject(0)
			end
		end)
	end, 3)
end

function IsPlayerWhiteListedForAdminLevel(Player, AdminLevel)
	if table.find(AdminLevel.Whitelist, Player.UserId) then
		return true
	end

	for _, v in ipairs(AdminLevel.GroupAccess) do
		local GroupId = v[1]
		local RequiredGroupRank = v[2]

		local GroupRank = GetPlayerGroupRank(Player, GroupId):expect()

		if GroupRank >= RequiredGroupRank then
			return true
		end
	end

	return false
end

function CmdrUtil:GetPlayerAdminLevel(Player)
	-- Get Cache Response
	local CacheResponse = Cache.PlayerAdminLevels[Player.UserId]

	if CacheResponse then
		return CacheResponse
	end

	local PlayerAdminLevel = 0

	for _, v in pairs(CmdrConfig.AdminLevels) do
		if IsPlayerWhiteListedForAdminLevel(Player, v) then
			PlayerAdminLevel = v.Level
			break
		end
	end

	Cache.PlayerAdminLevels[Player.UserId] = PlayerAdminLevel
	return PlayerAdminLevel
end

function CmdrUtil:CanPlayerExecuteCommand(Player, Context)
	-- Get Cache Response
	local CacheResponse = Cache.CanPlayerExecuteCommand[Player.UserId]

	if CacheResponse then
		return CacheResponse
	end

	local PlayerAdminLevel = CmdrUtil:GetPlayerAdminLevel(Player)
	local Allowed = false

	for _, v in pairs(CmdrConfig.AdminLevels) do
		if table.find(v.CommandGroups, Context.Group) then
			if PlayerAdminLevel >= v.Level then
				Allowed = true
			end
			break
		end
	end

	Cache.CanPlayerExecuteCommand[Player.UserId] = Allowed

	return Allowed, GetMinAdminRoleRequiredToExecuteCommand(Context.Group)
end

return CmdrUtil