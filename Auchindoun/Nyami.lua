
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Soulbinder Nyami", 984, 1186)
mod:RegisterEnableMob(76177)

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
		155327, 153994, "bosskill",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SoulVessel", 155327)
	self:Log("SPELL_CAST_START", "TornSpirits", 153994)

	self:Death("Win", 76177)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SoulVessel(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 27.7)
	self:Bar(args.spellId, 7, CL.cast:format(args.spellName))
end

function mod:TornSpirits(args)
	self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(CL.adds))
	self:CDBar(args.spellId, 27.7)
	self:Bar(args.spellId, 3, CL.adds)
end

