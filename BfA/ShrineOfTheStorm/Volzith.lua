
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'zith the Whisperer", 1864, 2156)
if not mod then return end
mod:RegisterEnableMob(134069)
mod.engageId = 2133

--------------------------------------------------------------------------------
-- Locals
--

local nextStage = 0

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
	self:Log("SPELL_CAST_SUCCESS", "WhispersofPower", 267034)
	self:Log("SPELL_AURA_APPLIED", "WhispersofPowerApplied", 267037)
	self:Log("SPELL_CAST_START", "YawningGate", 269399)
	self:Log("SPELL_CAST_START", "TentacleSlam", 267385)
	self:Log("SPELL_CAST_START", "GraspoftheSunkenCity", 267360)
	self:Log("SPELL_AURA_REMOVED", "GraspoftheSunkenCityOver", 267444)
end

function mod:OnEngage()
	nextStage = GetTime() + 20.5
	self:Bar(267037, 12.5) -- Whispers of Power _success
	self:Bar(269399, 12.5) -- Yawning Gate _start
	self:Bar(267360, 20.5) -- Grasp of the Sunken City _start
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WhispersofPower()
	local timer = 21.5
	if nextStage - (GetTime() + timer) < 0 then
		self:Bar(267037, timer) -- Whispers of Power
	end
end

function mod:WhispersofPowerApplied(args)
	self:TargetMessage(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:YawningGate(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	local timer = 20.5
	if nextStage - (GetTime() + timer) < 0 then
		self:Bar(args.spellId, timer)
	end
end

function mod:TentacleSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 4)
end

function mod:GraspoftheSunkenCity(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 4)
end

function mod:GraspoftheSunkenCityOver()
	self:Bar(269399, 4) -- Yawning Gate _start
	self:Bar(267037, 11.5) -- Whispers of Power _success
	nextStage = GetTime() + 50.2
	self:Bar(267360, 50.2) -- Grasp of the Sunken City  _start
end
