
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gu Cloudstrike", 877, 673)
mod:RegisterEnableMob(56747, 56754) -- Gu, Serpent

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_say = "Let me show you my power."

	L.breath, L.breath_desc = EJ_GetSectionInfo(5632)
	L.breath_icon = 102573

	L.shroud, L.shroud_desc = EJ_GetSectionInfo(5633)
	L.shroud_icon = 107140

	L.field, L.field_desc = EJ_GetSectionInfo(5630)
	L.field_icon = 106923
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"breath", "shroud", {"field", "FLASHSHAKE"}, "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LightningBreath", 102573)
	self:Log("SPELL_CAST_START", "MagneticShroud", 107140)
	self:Log("SPELL_AURA_APPLIED", "Phase2", 110945)
	self:Log("SPELL_AURA_REMOVED", "Phase3", 110945)

	self:Log("SPELL_DAMAGE", "StaticField", 106932, 128889)
	self:Log("SPELL_MISSED", "StaticField", 106932, 128889)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 56747)
end

function mod:OnEngage()
	self:Message("bosskill", CL["phase"]:format(1)..": "..self.displayName, "Positive", nil, "Info")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningBreath(_, spellId, _, _, spellName)
	self:Message("breath", spellName, "Urgent", spellId, "Alert")
	self:Bar("breath", "~"..spellName, 9.5, spellId) -- 9.6 - 9.7
end

function mod:MagneticShroud(_, spellId, _, _, spellName)
	self:Message("shroud", spellName, "Attention", spellId)
	self:Bar("shroud", "~"..spellName, 13, spellId) -- 13.2 - 15.7
end

do
	local breath = GetSpellInfo(102573)
	local shroud = GetSpellInfo(107140)
	local _, serpent = EJ_GetCreatureInfo(2, 673)
	function mod:Phase2()
		self:Message("bosskill", CL["phase"]:format(2)..": "..serpent, "Positive", nil, "Info")
		self:Bar("breath", "~"..breath, 7, 102573)
		self:Bar("shroud", "~"..shroud, 20, 107140)
	end
	function mod:Phase3()
		self:Message("bosskill", CL["phase"]:format(3)..": "..self.displayName.. " ("..GetSpellInfo(65294)..")", "Positive", nil, "Info") -- (Empowered)
		self:SendMessage("BigWigs_StopBar", self, "~"..breath)
		self:SendMessage("BigWigs_StopBar", self, "~"..shroud)
	end
end

function mod:StaticField(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage("field", CL["underyou"]:format(spellName), "Personal", 106941, "Alert")
		self:FlashShake("field")
	end
end

