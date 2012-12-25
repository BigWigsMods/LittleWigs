
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xin the Weaponmaster", 885, 698)
mod:RegisterEnableMob(61398)

local phase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "You are not the first to challenge me, peons. You will not be the last."

	L.blades, L.blades_desc = EJ_GetSectionInfo(5972)
	L.blades_icon = 119311

	L.crossbows, L.crossbows_desc = EJ_GetSectionInfo(5974)
	L.crossbows_icon = 120142
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"ej:5970", "blades", "crossbows", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GroundSlam", 119684)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Emote("Blades", "119311") -- %s activates his |cFFFF0404|Hspell:119311|h[Stream of Blades]|h|r trap!
	self:Emote("Crossbows", "120142") -- %s activates his |cFFFF0404|Hspell:120142|h[Crossbow]|h|r trap!
	self:Death("Win", 61398)
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "PhaseWarn", "boss1")
	phase = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GroundSlam(_, spellId, _, _, spellName)
	self:Message("ej:5970", CL["cast"]:format(spellName), "Urgent", spellId, "Alert")
	self:Bar("ej:5970", CL["cast"]:format(spellName), 3, spellId)
end

function mod:Blades()
	self:Message("blades", "66% - "..L["blades"], "Attention", 119311, "Info")
end

function mod:Crossbows()
	self:Message("crossbows", "33% - "..L["crossbows"], "Attention", 120142, "Info")
end

function mod:PhaseWarn(unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if hp < 70 and phase == 1 then
		self:Message("blades", CL["soon"]:format(L["blades"]), "Positive")
		phase = 2
	elseif hp < 39 and phase == 2 then
		self:Message("crossbows", CL["soon"]:format(L["crossbows"]), "Positive")
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
	end
end

