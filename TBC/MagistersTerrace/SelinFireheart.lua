
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Selin Fireheart", 798, 530)
if not mod then return end
mod:RegisterEnableMob(24723)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		44320, -- Mana Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Channel", 44320)
	self:Log("SPELL_AURA_REMOVED", "ChannelEnd", 44320)
	self:Death("Win", 24723)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Channel(args)
	self:Message(args.spellId, "Important", "Info")
	self:Bar(args.spellId, 10)
end

function mod:ChannelEnd(args)
	self:StopBar(args.spellName)
end

