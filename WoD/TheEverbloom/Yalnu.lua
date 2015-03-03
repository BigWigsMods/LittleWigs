
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yalnu", 1008, 1210)
if not mod then return end
mod:RegisterEnableMob(83846)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		169613, -- Genesis
		169179, -- Colossal Blow
		169251, -- Entanglement
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Genesis", 169613)
	self:Log("SPELL_CAST_START", "ColossalBlow", 169179)
	self:Log("SPELL_CAST_SUCCESS", "Entanglement", 169251)

	self:Death("Win", 83846)
end

function mod:OnEngage()
	self:CDBar(169613, 26) -- Genesis
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Genesis(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 17, CL.cast:format(args.spellName))
	self:Bar(args.spellId, 60)
end

function mod:ColossalBlow(args)
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:Entanglement(args)
	self:Message(args.spellId, "Positive", "Info")
end

