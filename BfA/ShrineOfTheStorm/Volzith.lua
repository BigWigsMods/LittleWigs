if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'zith the Whisperer", 1864, 2156)
if not mod then return end
mod:RegisterEnableMob(134069)
mod.engageId = 2133

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		267037, -- Whispers of Power
		269399, -- Yawning Gate
		267385, -- Tentacle Slam
		267360, -- Grasp of the Sunken City
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "WhispersofPower", 267037)
	self:Log("SPELL_CAST_START", "YawningGate", 269399)
	self:Log("SPELL_CAST_START", "TentacleSlam", 267385)
	self:Log("SPELL_CAST_START", "GraspoftheSunkenCity", 267360)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WhispersofPower(args)
	self:TargetMessage2(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "info")
end

function mod:YawningGate(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:TentacleSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "Alarm")
	self:CastBar(args.spellId, 4)
end

function mod:GraspoftheSunkenCity(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 4)
end
