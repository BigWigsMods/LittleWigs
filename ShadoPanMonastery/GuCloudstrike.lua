
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
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"ej:5632", "ej:5633", {"ej:5630", "FLASHSHAKE"}, "stages", "bosskill"}
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
	self:Message("stages", CL["phase"]:format(1)..": "..self.displayName, "Positive", nil, "Info")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningBreath(args)
	self:Message("ej:5632", args.spellName, "Urgent", args.spellId, "Alert")
	self:Bar("ej:5632", "~"..args.spellName, 9.5, args.spellId) -- 9.6 - 9.7
end

function mod:MagneticShroud(args)
	self:Message("ej:5633", args.spellName, "Attention", args.spellId)
	self:Bar("ej:5633", "~"..args.spellName, 13, args.spellId) -- 13.2 - 15.7
end

do
	local breath = mod:SpellName(102573)
	local shroud = mod:SpellName(107140)
	local _, serpent = EJ_GetCreatureInfo(2, 673)
	function mod:Phase2()
		self:Message("stages", CL["phase"]:format(2)..": "..serpent, "Positive", nil, "Info")
		self:Bar("ej:5632", "~"..breath, 7, 102573)
		self:Bar("ej:5633", "~"..shroud, 20, 107140)
	end
	function mod:Phase3()
		self:Message("stages", CL["phase"]:format(3)..": "..self.displayName.. " ("..self:SpellName(65294)..")", "Positive", nil, "Info") -- (Empowered)
		self:StopBar("~"..breath)
		self:StopBar("~"..shroud)
	end
end

function mod:StaticField(args)
	if UnitIsUnit(player, "player") then
		self:LocalMessage("ej:5630", CL["underyou"]:format(args.spellName), "Personal", 106941, "Alarm")
		self:FlashShake("ej:5630")
	end
end

