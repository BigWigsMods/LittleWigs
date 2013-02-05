
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
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {{"ej:5865", "FLASH"}, 115297, "bosskill"}
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

function mod:OnEngage()
	self:Bar(115297, "~"..self:SpellName(115297), 25, 115297) -- 25.x - 26.x
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiritGaleCast(args)
	self:Message("ej:5865", CL["cast"]:format(args.spellName), "Attention", args.spellId)
	self:Bar("ej:5865", CL["cast"]:format(args.spellName), 2, args.spellId)
end

function mod:SpiritGaleYou(args)
	if UnitIsUnit(args.destName, "player") then
		self:LocalMessage("ej:5865", CL["underyou"]:format(args.spellName), "Personal", args.spellId, "Alarm")
		self:Flash("ej:5865")
	end
end

function mod:SpiritGaleStopped(args)
	if args.extraSpellId == 115289 then
		self:StopBar(CL["cast"]:format(args.extraSpellName))
	end
end

function mod:EvictSoul(args)
	self:TargetMessage(args.spellId, args.spellName, args.destName, "Urgent", args.spellId, "Info")
	self:TargetBar(args.spellId, args.spellName, args.destName, 6, args.spellId)
	self:Bar(args.spellId, "~"..args.spellName, 41, args.spellId)
end

function mod:EvictSoulRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

