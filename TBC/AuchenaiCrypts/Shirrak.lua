-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Shirrak the Dead Watcher", 558, 523)
if not mod then return end
mod:RegisterEnableMob(18371)
-- mod.engageId = 1890 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		-5041, -- Focus Fire
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Death("Win", 18371)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source, _, _, target) -- Focus Fire
	if source == self.displayName then -- this is the only BOSS_EMOTE that appears during this encounter
		self:TargetMessageOld(-5041, target, "yellow")
	end
end
