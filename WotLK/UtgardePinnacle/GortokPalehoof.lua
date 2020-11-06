
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Gortok Palehoof", 575, 642)
if not mod then return end
mod:RegisterEnableMob(26687)

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

	self:Death("Win", 26687)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WitheringRoar()
	self:MessageOld(59267, "orange")
	self:CDBar(59267, 10)
end

function mod:Impale(args)
	self:TargetMessageOld(59268, args.destName, "yellow")
end

