-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Shirrak the Dead Watcher", 558, 523)
if not mod then return end
mod:RegisterEnableMob(18371)
mod:SetEncounterID(1890)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{-5041, "ME_ONLY_EMPHASIZE", "SAY"}, -- Focus Fire
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source, _, _, target) -- Focus Fire
	if not self:IsSecret(source) and not self:IsSecret(target) and source == self.displayName then -- this is the only BOSS_EMOTE that appears during this encounter
		target = self:Ambiguate(target, "none")
		self:TargetMessage(-5041, "yellow", target)
		local guid = self:UnitGUID(target)
		if self:Me(guid) then
			self:Say(-5041, nil, nil, "Focus Fire")
			self:PlaySound(-5041, "warning", nil, self:UnitName("player"))
		end
	end
end
