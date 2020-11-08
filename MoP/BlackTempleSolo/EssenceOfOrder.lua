
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Essence of Order", 1112)
if not mod then return end
mod:RegisterEnableMob(68151)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Essence of Order"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		134225, 134234
	}
end

function mod:OnRegister()
	self.displayName = L.name
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
	self:MessageOld(args.spellId, "orange", "long", CL["casting"]:format(args.spellName))
	self:Bar(args.spellId, 6, CL["cast"]:format(args.spellName))
	self:CDBar(args.spellId, 30)
end

function mod:Spellflame(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL["casting"]:format(args.spellName))
	self:CDBar(args.spellId, 10)
end
