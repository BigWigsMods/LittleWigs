--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xel'anegh The Many", 2815)
if not mod then return end
mod:RegisterEnableMob(234435, 234436, 234437, 234438) -- Xel'anegh The Many, Tentacle, Tentacle, Tentacle
mod:SetEncounterID(3099)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local tentaclesKilled = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.xelanegh_the_many = "Xel'anegh The Many"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.xelanegh_the_many
end

function mod:GetOptions()
	return {
		1213791, -- Shadow Barrage
		1213426, -- Tentacle Slam
		1213425, -- Terrifying Roar
		"stages",
		{1213275, "EMPHASIZE"}, -- Wounded
	},nil,{
		[1213275] = CL.weakened, -- Wounded (Weakened)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ShadowBarrage", 1213791) -- SPELL_CAST_SUCCESS on 1213804 no longer logs
	self:Log("SPELL_CAST_START", "TentacleSlam", 1213426)
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 1213425)
	self:Log("SPELL_CAST_SUCCESS", "Wounded", 1213275)
	self:Death("XelaneghTheManyDeath", 234435, 234436, 234438)
end

function mod:OnEngage()
	tentaclesKilled = 0
	self:CDBar(1213791, 14.2) -- Shadow Barrage
	self:CDBar(1213426, 15.4) -- Tentacle Slam
	self:CDBar(1213425, 23.9) -- Terrifying Roar
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowBarrage(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 33.5)
	self:PlaySound(args.spellId, "long")
end

function mod:TentacleSlam(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 24.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TerrifyingRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 33.2)
	self:PlaySound(args.spellId, "warning")
end

function mod:Wounded(args)
	tentaclesKilled = tentaclesKilled + 1
	self:Message("stages", "cyan", CL.mob_killed:format(CL.tentacle, tentaclesKilled, 3), false)
	if tentaclesKilled == 3 then
		self:Message(args.spellId, "green", CL.weakened)
	end
	self:PlaySound("stages", "info")
end

function mod:XelaneghTheManyDeath(args)
	if args.mobId == 234435 then -- Xel'anegh the Many (Main Boss)
		self:StopBar(1213791) -- Shadow Barrage
	elseif args.mobId == 234436 then -- Xel'anegh the Many (Tentacle)
		self:StopBar(1213425) -- Terrifying Roar
	elseif args.mobId == 234438 then -- Xel'anegh the Many (Tentacle)
		self:StopBar(1213426) -- Tentacle Slam
	end
end
