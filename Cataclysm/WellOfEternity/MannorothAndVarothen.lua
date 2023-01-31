--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mannoroth and Varo'then", 939, 292)
if not mod then return end
mod:RegisterEnableMob(54969, 55419) -- Mannoroth, Varo'then
mod.engageId = 1274
mod.respawnTime = 31.5

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
		if self:MobId(self:UnitGUID(unit)) ~= 54969 then return end -- Varo'then is of no interest
		local hp = self:GetHealth(unit)
		if hp < adds[spawnWarnings][1] then
			self:MessageOld(-4287, "yellow", "info", CL.soon:format(self:SpellName(adds[spawnWarnings][2])), false)
			spawnWarnings = spawnWarnings + 1

			while spawnWarnings <= #adds and hp < adds[spawnWarnings][1] do
				-- display multiple messages if a high-level character hits multiple thresholds with 1 damage event
				self:MessageOld(-4287, "yellow", nil, CL.soon:format(self:SpellName(adds[spawnWarnings][2])), false)
				spawnWarnings = spawnWarnings + 1
			end

			if spawnWarnings > #adds then
				self:UnregisterUnitEvent(event, "boss1", "boss2")
			end
		end
	end
end
