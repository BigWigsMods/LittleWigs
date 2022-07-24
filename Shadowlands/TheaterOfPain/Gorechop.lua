--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gorechop", 2293, 2401)
if not mod then return end
mod:RegisterEnableMob(162317) -- Gorechop
mod:SetEncounterID(2365)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		{323515, "TANK_HEALER"}, -- Hateful Strike
		322795, -- Meat Hooks
		-- Mythic
		318406, -- Tenderizing Smash
	}, {
		[323515] = "general",
		[318406] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "HatefulStrike", 323515)
	self:Log("SPELL_CAST_START", "TenderizingSmash", 318406)
end

function mod:OnEngage()
	self:Bar(322795, 10.8) -- Meat Hooks, 5.8 sec until the first cast
	self:Bar(323515, 7) -- Hateful Strike
	if self:Mythic() then
		self:Bar(318406, 13.1) -- Tenderizing Smash
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function warnMeatHooks()
		mod:Message(322795, "orange")
		mod:PlaySound(322795, "alert")
		mod:Bar(322795, 20.6)
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
		-- The boss casts Meat Hooks 5 seconds before anything actually happens
		if spellId == 322795 then -- Meat Hooks
			self:ScheduleTimer(warnMeatHooks, 5)
		end
	end
end

function mod:HatefulStrike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 14.6)
end

function mod:TenderizingSmash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 19.4)
end
