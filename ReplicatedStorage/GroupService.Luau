local GroupService = game:GetService("GroupService")
local DER = table.freeze({Rank=-1,Role="Visitor",Division=nil})
local function GetDeprecated(plr,gid)
	local Return,err = pcall(function()
		return {Rank=plr:GetRankInGroupAsync(gid),Role=plr:GetRoleInGroupAsync(gid),Division=nil}  --[[yeah yeah, I know this is depricated, but just here until it is released.]]
	end)
	if not Return then
		return DER
	end
	if err.Rank == 0 and err.Role == "Visitor" then err.Rank = -1 end
	return err
end
return function(plr:Player,group:{Id:number,DivisionNumber:number}):({Rank:number,Role:string,Division:{[number]:string}})
	if typeof(group.Id) ~= "number" then return DER --[[Why the fuck would you pass me a non-number]] end
	group.DivisionNumber = group.DivisionNumber or 0
	if script:GetAttribute("CantUseGS") then
		return GetDeprecated(plr, group.Id)
	end
	local result
	local cmp, err = pcall(function()
		-- Cast GroupService to 'any' to prevent Luau from flagging a non-released method
		result = (GroupService :: any):GetRolesInGroupAsync(plr.UserId, group.Id)
	end)

	-- Catch-all fallback: If the pcall failed OR the API returned no data, drop back safely
	if not cmp or not result then
		warn(`Fellback to known good. Reason: {tostring(err)}`)
		if string.find(tostring(err),"not enabled") then
			script:SetAttribute("CantUseGS",true)
		end
		return GetDeprecated(plr, group.Id)
	end
	--Parse GroupService
	local Role = "Visitor"
	local Rank = -1
	local Divisions = {}
	if not result.IsMember then return {Rank=Rank,Role=Role,Division=nil} end
	for i,v in pairs(result.Roles) do
		if v.Rank == group.DivisionNumber then
			table.insert(Divisions,v.Name)
		end
		if v.Rank > group.DivisionNumber and v.Rank > Rank then
			Rank = v.Rank
			Role = v.Name
		end
	end
	if Rank == -1 and Role == "Visitor" and result.IsMember then
		Role = "Member"
		Rank = 0
	end
	return {Rank=(Rank-group.DivisionNumber),Role=Role,Division=Divisions}
end
-- -1 = ungrouped, 0 = grouped, 1> roled
