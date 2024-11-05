--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baroness Anastari", 329, 451)
if not mod then return end
mod:RegisterEnableMob(10436) -- Baroness Anastari
mod:SetEncounterID(479)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17244, -- Possess
		18327, -- Silence
		{16867, "DISPEL"}, -- Banshee Curse
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PossessApplied", 17244) -- no cast event
	self:Log("SPELL_AURA_REMOVED", "PossessRemoved", 17244)
	self:Log("SPELL_CAST_START", "Silence", 18327)
	self:Log("SPELL_CAST_SUCCESS", "BansheeCurse", 16867)
	self:Log("SPELL_AURA_APPLIED", "BansheeCurseApplied", 16867)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10436)
	end
end

function mod:OnEngage()
	self:CDBar(16867, 4.9) -- Banshee Curse
	self:CDBar(18327, 7.3) -- Silence
	if not self:Solo() then
		self:CDBar(17244, 7.3) -- Possess
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PossessApplied(args)
	self:StopBar(args.spellId)
	self:StopBar(18327) -- Silence
	self:StopBar(16867) -- Banshee Curse
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

function mod:PossessRemoved(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:CDBar(args.spellId, 32.4)
	self:PlaySound(args.spellId, "info")
end

function mod:Silence(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BansheeCurse(args)
	self:CDBar(args.spellId, 8.5)
end

function mod:BansheeCurseApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end
