--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Globgrog", 2289, 2419)
if not mod then return end
mod:RegisterEnableMob(164255) -- Globgrog
mod:SetEncounterID(2382)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local plaguestompCount = 1
local slimeWaveCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		324490, -- Beckon Slime
		324527, -- Plaguestomp
		324667, -- Slime Wave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BeckonSlime", 324490)
	self:Log("SPELL_CAST_START", "Plaguestomp", 324527)
	self:Log("SPELL_CAST_START", "SlimeWave", 324667)
end

function mod:OnEngage()
	plaguestompCount = 1
	slimeWaveCount = 1

	self:CDBar(324490, 25.5) -- Beckon Slime
	self:CDBar(324527, 8.9) -- Plaguestomp
	self:CDBar(324667, 17.1) -- Slime Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BeckonSlime(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 54.5)
end

function mod:Plaguestomp(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	plaguestompCount = plaguestompCount + 1
	self:CDBar(args.spellId, plaguestompCount % 2 == 0 and 35 or 20) -- XXX pull:10.5, 37.7, 24.3, 30.4 // pull:8.9, 38.8, 19.0, 36.4, 24.3, 30.4
end

function mod:SlimeWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	slimeWaveCount = slimeWaveCount + 1
	self:Bar(args.spellId, slimeWaveCount % 2 == 0 and 37.7 or 10) -- XXX pull:17.9, 37.6, 11.0, 43.7 // pull:16.1, 39.7, 18.2, 36.4, 10.9, 43.7
end
