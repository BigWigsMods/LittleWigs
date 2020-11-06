-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Drakos the Interrogator", 578, 622)
if not mod then return end
mod:RegisterEnableMob(27654)
mod.engageId = 2016
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		50774, -- Thundering Stomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ThunderingStomp", 50774, 59370) -- normal, heroic
end

function mod:OnEngage()
	self:CDBar(50774, 14.7) -- Thundering Stomp
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ThunderingStomp(args)
	self:MessageOld(50774, "red", nil, CL.casting:format(args.spellName))
	self:CastBar(50774, 1)
	self:CDBar(50774, self:Normal() and 14.6 or 12.2) -- can take up to 20s
end
