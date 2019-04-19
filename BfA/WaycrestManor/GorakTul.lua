
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gorak Tul", 1862, 2129)
if not mod then return end
mod:RegisterEnableMob(131864)
mod.engageId = 2117
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.add_killed = "Add killed"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		266181, -- Dread Essence
		266266, -- Summon Deathtouched Slaver
		266225, -- Darkened Lightning
		266198, -- Alchemical Fire
		268202, -- Death Lens
	}, {
		[266181] = "general",
		[268202] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DreadEssence", 266181)
	self:Log("SPELL_CAST_SUCCESS", "SummonDeathtouchedSlaver", 266266)
	self:Log("SPELL_CAST_START", "DarkenedLightning", 266225)
	self:Log("SPELL_CAST_SUCCESS", "AlchemicalFire", 266198)
	self:Log("SPELL_CAST_SUCCESS", "DeathLens", 268202)

	self:Death("DeathtouchedSlaverDeath", 135552)
end

function mod:OnEngage()
	self:Bar(266266, 4.4) -- Summon Deathtouched Slaver
	self:Bar(266225, 7.2) -- Darkened Lightning
	self:Bar(266181, 26.7) -- Dread Essence
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DreadEssence(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 28)
end

function mod:SummonDeathtouchedSlaver(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 17)
end

function mod:DarkenedLightning(args)
	self:Message2(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
	self:Bar(args.spellId, 15.8)
end

function mod:AlchemicalFire(args)
	self:Message2(args.spellId, "green")
	self:PlaySound(args.spellId, "long")
end

function mod:DeathLens(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:DeathtouchedSlaverDeath(args)
	self:Message2(266198, "yellow", L.add_killed) -- Alchemical Fire
	self:PlaySound(266198, "info") -- Alchemical Fire
end
