-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Argent Confessor Paletress", 650, 636)
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
		66515, -- Reflective Shield
		66537, -- Renew
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "ReflectiveShield", 66515)
	self:Log("SPELL_AURA_REMOVED", "ReflectiveShieldRemoved", 66515)
	self:Log("SPELL_CAST_START", "Renew", 66537)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	shielded = false
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ReflectiveShield()
	shielded = true
end

function mod:ReflectiveShieldRemoved()
	shielded = false
end

function mod:Renew(args)
	if shielded then return end -- don't bother announcing while she is shielded
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 43979 then -- Full Heal
		self:Win()
	end
end
