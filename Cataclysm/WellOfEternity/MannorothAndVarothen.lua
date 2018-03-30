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
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1", "boss2") -- Mannoroth is boss2 until Varo'then dies
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

	function mod:UNIT_HEALTH_FREQUENT(unit)
		if self:MobId(UnitGUID(unit)) ~= 54969 then return end -- Varo'then is of no interest
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < adds[spawnWarnings][1] then
			self:Message(-4287, "Attention", "Info", CL.soon:format(self:SpellName(adds[spawnWarnings][2])), false)
			spawnWarnings = spawnWarnings + 1

			while spawnWarnings <= #adds and hp < adds[spawnWarnings][1] do
				-- display multiple messages if a high-level character hits multiple thresholds with 1 damage event
				self:Message(-4287, "Attention", nil, CL.soon:format(self:SpellName(adds[spawnWarnings][2])), false)
				spawnWarnings = spawnWarnings + 1
			end

			if spawnWarnings > #adds then
				self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1", "boss2")
			end
		end
	end
end
