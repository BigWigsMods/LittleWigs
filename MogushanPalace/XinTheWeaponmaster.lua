
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xin the Weaponmaster", 885, 698)
mod:RegisterEnableMob(61398)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "You are not the first to challenge me, peons. You will not be the last."
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"ej:5970", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GroundSlam", 119684)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 61398)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GroundSlam(_, spellId, _, _, spellName)
	self:Message("ej:5970", CL["cast"]:format(spellName), "Urgent", spellId, "Alarm")
	self:Bar("ej:5970", CL["cast"]:format(spellName), 3, spellId)
end

