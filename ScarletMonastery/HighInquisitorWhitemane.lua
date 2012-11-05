
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Inquisitor Whitemane", 874, 674)
mod:RegisterEnableMob(3977, 60040) -- Whitemane, Durand

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "My legend begins NOW!"

	L.steel, L.steel_desc = EJ_GetSectionInfo(5636)
	L.steel_icon = 115629
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {113134, "steel", "stages", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MassRes", 113134)
	self:Log("SPELL_INTERRUPT", "MassResStopped", "*")

	self:Log("SPELL_CAST_SUCCESS", "Sleep", 9256)

	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 3977, 60040)
end

function mod:OnEngage()
	deaths = 0
	self:Message("stages", CL["phase"]:format(1).. ": "..EJ_GetSectionInfo(5635), "Positive")
	self:Bar("steel", L["steel"], 10.8, 115629)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MassRes(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Urgent", spellId, "Alarm")
	self:Bar(spellId, spellName, 10, spellId)
end

function mod:MassResStopped(_, _, _, secSpellId, _, secSpellName)
	if secSpellId == 113134 then
		self:StopBar(secSpellName)
	end
end

function mod:Sleep(_, spellId, _, _, spellName)
	self:Message("stages", CL["phase"]:format(3), "Positive")
	self:Bar("stages", spellName, 10, spellId)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, spellName, _, _, spellId)
	if spellId == 115627 and unit:match("boss") then
		self:Message("steel", spellName, "Attention", 115629)
		self:Bar("steel", "~"..spellName, 26, 115629) -- 26.x - 27.x
	end
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 1 then
		self:Message("stages", CL["phase"]:format(2).. ": "..EJ_GetSectionInfo(5638), "Positive")
		self:StopBar("~"..L["steel"])
	elseif deaths == 3 then
		self:Win()
	end
end

