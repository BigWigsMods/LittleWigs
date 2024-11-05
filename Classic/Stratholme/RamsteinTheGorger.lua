--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ramstein the Gorger", 329, 455)
if not mod then return end
mod:RegisterEnableMob(10439) -- Ramstein the Gorger
mod:SetEncounterID(483)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		17307, -- Knockout
		5568, -- Trample
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Knockout", 17307)
	self:Log("SPELL_AURA_APPLIED", "KnockoutApplied", 17307)
	self:Log("SPELL_CAST_SUCCESS", "Trample", 5568)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10439)
	end
end

function mod:OnEngage()
	self:CDBar(5568, 4.9) -- Trample
	self:CDBar(17307, 8.5) -- Knockout
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Knockout(args)
	self:CDBar(args.spellId, 13.4)
end

function mod:KnockoutApplied(args)
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:Trample(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 8.5)
	self:PlaySound(args.spellId, "info")
end
