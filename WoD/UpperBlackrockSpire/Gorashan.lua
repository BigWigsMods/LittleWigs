
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Orebender Gor'ashan", 995, 1226)
if not mod then return end
mod:RegisterEnableMob(76413)

--------------------------------------------------------------------------------
-- Locals
--

local stacks = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.counduitLeft = "%d |4Conduit:Conduits; left"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		166168, -- Power Conduit
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "PowerConduit", 166168)
	self:Log("SPELL_AURA_REMOVED", "PowerConduitRemoved", 166168)
	self:Log("SPELL_AURA_REMOVED_DOSE", "PowerConduitReduced", 166168)

	self:Death("Win", 76413)
end

function mod:OnEngage()
	stacks = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PowerConduit(args)
	stacks = stacks + 1
	self:Message(args.spellId, "Important", "Long", CL.count:format(args.spellName, stacks))
end

function mod:PowerConduitRemoved(args)
	self:Message(args.spellId, "Positive", nil, CL.removed:format(args.spellName))
end

function mod:PowerConduitReduced(args)
	self:Message(args.spellId, "Attention", nil, L.counduitLeft:format(args.amount))
end

