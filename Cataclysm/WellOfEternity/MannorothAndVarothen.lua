--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mannoroth and Varo'then", 939, 292)
if not mod then return end
mod:RegisterEnableMob(54969, 55419) -- Mannoroth, Varo'then
mod:SetEncounterID(1274)
mod:SetRespawnTime(31.5)

--------------------------------------------------------------------------------
-- Locals
--

local spawnWarnings = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-4287, -- Nether Portal
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1", "boss2") -- Mannoroth is boss2 until Varo'then dies
end

function mod:OnEngage()
	spawnWarnings = 1
end

function mod:VerifyEnable(unit, mobId)
	if mobId == 54969 then
		-- encounter ends with Mannoroth at 25%
		return self:GetHealth(unit) > 25
	end
	return true
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local adds = {
		-- HP threshold + 5%, EJ entry
		{ 90, -4294 }, -- Felhound
		{ 75, -4295 }, -- Felguard
		{ 65, -4296 }, -- Doomguard Devastator
		{ 50, -4297 }, -- Infernal
	}

	function mod:UNIT_HEALTH(event, unit)
		if self:MobId(self:UnitGUID(unit)) ~= 54969 then return end -- only track Mannoroth
		local hp = self:GetHealth(unit)
		if spawnWarnings <= #adds and hp < adds[spawnWarnings][1] then
			self:Message(-4287, "cyan", CL.soon:format(self:SpellName(adds[spawnWarnings][2])), false)
			spawnWarnings = spawnWarnings + 1

			while spawnWarnings <= #adds and hp < adds[spawnWarnings][1] do
				-- display multiple messages if a high-level character hits multiple thresholds with 1 damage event
				self:Message(-4287, "cyan", CL.soon:format(self:SpellName(adds[spawnWarnings][2])), false)
				spawnWarnings = spawnWarnings + 1
			end

			if spawnWarnings > #adds then
				self:UnregisterUnitEvent(event, "boss1", "boss2")
			end
			self:PlaySound(-4287, "info")
		end
	end
end
