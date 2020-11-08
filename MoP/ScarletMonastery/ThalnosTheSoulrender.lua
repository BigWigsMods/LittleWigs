
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thalnos the Soulrender", 1004, 688)
if not mod then return end
mod:RegisterEnableMob(59789)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engage_yell = "My endless agony shall be yours, as well!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{-5865, "FLASH"}, -- Spirit Gale
		115297, -- Evict Soul
	}
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
	self:CDBar(115297, 25) -- Evict Soul, 25.x - 26.x
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiritGaleCast(args)
	self:MessageOld(-5865, "yellow", nil, CL["casting"]:format(args.spellName), args.spellId)
	self:Bar(-5865, 2, CL["cast"]:format(args.spellName), args.spellId)
end

function mod:SpiritGaleYou(args)
	if self:Me(args.destGUID) then
		self:MessageOld(-5865, "blue", "alarm", CL["underyou"]:format(args.spellName), args.spellId)
		self:Flash(-5865)
	end
end

function mod:SpiritGaleStopped(args)
	if args.extraSpellId == 115289 then
		self:StopBar(CL["cast"]:format(args.extraSpellName))
	end
end

function mod:EvictSoul(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "info")
	self:TargetBar(args.spellId, 6, args.destName)
	self:CDBar(args.spellId, 41)
end

function mod:EvictSoulRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

