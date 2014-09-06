
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Gug'rokk", 964, 889)
if not mod then return end
mod:RegisterEnableMob(74790)

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
		150776, 150755, 150677, 150678, "bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "MagmaEruption", 150776)
	self:Log("SPELL_CAST_START", "UnstableSlag", 150755)
	self:Log("SPELL_CAST_START", "MoltenBlast", 150677)
	self:Log("SPELL_AURA_APPLIED", "MoltenCore", 150678)
	self:Log("SPELL_AURA_APPLIED_DOSE", "MoltenCore", 150678)

	self:Death("Win", 74790)
end

function mod:OnEngage()
	self:CDBar(150755, 20) -- Summon Unstable Slag
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MagmaEruption(args)
	self:Message(args.spellId, "Urgent", "Info")
	self:CDBar(args.spellId, 20) -- 20-21
end

function mod:UnstableSlag(args)
	self:Message(args.spellId, "Important", "Warning")
	self:CDBar(args.spellId, 21)
end

function mod:MoltenBlast(args)
	self:Message(args.spellId, "Attention", "Long")
end

function mod:MoltenCore(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "Attention")
end

