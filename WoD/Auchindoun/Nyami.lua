
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Soulbinder Nyami", 1182, 1186)
if not mod then return end
mod:RegisterEnableMob(76177)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		155327, -- Soul Vessel
		153994, -- Torn Spirits
		{154477, "DISPEL"}, -- Shadow Word: Pain
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "SoulVessel", 155327)
	self:Log("SPELL_CAST_START", "TornSpirits", 153994)
	self:Log("SPELL_AURA_APPLIED", "ShadowWordPain", 154477)

	self:Death("Win", 76177)
end

function mod:OnEngage()
	self:CDBar(153994, self:Normal() and 47 or 32) -- Torn Spirits
	self:CDBar(155327, self:Normal() and 21 or 6) -- Soul Vessel
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SoulVessel(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 51)
	self:Bar(args.spellId, 11.5, CL.cast:format(args.spellName))
end

function mod:TornSpirits(args)
	self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(CL.adds))
	self:CDBar(args.spellId, 51)
	self:Bar(args.spellId, 3, CL.adds)
end

function mod:ShadowWordPain(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, args.destName, "Important", "Alarm", nil, nil, true)
	end
end
