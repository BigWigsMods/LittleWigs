-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vazruden", 543, 529)
if not mod then return end
mod:RegisterEnableMob(17537, 17536) -- Vazruden, Nazan <Vazruden's Mount>
-- mod.engageId = 1892 -- no boss frames
-- mod.respawnTime = 34 -- since his wipe-yell

-- ENCOUNTER_END issues:
-- - fires it 2 seconds before he respawns after a wipe instead of doing that when he actually despawns;
-- - fires it 9 seconds after being defeated.

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:CheckForEngage()
	self:Death("Win", 17537)
end

function mod:OnEngage()
	self:CheckForWipe()
	self:RegisterEvent("UNIT_HEALTH")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source) -- Stage 2
	-- Vazruden is the target of this BOSS_EMOTE, but his EJ name is "Vazruden the Herald", so checking against self.displayName won't work.
	if source == self:SpellName(-5072) then -- Nazan
		self:MessageOld("stages", "cyan", nil, CL.stage:format(2), false)
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 17537 then -- Vazruden
		local hp = self:GetHealth(unit)
		if hp < 45 then
			self:UnregisterEvent(event)
			self:MessageOld("stages", "cyan", nil, CL.soon:format(CL.stage:format(2)), false)
		end
	end
end
