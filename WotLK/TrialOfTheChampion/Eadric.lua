-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Eadric the Pure", 650, 635)
if not mod then return end
mod:RegisterEnableMob(35119)
-- mod.engageId = 2023 -- doesn't fire ENCOUNTER_END on a wipe

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		66935, -- Radiance
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Radiance", 66935, 66862)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Radiance(args)
	self:Message(66935, "Urgent", nil, CL.casting:format(args.spellName))
	self:Bar(66935, 3)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 43979 then -- Full Heal
		self:Win()
	end
end
