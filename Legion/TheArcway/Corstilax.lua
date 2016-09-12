
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Corstilax", 1079, 1498)
if not mod then return end
mod:RegisterEnableMob(98205)
mod.engageId = 1825

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		195804, -- Quarantine
		196068, -- Suppression Protocol
		196115, -- Cleansing Force
		-- Destabilized Orb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Quarantine", 195804)
	self:Log("SPELL_AURA_APPLIED", "SuppressionProtocol", 196068)
	self:Log("SPELL_CAST_START", "CleansingForce", 196115)
end

function mod:OnEngage()
	-- TODO Timers
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Quarantine(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Info", nil, nil, true)
end

function mod:SuppressionProtocol(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
end

function mod:CleansingForce(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:Bar(args.spellId, 10, ("<%s>")):format(args.spellName)
end

function mod:DestabilizedOrb(args)
	self:Message(args.spellId, "Attention")
end
