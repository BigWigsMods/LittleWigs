-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Argent Confessor Paletress", 542, 636)
if not mod then return end
mod:RegisterEnableMob(34928)
--mod.engageId = 2023 -- she shares it with Eadric

-------------------------------------------------------------------------------
--  Locals

local shielded = false

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		66537, -- Renew
		66515, -- Reflective Shield
		-7577, -- Summon Memory, the actual cast is called "Confess" but the EJ entry has a better description
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

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	shielded = false
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ReflectiveShield(args)
	shielded = true
	if self:GetOption(-7577) == 0 then -- happens at the same time as Confess, display a message for it only if notifications for Confess are turned off
		self:Message(args.spellId, "Important", nil, CL.onboss:format(args.spellName))
	end
end

function mod:ReflectiveShieldRemoved(args)
	shielded = false
	self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
end

function mod:Renew(args)
	if shielded then return end -- don't bother announcing while she is shielded
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
end

function mod:Confess(args)
	self:Message(-7577, "Important", nil, CL.casting:format(args.spellName), args.spellId)
end

function mod:ShadowsOfThePast(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 55 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		if self:GetOption(-7577) then -- both happen at the same time, just display one message depending on the user's settings
			self:Message(-7577, "Attention", nil, CL.soon:format(self:SpellName(66680)), 66680)
		else
			self:Message(66515, "Attention", nil, CL.soon:format(self:SpellName(66515)))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 43979 then -- Full Heal
		self:Win()
	end
end
