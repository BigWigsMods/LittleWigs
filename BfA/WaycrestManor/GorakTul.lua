--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gorak Tul", 1862, 2129)
if not mod then return end
mod:RegisterEnableMob(131864) -- Gorak Tul
mod:SetEncounterID(2117)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Locals
--

local dreadEssenceCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.add_killed = "Add killed - Ready to burn"
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
	self:Death("DeathtouchedSlaverDeath", 135552)
	self:Log("SPELL_CAST_START", "DeathLens", 268202)
	self:Log("SPELL_AURA_APPLIED", "DeathLensApplied", 268202)
end

function mod:OnEngage()
	dreadEssenceCount = 1
	self:CDBar(266266, 4.3) -- Summon Deathtouched Slaver
	self:CDBar(266225, 7.2) -- Darkened Lightning
	self:CDBar(266181, 25.5, CL.count:format(self:SpellName(266181), dreadEssenceCount)) -- Dread Essence
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DreadEssence(args)
	self:StopBar(CL.count:format(args.spellName, dreadEssenceCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, dreadEssenceCount))
	self:PlaySound(args.spellId, "warning")
	dreadEssenceCount = dreadEssenceCount + 1
	self:CDBar(args.spellId, 28.0, CL.count:format(args.spellName, dreadEssenceCount))
end

function mod:SummonDeathtouchedSlaver(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 17.0)
end

function mod:DarkenedLightning(args)
	if self:Interrupter() then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 15.8)
end

function mod:AlchemicalFire(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:DeathtouchedSlaverDeath(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(266198, "cyan", L.add_killed) -- Alchemical Fire
			self:PlaySound(266198, "info") -- Alchemical Fire
		end
	end
end

function mod:DeathLens(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:DeathLensApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end
