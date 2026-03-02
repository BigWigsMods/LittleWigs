-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vazruden", 543, 529)
if not mod then return end
mod:RegisterEnableMob(17537, 17536) -- Vazruden, Nazan <Vazruden's Mount>
--mod:SetEncounterID(1892) -- no boss frames
--mod:SetRespawnTime(34) -- since his wipe-yell

-- ENCOUNTER_END issues:
-- - fires it 2 seconds before he respawns after a wipe instead of doing that when he actually despawns;
-- - fires it 9 seconds after being defeated.

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("RAID_BOSS_EMOTE")
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")
	self:Death("Deaths", 17537, 17536) -- Vazruden, Nazan <Vazruden's Mount>
end

function mod:OnEngage()
	deaths = 0
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RAID_BOSS_EMOTE(_, _, source) -- Stage 2
	-- Vazruden is the target of this BOSS_EMOTE, but his EJ name is "Vazruden the Herald", so checking against self.displayName won't work.
	if source == self:SpellName(-5072) then -- Nazan
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "info")
	end
end

function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == 1892 then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, encounterId, _, _, _, status)
	if encounterId == 1892 then
		if status == 0 then
			-- Delay slightly to avoid re-registering ENCOUNTER_END as part of :Reboot() during this ENCOUNTER_END dispatch
			self:SimpleTimer(function() self:Wipe() end, 2)
		elseif self:Retail() then -- No CLEU
			self:Win()
		end
	end
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 2 then
		self:Win()
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 17537 then -- Vazruden
		local hp = self:GetHealth(unit)
		if hp < 46 then
			self:UnregisterEvent(event)
			if hp > 40 then
				self:Message("stages", "cyan", CL.soon:format(CL.stage:format(2)), false)
			end
		end
	end
end
