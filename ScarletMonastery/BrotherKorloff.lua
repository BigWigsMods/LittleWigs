
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brother Korloff", 874, 671)
mod:RegisterEnableMob(59223)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "I will break you."

	L.fists, L.fists_desc = EJ_GetSectionInfo(5601)
	L.fists_icon = 114807

	L.firestorm, L.firestorm_desc = EJ_GetSectionInfo(5602)
	L.firestorm_icon = 113764
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"fists", 114460, "firestorm", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BlazingFists", 114807)
	self:Log("SPELL_CAST_SUCCESS", "FirestormKick", 113764)

	self:Log("SPELL_DAMAGE", "ScorchedEarthYou", 114465)
	self:Log("SPELL_MISSED", "ScorchedEarthYou", 114465)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 59223)
end

function mod:OnEngage()
	self:Bar("firestorm", "~"..GetSpellInfo(113764), 11, 113764)
	self:Bar("fists", "~"..GetSpellInfo(114807), 20, spellId)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlazingFists(_, spellId, _, _, spellName)
	self:Message("fists", spellName, "Urgent", spellId, "Alarm")
	self:Bar("fists", CL["cast"]:format(spellName), 6, spellId)
	self:Bar("fists", "~"..spellName, 30, spellId)
end

function mod:ScorchedEarthYou(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(114460, CL["underyou"]:format(spellName), "Personal", 114460, "Alert")
		self:FlashShake(114460)
	end
end

function mod:FirestormKick(player, spellId, _, _, spellName)
	self:Message("firestorm", spellName, "Attention", spellId, "Info")
	self:Bar("firestorm", CL["cast"]:format(spellName), 6, spellId)
	self:Bar("firestorm", "~"..spellName, 25.2, spellId)
end

