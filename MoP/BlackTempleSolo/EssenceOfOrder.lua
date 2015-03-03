
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Essence of Order", 919)
if not mod then return end
mod:RegisterEnableMob(68151)

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
	return {134225, 134234}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Hellfire", 134225)
	self:Log("SPELL_CAST_START", "Spellflame", 134234)

	self:Death("Win", 68151)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hellfire(args)
	self:Message(args.spellId, "Urgent", "Long", CL["casting"]:format(args.spellName))
	self:Bar(args.spellId, 6, CL["cast"]:format(args.spellName))
	self:CDBar(args.spellId, 30)
end

function mod:Spellflame(args)
	self:Message(args.spellId, "Attention", "Alert", CL["casting"]:format(args.spellName))
	self:CDBar(args.spellId, 10)
end

