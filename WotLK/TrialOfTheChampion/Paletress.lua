-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Argent Confessor Paletress", 650, 636)
if not mod then return end
mod:RegisterEnableMob(34928)
--mod.engageId = 2023 -- she shares it with Eadric

-------------------------------------------------------------------------------
--  Locals
--

local shielded = false

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.confess = 66680 -- the real cast
	L.confess_desc = -7577 -- EJ entry with a better description
	L.confess_icon = 66680
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		66537, -- Renew
		66515, -- Reflective Shield
		"confess",
		66619, -- Shadows of the Past
	}, {
		[66537] = "general",
		[66619] = -7578, -- Memory of the Past
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "ReflectiveShield", 66515)
	self:Log("SPELL_AURA_REMOVED", "ReflectiveShieldRemoved", 66515)
	self:Log("SPELL_CAST_START", "Renew", 66537)
	self:Log("SPELL_AURA_APPLIED", "Confess", 66680)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfThePast", 66619)

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	shielded = false
end

function mod:VerifyEnable(unit) -- becomes friendly after being defeated
	return UnitCanAttack("player", unit)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ReflectiveShield(args)
	shielded = true
	if not self:CheckOption("confess", "MESSAGE") then -- happens at the same time as Confess, display a message for it only if notifications for Confess are turned off
		self:MessageOld(args.spellId, "red", nil, CL.onboss:format(args.spellName))
	end
end

function mod:ReflectiveShieldRemoved(args)
	shielded = false
	self:MessageOld(args.spellId, "green", "info", CL.removed:format(args.spellName))
end

function mod:Renew(args)
	if shielded then return end -- don't bother announcing while she is shielded
	self:MessageOld(args.spellId, "orange", nil, CL.casting:format(args.spellName))
end

function mod:Confess(args)
	self:MessageOld("confess", "red", nil, CL.casting:format(args.spellName), args.spellId)
end

function mod:ShadowsOfThePast(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		if self:CheckOption("confess", "MESSAGE") then -- both happen at the same time, just display one message depending on the user's settings
			self:MessageOld("confess", "yellow", nil, CL.soon:format(self:SpellName(66680)), 66680)
		else
			self:MessageOld(66515, "yellow", nil, CL.soon:format(self:SpellName(66515)))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 43979 then -- Full Heal
		self:Win()
	end
end
