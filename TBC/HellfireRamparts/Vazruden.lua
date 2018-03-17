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
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")
	self:Death("Win", 17537)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source) -- Stage 2
	-- Vazruden is the target of this BOSS_EMOTE, but his EJ name is "Vazruden the Herald", so checking against self.displayName won't work.
	if source == self:SpellName(-5072) then -- Nazan.
		self:Message("stages", "Neutral", nil, CL.stage:format(2), false)
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 17537 then -- Vazruden
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 45 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			self:Message("stages", "Neutral", nil, CL.soon:format(CL.stage:format(2)), false)
		end
	end
end
