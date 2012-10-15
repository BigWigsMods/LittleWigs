
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thalnos the Soulrender", 874, 688)
mod:RegisterEnableMob(59789)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "My endless agony shall be yours, as well!"

	L.spirit, L.spirit_desc = EJ_GetSectionInfo(5865)
	L.spirit_icon = 115289
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {{"spirit", "FLASHSHAKE"}, 115297, "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpiritGaleCast", 115289)
	self:Log("SPELL_AURA_APPLIED", "SpiritGaleYou", 115291)
	self:Log("SPELL_INTERRUPT", "SpiritGaleStopped", "*")

	self:Log("SPELL_AURA_APPLIED", "EvictSoul", 115297)
	self:Log("SPELL_AURA_REMOVED", "EvictSoulRemoved", 115297)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59789)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiritGaleCast(_, spellId, _, _, spellName)
	self:Message("spirit", CL["cast"]:format(spellName), "Attention", spellId, "Alarm")
	self:Bar("spirit", CL["cast"]:format(spellName), 2, spellId)
end

function mod:SpiritGaleYou(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage("spirit", CL["underyou"]:format(spellName), "Personal", spellId, "Alert")
		self:FlashShake("spirit")
	end
end

function mod:SpiritGaleStopped(_, _, _, secSpellId, _, secSpellName)
	if secSpellId == 115289 then
		self:SendMessage("BigWigs_StopBar", self, CL["cast"]:format(secSpellName))
	end
end

function mod:EvictSoul(player, spellId, _, _, spellName)
	self:TargetMessage(spellId, spellName, player, "Urgent", spellId, "Info")
	self:Bar(spellId, CL["other"]:format(spellName, player), 6, spellId)
end

function mod:EvictSoulRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, CL["other"]:format(spellName, player))
end

