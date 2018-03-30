
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Elder Nadox", 619, 580)
if not mod then return end
mod:RegisterEnableMob(29309)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		56130, -- Brood Plague
		-6042, -- Ahn'kahar Guardian
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_AURA_APPLIED", "BroodPlague", 56130, 59467)
	self:Log("SPELL_AURA_REMOVED", "BroodPlagueRemoved", 56130, 59467)

	self:Death("Win", 29309)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	self:Message(-6042, "Important", nil, msg, false)
end

function mod:BroodPlague(args)
	self:TargetMessage(56130, args.destName, "Attention")
	self:TargetBar(56130, 30, args.destName)
end

function mod:BroodPlagueRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

