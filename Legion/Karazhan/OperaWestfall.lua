
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Westfall Story", 1651, 1826)
if not mod then return end
mod:RegisterEnableMob(114261, 114260) -- Toe Knee, Mrrgria
--mod.engageId = 1957 -- Same for every opera event. So it's basically useless.

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		227568, -- Burning Leg Sweep
		{227777, "PROXIMITY"}, -- Thunder Ritual
		227783, -- Wash Away
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "BurningLegSweep", 227568)
	self:Log("SPELL_CAST_START", "ThunderRitual", 227777)
	self:Log("SPELL_AURA_APPLIED", "ThunderRitualApplied", 227777)
	self:Log("SPELL_AURA_REMOVED", "ThunderRitualRemoved", 227777)
	self:Log("SPELL_CAST_START", "WashAway", 227783)

	self:RegisterEvent("BOSS_KILL")
end

function mod:OnEngage()
	phase = 1
	self:Bar(227568, 8.5) -- Burning Leg Sweep
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local foundMrrgria, foundToeKnee = nil, nil
	for i = 1, 5 do
		local guid = self:UnitGUID(("boss%d"):format(i))
		if guid  then
			local mobId = self:MobId(guid)
			if mobId == 114260 then -- Mrrgria
				foundMrrgria = true
			elseif mobId == 114261 then -- Toe Knee
				foundToeKnee = true
			end
		end
	end

	if foundMrrgria and phase == 1 then -- Mrrgria
		phase = 2
		self:MessageOld("stages", "cyan", "long", CL.stage:format(2), false)
		self:StopBar(227568) -- Burning Leg Sweep
		self:Bar(227777, 8.5) -- Thunder Ritual
		self:Bar(227783, 15.5) -- Wash Away
	elseif foundToeKnee and phase == 2 then -- Toe Knee
		phase = 3
		self:MessageOld("stages", "cyan", "long", CL.stage:format(3), false)
		self:Bar(227568, 8) -- Burning Leg Sweep
	end
end

function mod:BurningLegSweep(args)
	self:MessageOld(args.spellId, "yellow", "alarm")
	self:CDBar(args.spellId, 19)
end

function mod:ThunderRitual(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:Bar(args.spellId, 17)
end

function mod:ThunderRitualApplied(args)
	if self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 5)
		self:TargetBar(args.spellId, 5, args.destName)
	end
end

function mod:ThunderRitualRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
	end
end

function mod:WashAway(args)
	self:MessageOld(args.spellId, "orange", "info")
	self:Bar(args.spellId, 23)
end

function mod:BOSS_KILL(_, id)
	if id == 1957 then
		self:Win()
	end
end
