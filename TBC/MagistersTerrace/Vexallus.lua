
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Vexallus", 585, 531)
if not mod then return end
mod:RegisterEnableMob(24744)
mod.engageId = 1898
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.energy_discharged = "%s discharged" -- %s = Pure Energy (npc ID = 24745)
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5085, -- Pure Energy
		44335, -- Energy Feedback
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EnergyFeedback", 44335)
	self:Log("SPELL_AURA_APPLIED_DOSE", "EnergyFeedback", 44335)
	self:Log("SPELL_AURA_REMOVED", "EnergyFeedbackRemoved", 44335)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EnergyFeedback(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "Urgent")
	self:TargetBar(args.spellId, 30, args.destName)
end

function mod:EnergyFeedbackRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 44322 or spellId == 46154 then -- Summon Pure Energy (normal / heroic)
		self:Message(-5085, "Important", nil, L.energy_discharged:format(self:SpellName(-5085)), false)
 	end
end
