
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ranjit", 989, 965)
if not mod then return end
mod:RegisterEnableMob(75964)

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
		156793, -- Four Winds
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "FourWinds", 156793)

	self:Death("Win", 75964)
end

function mod:OnEngage()
	self:Bar(156793, 36) -- Four Winds
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FourWinds(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:Bar(args.spellId, 36)
end

