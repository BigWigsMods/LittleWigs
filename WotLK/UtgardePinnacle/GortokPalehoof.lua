--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gortok Palehoof", 575, 642)
if not mod then return end
mod:RegisterEnableMob(26687)
mod:SetEncounterID(mod:Classic() and 579 or 2027)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		59267, -- Withering Roar
		59268, -- Impale
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "WitheringRoar", 48256, 59267) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "Impale", 48261, 59268) -- normal, heroic
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WitheringRoar()
	self:Message(59267, "orange")
	self:CDBar(59267, 10)
end

function mod:Impale(args)
	self:TargetMessage(59268, "yellow", args.destName)
end
