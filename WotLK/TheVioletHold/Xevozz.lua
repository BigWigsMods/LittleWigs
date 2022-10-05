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
	L.sphere_name = "Ethereal Sphere"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		54102, -- Summon Ethereal Sphere
		54160, -- Arcane Power
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonEtherealSphere", 54102, 54137, 54138, 61337, 61338, 61339) -- 3x Normal, 3x Heroic
	self:Log("SPELL_AURA_APPLIED", "ArcanePower", 54160)

	self:Death("Win", 29266, 32231)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonEtherealSphere()
	self:Message(54102, "red", CL.incoming:format(L.sphere_name))
	self:PlaySound(54102, "alert")
end

function mod:ArcanePower(args)
	self:Message(args.spellId, "purple", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, self:Tank() and "warning" or "info")
	self:Bar(args.spellId, 8)
end
