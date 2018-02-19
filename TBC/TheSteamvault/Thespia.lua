-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hydromancer Thespia", 545, 573)
if not mod then return end
--mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17797)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		25033, -- Lightning Cloud
		31481, -- Lung Burst
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "LightningCloud", 25033)
	self:Log("SPELL_AURA_APPLIED", "LungBurst", 31481)
	self:Death("Win", 17797)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:LightningCloud(args)
	self:Message(args.spellId, "Attention")
end

function mod:LungBurst(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 10, args.spellName)
end
