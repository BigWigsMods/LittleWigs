
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Inquisitor Whitemane", 874, 674)
mod:RegisterEnableMob(3977, 60040) -- Whitemane, Durand

local count = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "My legend begins NOW!"

	L.steel, L.steel_desc = EJ_GetSectionInfo(5601)
	L.steel_icon = 115629
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {113134, "steel", "bosskill"}
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
	count = 0
	self:Message("bosskill", CL["phase"]:format(1).. ": "..EJ_GetSectionInfo(5635), "Positive")
	self:Bar("steel", "~"..L["steel"], 10.8, 115629)
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
		self:SendMessage("BigWigs_StopBar", self, secSpellName)
	end
end

function mod:Sleep(_, spellId, _, _, spellName)
	self:Message("bosskill", CL["phase"]:format(3), "Positive")
	self:Bar("bosskill", spellName, 10, spellId)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, spellName, _, _, spellId)
	if spellId == 115627 and unit:match("boss") then
		self:Message("steel", spellName, "Attention", 115629)
		self:Bar("steel", "~"..spellName, 27, 115629)
	end
end

function mod:Deaths()
	count = count + 1
	if count == 1 then
		self:Message("bosskill", CL["phase"]:format(2).. ": "..EJ_GetSectionInfo(5638), "Positive")
	elseif count == 3 then
		self:Win()
	end
end

