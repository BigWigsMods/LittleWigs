
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Orebender Gor'ashan", 1358, 1226)
if not mod then return end
mod:RegisterEnableMob(76413)
mod.engageId = 1761
mod.respawnTime = 29

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
	self:Log("SPELL_AURA_APPLIED", "PowerConduit", 166168)
	self:Log("SPELL_AURA_REMOVED", "PowerConduitRemoved", 166168)
	self:Log("SPELL_AURA_REMOVED_DOSE", "PowerConduitReduced", 166168)

	self:Log("SPELL_CAST_START", "ShrapnelNova", 154448)
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

function mod:UNIT_HEALTH_FREQUENT(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextPowerConduitWarning then
		nextPowerConduitWarning = nextPowerConduitWarning - 25
		self:Message(166168, "green", nil, CL.soon:format(self:SpellName(166168)), false)
		if nextPowerConduitWarning < 25 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:PowerConduit(args)
	stacks = stacks + (self:Normal() and 1 or 2)
	self:Message(args.spellId, "red", "Warning", CL.percent:format(nextPowerConduitWarning + 20, CL.count:format(args.spellName, stacks)))
end

function mod:PowerConduitRemoved(args)
	self:Message(args.spellId, "green", "Long", CL.removed:format(args.spellName))
end

function mod:PowerConduitReduced(args)
	self:Message(args.spellId, "yellow", nil, L.counduitLeft:format(args.amount))
end

function mod:ShrapnelNova(args)
	self:Message(args.spellId, "orange", "Alert", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 2.5, CL.cast:format(args.spellName))
	self:CDBar(args.spellId, 30) -- 29-33
end

