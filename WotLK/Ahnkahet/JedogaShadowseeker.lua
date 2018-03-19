
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Jedoga Shadowseeker", 619, 582)
if not mod then return end
mod:RegisterEnableMob(29310)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		60029, -- Thunder Shock
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Thundershock", 56926, 60029)

	self:Death("Win", 29310)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Thundershock()
	self:Message(60029, "Important")
	self:Bar(60029, 10)
end

