
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Prince Shaffar", 557, 537)
if not mod then return end
mod:RegisterEnableMob(18344)
-- mod.engageId = 1899 -- no boss frames, sometimes no ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		32365, -- Frost Nova
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "FrostNova", 32365)
	self:Death("Win", 18344)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = mod:NewTargetList()

	function mod:FrostNova(args)
		if not self:Player(args.destFlags) then return end -- filter out pets
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "red", "alert", nil, nil, self:Dispeller("magic"))
		end
	end
end
