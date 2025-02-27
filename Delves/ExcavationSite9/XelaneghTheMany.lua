--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xel'anegh The Many", 2815)
if not mod then return end
mod:RegisterEnableMob(234435, 234436, 234437, 234438) -- Xel'anegh The Many
mod:SetEncounterID(3099)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

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
		1213804, -- Shadow Barrage
		1213426, -- Tentacle Slam
		1213425, -- Terrifying Roar
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowBarrage", 1213804)
	self:Log("SPELL_CAST_START", "TentacleSlam", 1213426)
	self:Log("SPELL_CAST_START", "TerrifyingRoar", 1213425)
	self:Death("XelaneghTheManyDeath", 234435, 234436, 234438)
end

function mod:OnEngage()
	self:CDBar(1213804, 14.2) -- Shadow Barrage
	self:CDBar(1213426, 15.4) -- Tentacle Slam
	self:CDBar(1213425, 23.9) -- Terrifying Roar
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowBarrage(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 33.9)
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

function mod:XelaneghTheManyDeath(args)
	if args.mobId == 234435 then
		self:StopBar(1213804) -- Shadow Barrage
	elseif args.mobId == 234436 then
		self:StopBar(1213425) -- Terrifying Roar
	elseif args.mobId == 234438 then
		self:StopBar(1213426) -- Tentacle Slam
	end
end
