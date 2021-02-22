--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Necrotic Wake Trash", 2286)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	166302, -- Corpse Harvester
	163121, -- Stitched Vanguard
	165137, -- Zolramus Gatekeeper
	163126, -- Brittlebone Mage
	165919, -- Skeletal Marauder
	165222, -- Zolramus Bonemender
	165824, -- Nar'zudah
	165197, -- Skeletal Monstrosity
	173016, -- Corpse Collector
	172981, -- Kyrian Stitchwerk
	163620, -- Rotspew
	163621, -- Goregrind
	165872, -- Flesh Crafter
	167731 -- Separation Assistant
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.corpse_harvester = "Corpse Harvester"
	L.stitched_vanguard = "Stitched Vanguard"
	L.zolramus_gatekeeper = "Zolramus Gatekeeper"
	L.brittlebone_mage = "Brittlebone Mage"
	L.skeletal_marauder = "Skeletal Marauder"
	L.zolramus_bonemender = "Zolramus Bonemender"
	L.narzudah = "Nar'zudah"
	L.skeletal_monstrosity = "Skeletal Monstrosity"
	L.corpse_collector = "Corpse Collector"
	L.kyrian_stitchwerk = "Kyrian Stitchwerk"
	L.flesh_crafter = "Flesh Crafter"
	L.separation_assistant = "Separation Assistant"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Corpse Harvester
		334748, -- Drain Fluids
		-- Stitched Vanguard
		323190, -- Meat Shield
		-- Zolramus Gatekeeper
		323347, -- Clinging Darkness
		{322756, "NAMEPLATEBAR"}, -- Wrath of Zolramus
		-- Brittlebone Mage
		328667, -- Frostbolt Volley
		-- Skeletal Marauder
		324293, -- Guttural Scream
		-- Zolramus Bonemender
		335143, -- Bonemend
		-- Nar'zudah
		335141, -- Dark Shroud
		{327396, "SAY", "SAY_COUNTDOWN"}, -- Grim Fate
		-- Skeletal Monstrosity
		324394, -- Shatter
		324387, -- Frigid Spikes
		324372, -- Reaping Winds
		-- Corpse Collector
		338353, -- Goresplatter
		-- Kyrian Stitchwerk
		{338456, "TANK_HEALER"}, -- Mutilate
		{338357, "NAMEPLATEBAR"}, -- Tenderize
		-- Flesh Crafter
		327130, -- Repair Flesh
		{323496, "SAY"}, -- Throw Cleaver
		-- Separation Assistant
		338606, -- Morbid Fixation
	}, {
		[334748] = L.corpse_harvester,
		[323190] = L.stitched_vanguard,
		[323347] = L.zolramus_gatekeeper,
		[328667] = L.brittlebone_mage,
		[324293] = L.skeletal_marauder,
		[335143] = L.zolramus_bonemender,
		[335141] = L.narzudah,
		[324394] = L.skeletal_monstrosity,
		[338353] = L.corpse_collector,
		[338456] = L.kyrian_stitchwerk,
		[327130] = L.flesh_crafter,
		[338606] = L.separation_assistant,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DrainFluids", 334748)
	self:Log("SPELL_CAST_START", "MeatShield", 323190)
	self:Log("SPELL_AURA_APPLIED", "ClingingDarkness", 323347)
	self:Log("SPELL_CAST_START", "WrathOfZolramus", 322756)
	self:Log("SPELL_CAST_START", "FrostboltVolley", 328667)
	self:Log("SPELL_CAST_START", "GutturalScream", 324293)
	self:Log("SPELL_CAST_START", "Bonemend", 335143)
	self:Log("SPELL_CAST_START", "DarkShroud", 335141)
	self:Log("SPELL_CAST_SUCCESS", "DarkShroudSuccess", 335141)
	self:Log("SPELL_AURA_REMOVED", "DarkShroudRemoved", 335141)
	self:Log("SPELL_AURA_APPLIED", "GrimFateApplied", 327396)
	self:Log("SPELL_CAST_START", "Shatter", 324394)
	self:Log("SPELL_CAST_START", "FrigidSpikes", 324387)
	self:Log("SPELL_CAST_SUCCESS", "ReapingWinds", 324372)
	self:Log("SPELL_CAST_START", "Goresplatter", 338353)
	self:Log("SPELL_CAST_START", "Mutilate", 338456)
	self:Log("SPELL_CAST_START", "Tenderize", 338357)
	self:Log("SPELL_CAST_START", "RepairFlesh", 327130)
	self:Log("SPELL_CAST_START", "ThrowCleaver", 323496)
	self:Log("SPELL_CAST_START", "MorbidFixation", 338606)
	self:Log("SPELL_AURA_APPLIED", "MorbidFixationApplied", 338606)
	self:Log("SPELL_AURA_REMOVED", "MorbidFixationRemoved", 338606)

	self:Death("SkeletalMonstrosityDeath", 165197)
	self:Death("NarzudahDeath", 165824)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Corpse Harvester
do
	local prev = 0
	function mod:DrainFluids(args)
		local t = args.time
		if t-prev > 0.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Stitched Vanguard
do
	local prev = 0
	function mod:MeatShield(args)
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Zolramus Gatekeeper
function mod:ClingingDarkness(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:WrathOfZolramus(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

-- Brittlebone Mage
function mod:FrostboltVolley(args)
	if self:MobId(args.sourceGUID) == 163126 then -- Brittlebone Mage, Amarth has adds that cast this spell
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Skeletal Marauder
function mod:GutturalScream(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Zolramus Bonemender
function mod:Bonemend(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nar'zudah
function mod:DarkShroud(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:DarkShroudSuccess(args)
	self:Bar(args.spellId, 23.5)
end

function mod:DarkShroudRemoved(args)
	self:Message(args.spellId, "yellow", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:GrimFateApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:MobId(args.sourceGUID) == 165824 then -- Nar'zudah
		self:CDBar(args.spellId, 17.4)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 4)
	end
end

function mod:NarzudahDeath(args)
	self:StopBar(335141) -- Dark Shroud
	self:StopBar(327396) -- Grim Fate
end

-- Skeletal Monstrosity
function mod:Shatter(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Tank() and "alarm" or "info")
	self:CDBar(args.spellId, 15.7)
end

function mod:FrigidSpikes(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.1)
end

function mod:ReapingWinds(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20)
	self:CastBar(args.spellId, 4)
end

function mod:SkeletalMonstrosityDeath(args)
	self:StopBar(324394) -- Shatter
	self:StopBar(324387) -- Rigid Spikes

	-- Reaping Winds
	self:StopBar(324372)
	self:StopBar(CL.cast:format(self:SpellName(324372)))
end

-- Corpse Collector
function mod:Goresplatter(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Kyrian Stitchwerk
function mod:Mutilate(args)
	if self:MobId(args.sourceGUID) ~= 164578 then -- Stitchflesh's Creation, add on Surgeon Stitchflesh
		self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Tenderize(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Tank() and "alert" or "info")
	-- This bar is here in case dps/pets taunt to let the tank drop stacks
	self:NameplateCDBar(args.spellId, 12.2, args.sourceGUID)
end

-- Flesh Crafter
function mod:RepairFlesh(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(323496, "yellow", name)
		self:PlaySound(323496, "info", nil, name)
		if self:Me(guid) then
			self:Say(323496)
		end
	end

	function mod:ThrowCleaver(args)
		-- The mob takes a long time to actually target the player
		self:GetUnitTarget(printTarget, 2, args.sourceGUID)
	end
end

-- Separation Assistant
do
	local function printTarget(self, name, guid)
		self:TargetMessage(338606, "yellow", name) -- Morbid Fixation
		self:PlaySound(338606, self:Me(guid) and "alarm" or "info", nil, name) -- Morbid Fixation
	end

	function mod:MorbidFixation(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:MorbidFixationApplied(args)
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:MorbidFixationRemoved(args)
	self:StopBar(args.spellId, args.destName)
end
