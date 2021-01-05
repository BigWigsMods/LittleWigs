--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xevozz", 608, 629)
if not mod then return end
mod:RegisterEnableMob(
	29266, -- Xevozz
	32231 -- Ethereal Wind Trader (replacement boss)
)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.summon_sphere = "Summoning Ethereal Sphere"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		54102, -- Summon Ethereal Sphere
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonEtherealSphere", 54102, 54137, 54138, 61337, 61338) -- 3x Normal, 2x Heroic

	self:Death("Win", 29266, 32231)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonEtherealSphere()
	self:Message(54102, "red", L.summon_sphere)
	self:PlaySound(54102, "alert")
end
