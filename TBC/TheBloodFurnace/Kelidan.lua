-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Keli'dan the Breaker", 725, 557)
if not mod then return end
--mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17377)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		30940, -- Burning Nova
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BurningNova", 30940)
	self:Death("Win", 17377)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:BurningNova(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 5)
end
