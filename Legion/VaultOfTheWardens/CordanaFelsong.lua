
--------------------------------------------------------------------------------
-- TODO List:
-- - Would be nice to find a way to track the Light, but there is none :(

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cordana Felsong", 1045, 1470)
if not mod then return end
mod:RegisterEnableMob(95888)
mod.engageId = 1818

--------------------------------------------------------------------------------
-- Locals
--

local warnedForStealLight = nil
local warnedForCreepingDoom = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.kick_combo = "Kick Combo"
	L.kick_combo_desc = GetSpellDescription(197251).."\n"..GetSpellDescription(197250)
	L.kick_combo_icon = 197251
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{206567, "FLASH"}, -- Stolen Light
		{197422, "FLASH"}, -- Creeping Doom
		197796, -- Avatar of Vengeance
		"kick_combo",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "StolenLight", 206567)
	self:Log("SPELL_AURA_APPLIED", "StolenLightRemoved", 206567)
	self:Log("SPELL_CAST_START", "CreepingDoom", 197422, 213685)
	self:Log("SPELL_AURA_REMOVED", "CreepingDoomRemoved", 197422)
	self:Log("SPELL_CAST_START", "KnockdownKick", 197251) -- used for kick_combo
	self:Death("AvatarDeath", 100351)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	warnedForStealLight = nil
	warnedForCreepingDoom = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, spellName, _, castGUID, spellId)
	if spellId == 197796 then -- Avatar of Vengeance
		self:Message(spellId, "Urgent", "Long")
		self:Bar(spellId, 45)
	end
end

function mod:StolenLight(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
	self:StopBar(L.kick_combo)
end

function mod:StolenLightRemoved(args)
	self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
	self:CDBar("kick_combo", 16, L.kick_combo, L.kick_combo_icon)
end

function mod:CreepingDoom(args)
	self:Message(197422, "Important", "Info", CL.incoming:format(args.spellName))
	self:Flash(197422)
	self:Bar(args.spellId, 35, CL.cast:format(args.spellName))
	if args.spellId == 197422 then
		self:StopBar(L.kick_combo)
	end
end

function mod:CreepingDoomRemoved(args)
	self:Message(args.spellId, "Neutral", "Info", CL.over:format(args.spellName))
	self:CDBar("kick_combo", 16, L.kick_combo, L.kick_combo_icon)
end

function mod:KnockdownKick(args)
	self:Message("kick_combo", "Attention", self:Tank() and "Warning", L.kick_combo, L.kick_combo_icon)
	self:CDBar("kick_combo", 16, L.kick_combo, L.kick_combo_icon)
end

function mod:AvatarDeath()
	self:Message(197796, "Positive", "Long", CL.removed:format(self:SpellName(205004))) -- Vengeance removed
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 80 and not warnedForStealLight then
		warnedForStealLight = true
		self:Message(206567, "Attention", nil, CL.soon:format(self:SpellName(206387))) -- Steal Light soon
	elseif hp < 45 and not warnedForCreepingDoom then
		warnedForCreepingDoom = true
		self:Message(197422, "Important", nil, CL.soon:format(self:SpellName(197422))) -- Creeping Doom soon
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
	end
end
