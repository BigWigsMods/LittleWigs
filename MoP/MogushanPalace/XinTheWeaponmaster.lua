
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xin the Weaponmaster", 885, 698)
if not mod then return end
mod:RegisterEnableMob(61398)

local phase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "You are not the first to challenge me, peons. You will not be the last."

	L.blades = -5972 -- Blade Trap
	L.blades_icon = 119311

	L.crossbows = -5974 -- Death From Above!
	L.crossbows_icon = 120142
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {-5970, "blades", "crossbows"}
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

function mod:GroundSlam(args)
	self:Message(-5970, "Urgent", "Alert", CL["casting"]:format(args.spellName), args.spellId)
	self:Bar(-5970, 3, CL["cast"]:format(args.spellName), args.spellId)
end

function mod:Blades()
	self:Message("blades", "Attention", "Info", "66% - "..self:SpellName(L.blades), 119311)
end

function mod:Crossbows()
	self:Message("crossbows", "Attention", "Info", "33% - "..self:SpellName(L.crossbows), 120142)
end

function mod:PhaseWarn(unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if hp < 70 and phase == 1 then
		self:Message("blades", "Positive", nil, CL["soon"]:format(L["blades"]), false)
		phase = 2
	elseif hp < 39 and phase == 2 then
		self:Message("crossbows", "Positive", nil, CL["soon"]:format(L["crossbows"]), false)
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
	end
end

