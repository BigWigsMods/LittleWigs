
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gorak Tul", 1862, 2129)
if not mod then return end
mod:RegisterEnableMob(131864)
mod.engageId = 2117

--------------------------------------------------------------------------------
-- Locals
--

local slaverCorpseCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.add_killed = "Add killed, %d corpses remaining"
	L.corpses_burned = "%d corpses burned, %d remaining"
	L.adds_resurrected = "%d adds resurrected"
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
	self:Log("SPELL_CAST_SUCCESS", "DreadEssenceSuccess", 266181)
	self:Log("SPELL_CAST_SUCCESS", "SummonDeathtouchedSlaver", 266266)
	self:Log("SPELL_CAST_START", "DarkenedLightning", 266225)
	self:Log("SPELL_CAST_SUCCESS", "AlchemicalFire", 266198)
	self:Log("SPELL_CAST_SUCCESS", "DeathLens", 268202)
	self:Death("DeathtouchedSlaverDeath", 135552)
end

function mod:OnEngage()
	slaverCorpseCount = 0
	self:Bar(266266, 4.4) -- Summon Deathtouched Slaver
	self:Bar(266225, 7.2) -- Darkened Lightning
	self:Bar(266181, 26.7) -- Dread Essence
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeathtouchedSlaverDeath(args)
	slaverCorpseCount = slaverCorpseCount + 1
	self:Message2(266198, "orange", L.add_killed:format(slaverCorpseCount))
	self:PlaySound(266198, "info")
end

function mod:DreadEssence(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 28)
end

function mod:DreadEssenceSuccess(args)
	if slaverCorpseCount > 0 then
		self:Message2(args.spellId, "orange", L.adds_resurrected:format(slaverCorpseCount))
		self:PlaySound(args.spellId, "info")
	end
	slaverCorpseCount = 0
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
	self:Bar(args.spellId, 14.5)
end

do
	local burnCount = 0
	local function warn()
		burnCount = 0
		mod:Message2(266198, "green", L.corpses_burned:format(burnCount, slaverCorpseCount)) -- Alchemical Fire
		mod:PlaySound(266198, "long") -- Alchemical Fire
	end

	function mod:AlchemicalFire(args)
		slaverCorpseCount = slaverCorpseCount - 1
		burnCount = burnCount + 1
		if burnCount == 1 then
			self:SimpleTimer(warn, 0.1)
		end
	end
end

function mod:DeathLens(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
