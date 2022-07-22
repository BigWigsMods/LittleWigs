--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Encrypted", 130, {2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2441})
if not mod then return end
mod:RegisterEnableMob(
	184911, -- Urh Dismantler
	184908, -- Vy Interceptor
	184910 -- Wo Drifter
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.urh_dismantler = "Urh Dismantler"
	L.vy_interceptor = "Vy Interceptor"
	L.wo_drifter = "Wo Drifter"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Urh Dismantler
		366288, -- Force Slam
		-- Vy Interceptor
		366409, -- Fusion Beam
		-- Wo Drifter
		366566, -- Burst
	}, {
		[366288] = L.urh_dismantler,
		[366409] = L.vy_interceptor,
		[366566] = L.wo_drifter,
	}
end

function mod:OnBossEnable()
    -- Urh Dismantler
    self:Log("SPELL_CAST_START", "ForceSlam", 366288) -- Force Slam

	-- Vy Interceptor
    self:Log("SPELL_CAST_START", "FusionBeam", 366409) -- Fusion Beam

	-- Wo Drifter
    self:Log("SPELL_CAST_START", "Burst", 366566) -- Burst
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Urh Dismantler
function mod:ForceSlam(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Vy Interceptor
function mod:FusionBeam(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Wo Drifter
function mod:Burst(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end
