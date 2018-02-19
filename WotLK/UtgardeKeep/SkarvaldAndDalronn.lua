-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Skarvald & Dalronn", 574, 639)
if not mod then return end
--mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(24200, 24201) -- Skarvald the Constructor, Dalronn the Controller
mod.engageId = 2024
mod.respawnTime = 10

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		43650, -- Debilitate
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Debilitate", 43650)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Debilitate(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 8, args.destName)
end
