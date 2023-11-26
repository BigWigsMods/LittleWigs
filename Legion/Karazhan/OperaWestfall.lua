--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Westfall Story", 1651, 1826)
if not mod then return end
mod:RegisterEnableMob(
	114261, -- Toe Knee
	114265, -- Gang Ruffian
	114260  -- Mrrgria
)
--mod:SetEncounterID(1957) -- Same for every opera event. So it's basically useless.
mod:SetStage(1)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Locals
--

local burningLegSweepCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		227568, -- Burning Leg Sweep
		227453, -- Dashing Flame Gale
		227777, -- Thunder Ritual
		227783, -- Wash Away
	}, {
		[227568] = -14118, -- Toe Knee
		[227777] = -14125, -- Mrrgria
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("ENCOUNTER_END")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2") -- Toe Knee can be either boss1 or boss2
	self:Log("SPELL_CAST_START", "BurningLegSweep", 227568)
	self:Log("SPELL_CAST_START", "ThunderRitual", 227777)
	self:Log("SPELL_AURA_APPLIED", "ThunderRitualApplied", 227777)
	self:Log("SPELL_CAST_START", "WashAway", 227783)
end

function mod:OnEngage()
	burningLegSweepCount = 0
	self:SetStage(1)
	self:Bar(227568, 8.3) -- Burning Leg Sweep
	self:Bar(227453, 19.5) -- Dashing Flame Gale
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
	if engageId == 1957 then
		if status == 0 then
			-- this is needed because we're overriding the IEEU hooked up to CheckBossStatus in OnEngage
			self:Wipe()
			-- force a respawn timer
			self:SendMessage("BigWigs_EncounterEnd", self, engageId, self.displayName, self:Difficulty(), 5, status)
		else
			self:Win()
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetStage() == 1 and self:GetBossId(114260) then -- Mrrgria
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:StopBar(227568) -- Burning Leg Sweep
		self:StopBar(227453) -- Dashing Flame Gale
		self:Bar(227777, 8.5) -- Thunder Ritual
		self:Bar(227783, 15.5) -- Wash Away
	elseif self:GetStage() == 2 and self:GetBossId(114261) then -- Toe Knee
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3), false)
		self:PlaySound("stages", "long")
		self:Bar(227568, 8) -- Burning Leg Sweep
		self:Bar(227453, 19.7) -- Dashing Flame Gale
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 227449 then -- Dashing Flame Gale
		self:Message(227453, "orange")
		self:PlaySound(227453, "alert")
		self:Bar(227453, 37.6)
	end
end

function mod:BurningLegSweep(args)
	burningLegSweepCount = burningLegSweepCount + 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, burningLegSweepCount % 2 == 0 and 18.2 or 19.4)
end

function mod:ThunderRitual(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 17)
end

function mod:ThunderRitualApplied(args)
	if self:Me(args.destGUID) then
		local _, _, duration = self:UnitDebuff("player", args.spellId) -- Random duration
		self:TargetBar(args.spellId, duration or 8, args.destName)
	end
end

function mod:WashAway(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 23)
end
