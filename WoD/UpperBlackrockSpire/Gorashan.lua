
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Orebender Gor'ashan", 1358, 1226)
if not mod then return end
mod:RegisterEnableMob(76413)
--BOSS_KILL#1761#Orebender Gor'ashan

--------------------------------------------------------------------------------
-- Locals
--

local stacks = 0
local nextPowerConduitWarning = 80

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.counduitLeft = "%d |4Conduit:Conduits; left"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		166168, -- Power Conduit
		154448, -- Shrapnel Nova
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "PowerConduit", 166168)
	self:Log("SPELL_AURA_REMOVED", "PowerConduitRemoved", 166168)
	self:Log("SPELL_AURA_REMOVED_DOSE", "PowerConduitReduced", 166168)

	self:Log("SPELL_CAST_START", "ShrapnelNova", 154448)

	self:Death("Win", 76413)
end

function mod:OnEngage()
	stacks = 0
	nextPowerConduitWarning = 80 -- 75%, 50%, 25%
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:CDBar(154448, 14.4) -- Shrapnel Nova
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextPowerConduitWarning then
		nextPowerConduitWarning = nextPowerConduitWarning - 25
		self:Message(166168, "Positive", nil, CL.soon:format(self:SpellName(166168)), false)
		if nextPowerConduitWarning < 25 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
		end
	end
end

function mod:PowerConduit(args)
	stacks = stacks + (self:Normal() and 1 or 2)
	self:Message(args.spellId, "Important", "Warning", CL.percent:format(nextPowerConduitWarning + 20, CL.count:format(args.spellName, stacks)))
end

function mod:PowerConduitRemoved(args)
	self:Message(args.spellId, "Positive", "Long", CL.removed:format(args.spellName))
end

function mod:PowerConduitReduced(args)
	self:Message(args.spellId, "Attention", nil, L.counduitLeft:format(args.amount))
end

function mod:ShrapnelNova(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 2.5, CL.cast:format(args.spellName))
	self:CDBar(args.spellId, 30) -- 29-33
end

