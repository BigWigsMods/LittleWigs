
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zo'phex the Sentinel", 2441, 2437)
if not mod then return end
mod:RegisterEnableMob(175616) -- Zo'phex
mod:SetEncounterID(2425)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		347949, -- Interrogation
		345990, -- Containment Cell
		345770, -- Impound Contraband
		346204, -- Armed Security
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "InterrogationApplied", 347949)
	self:Log("SPELL_AURA_APPLIED", "ContainmentCellApplied", 345990)
	self:Death("ContainmentCellDeath", 175576)
	self:Log("SPELL_AURA_APPLIED", "ImpoundContrabandApplied", 345770)
	self:Log("SPELL_AURA_REMOVED", "ImpoundContrabandRemoved", 345770)
	self:Log("SPELL_CAST_SUCCESS", "ArmedSecurity", 346204)
end

function mod:OnEngage()
	self:Bar(347949, 34.1) -- Interrogation
	self:Bar(345770, 19.3) -- Impound Contraband
	self:Bar(346204, 8.7) -- Armed Security
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InterrogationApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, self:Me(args.destGUID) and "warning" or "alert", nil, args.destName)
	self:CDBar(args.spellId, 42.5)
	self:CastBar(args.spellId, 5)
end

function mod:ContainmentCellApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, self:Me(args.destGUID) and "alert" or "warning")
end

function mod:ContainmentCellDeath(args)
	self:Message(345990, "green", CL.removed:format(args.destName))
	self:PlaySound(345990, "info")
end

function mod:ImpoundContrabandApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ImpoundContrabandRemoved(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "removed")
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ArmedSecurity(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
