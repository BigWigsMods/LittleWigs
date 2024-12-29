--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sneed", 36, 2626)
if not mod then return end
mod:RegisterEnableMob(
	642, -- Sneed's Shredder
	643 -- Sneed
)
mod:SetEncounterID(mod:Retail() and 2968 or 2742)
--mod:SetRespawnTime(0)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sneed's Shredder
		7399, -- Terrify
		5141, -- Eject Sneed
		-- Sneed
		6713, -- Disarm
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Terrify", 7399)
	self:Log("SPELL_CAST_SUCCESS", "EjectSneed", 5141)
	self:Log("SPELL_CAST_SUCCESS", "Disarm", 6713)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(7399, 0.8) -- Terrify
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Terrify(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "info")
end

function mod:EjectSneed(args)
	self:StopBar(7399) -- Terrify
	self:SetStage(2)
	self:Message(args.spellId, "cyan")
	self:CDBar(6713, 4.0) -- Disarm
	self:PlaySound(args.spellId, "long")
end

function mod:Disarm(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 70.2)
	self:PlaySound(args.spellId, "alert")
end
