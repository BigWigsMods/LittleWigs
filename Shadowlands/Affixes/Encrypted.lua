--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewDungeonAffix("Encrypted", 130, {2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2441})
if not mod then return end
mod:RegisterEnableMob(
	184911 -- Urh Dismantler
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.urh_dismantler = "Urh Dismantler"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Urh Dismantler
		366288, -- Force Slam
	}, {
		[366288] = L.urh_dismantler,
	}
end

function mod:OnBossEnable()
    -- Urh Dismantler
    self:Log("SPELL_CAST_START", "ForceSlam", 366288) -- Force Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Urh Dismantler
function mod:ForceSlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
