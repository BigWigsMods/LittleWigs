--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maleki the Pallid", 329, 453)
if not mod then return end
mod:RegisterEnableMob(10438) -- Maleki the Pallid
mod:SetEncounterID(481)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{16869, "DISPEL"}, -- Ice Tomb
		17620, -- Drain Life
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "IceTomb", 16869)
	self:Log("SPELL_AURA_APPLIED", "IceTombApplied", 16869)
	self:Log("SPELL_CAST_SUCCESS", "DrainLife", 17620)
	self:Log("SPELL_AURA_APPLIED", "DrainLifeApplied", 17620)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10438)
	end
end

function mod:OnEngage()
	self:CDBar(16869, 6.4) -- Ice Tomb
	self:CDBar(17620, 12.4) -- Drain Life
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:IceTomb(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:IceTombApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:DrainLife(args)
	self:CDBar(args.spellId, 17.0)
end

function mod:DrainLifeApplied(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
