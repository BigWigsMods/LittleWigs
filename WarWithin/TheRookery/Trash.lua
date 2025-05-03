--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Rookery Trash", 2648)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	207197, -- Cursed Rookguard
	207198, -- Cursed Thunderer
	209801, -- Quartermaster Koratite
	212786, -- Voidrider
	207199, -- Cursed Rooktender
	207186, -- Unruly Stormrook
	214419, -- Void-Cursed Crusher
	214439, -- Corrupted Oracle
	214421, -- Coalescing Void Diffuser
	219066, -- Inflicted Civilian
	212793, -- Void Ascendant
	212739 -- Consuming Voidstone
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.quartermaster_koratite = "Quartermaster Koratite"
	L.voidrider = "Voidrider"
	L.cursed_rooktender = "Cursed Rooktender"
	L.unruly_stormrook = "Unruly Stormrook"
	L.void_cursed_crusher = "Void-Cursed Crusher"
	L.corrupted_oracle = "Corrupted Oracle"
	L.coalescing_void_diffuser = "Coalescing Void Diffuser"
	L.inflicted_civilian = "Inflicted Civilian"
	L.void_ascendant = "Void Ascendant"
	L.consuming_voidstone = "Consuming Voidstone"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Quartermaster Koratite
		{426893, "NAMEPLATE"}, -- Bounding Void
		{450628, "NAMEPLATE"}, -- Entropy Shield
		-- Voidrider
		{474018, "NAMEPLATE"}, -- Wild Lightning
		{427404, "NAMEPLATE"}, -- Localized Storm
		-- Cursed Rooktender
		{427260, "NAMEPLATE"}, -- Lightning Surge
		-- Unruly Stormrook
		{427616, "ME_ONLY", "OFF"}, -- Energized Barrage
		-- Void-Cursed Crusher
		{474031, "SAY", "NAMEPLATE"}, -- Void Crush
		-- Corrupted Oracle
		{430179, "SAY", "NAMEPLATE"}, -- Seeping Corruption
		-- Coalescing Void Diffuser
		{430812, "NAMEPLATE"}, -- Attracting Shadows
		{430805, "NAMEPLATE"}, -- Arcing Void
		-- Inflicted Civilian
		443854, -- Instability
		-- Void Ascendant
		{1214546, "NAMEPLATE"}, -- Umbral Wave
		{1214523, "NAMEPLATE"}, -- Feasting Void
		-- Consuming Voidstone
		{472764, "NAMEPLATE"}, -- Void Extraction
		1214628, -- Unleash Darkness
	}, {
		[426893] = L.quartermaster_koratite,
		[474018] = L.voidrider,
		[427260] = L.cursed_rooktender,
		[427616] = L.unruly_stormrook,
		[474031] = L.void_cursed_crusher,
		[430179] = L.corrupted_oracle,
		[430812] = L.coalescing_void_diffuser,
		[443854] = L.inflicted_civilian,
		[1214546] = L.void_ascendant,
		[472764] = L.consuming_voidstone,
	}
end

function mod:OnBossEnable()
	-- Quartermaster Koratite
	self:RegisterEngageMob("QuartermasterKoratiteEngaged", 209801)
	self:Log("SPELL_CAST_START", "BoundingVoid", 426893)
	self:Log("SPELL_CAST_START", "EntropyShield", 450628)
	self:Death("QuartermasterKoratiteDeath", 209801)

	-- Voidrider
	self:RegisterEngageMob("VoidriderEngaged", 212786)
	self:Log("SPELL_CAST_START", "WildLightning", 474018)
	self:Log("SPELL_CAST_START", "LocalizedStorm", 427404)
	self:Death("VoidriderDeath", 212786)

	-- Cursed Rooktender
	self:RegisterEngageMob("CursedRooktenderEngaged", 207199)
	self:Log("SPELL_CAST_START", "LightningSurge", 427260)
	self:Log("SPELL_INTERRUPT", "LightningSurgeInterrupt", 427260)
	self:Log("SPELL_CAST_SUCCESS", "LightningSurgeSuccess", 427260)
	self:Death("CursedRooktenderDeath", 207199)

	-- Unruly Stormrook
	self:Log("SPELL_AURA_APPLIED", "EnergizedBarrageApplied", 427616)

	-- Void-Cursed Crusher
	self:RegisterEngageMob("VoidCursedCrusherEngaged", 214419)
	self:Log("SPELL_CAST_START", "VoidCrush", 474031)
	self:Log("SPELL_CAST_SUCCESS", "VoidCrushSuccess", 474031)
	self:Death("VoidCursedCrusherDeath", 214419)

	-- Corrupted Oracle
	self:RegisterEngageMob("CorruptedOracleEngaged", 214439)
	self:Log("SPELL_CAST_SUCCESS", "SeepingCorruption", 430179)
	self:Log("SPELL_AURA_APPLIED", "SeepingCorruptionApplied", 430179)
	self:Death("CorruptedOracleDeath", 214439)

	-- Coalescing Void Diffuser
	self:RegisterEngageMob("CoalescingVoidDiffuserEngaged", 214421)
	self:Log("SPELL_CAST_START", "AttractingShadows", 430812)
	self:Log("SPELL_CAST_START", "ArcingVoid", 430805)
	self:Log("SPELL_CAST_SUCCESS", "ArcingVoidSuccess", 430805)
	self:Death("CoalescingVoidDiffuserDeath", 214421)

	-- Inflicted Civilian
	self:Log("SPELL_CAST_SUCCESS", "Instability", 443854)

	-- Void Ascendant
	self:RegisterEngageMob("VoidAscendantEngaged", 212793)
	self:Log("SPELL_CAST_START", "UmbralWave", 1214546)
	self:Log("SPELL_CAST_SUCCESS", "FeastingVoid", 1214523)
	self:Death("VoidAscendantDeath", 212793)

	-- Consuming Voidstone
	self:RegisterEngageMob("ConsumingVoidstoneEngaged", 212739)
	self:Log("SPELL_CAST_START", "VoidExtraction", 472764)
	self:Log("SPELL_CAST_SUCCESS", "UnleashDarkness", 1214628)
	self:Death("ConsumingVoidstoneDeath", 212739)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Quartermaster Koratite

do
	local timer

	function mod:QuartermasterKoratiteEngaged(guid)
		self:CDBar(426893, 5.2) -- Bounding Void
		self:Nameplate(426893, 5.2, guid) -- Bounding Void
		self:CDBar(450628, 8.8) -- Entropy Shield
		self:Nameplate(450628, 8.8, guid) -- Entropy Shield
		timer = self:ScheduleTimer("QuartermasterKoratiteDeath", 30)
	end

	function mod:BoundingVoid(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 18.2)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("QuartermasterKoratiteDeath", 30)
	end

	function mod:EntropyShield(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:CDBar(args.spellId, 26.7)
		self:Nameplate(args.spellId, 26.7, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
		timer = self:ScheduleTimer("QuartermasterKoratiteDeath", 30)
	end

	function mod:QuartermasterKoratiteDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(426893) -- Bounding Void
		self:StopBar(450628) -- Entropy Shield
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Voidrider

function mod:VoidriderEngaged(guid)
	self:Nameplate(474018, 9.2, guid) -- Wild Lightning
	self:Nameplate(427404, 15.7, guid) -- Localized Storm
end

function mod:WildLightning(args)
	-- this is also cast by the first boss (Kyrioss)
	if self:MobId(args.sourceGUID) ~= 209230 then -- Kyrioss
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 20.7, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:LocalizedStorm(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:VoidriderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursed Rooktender

function mod:CursedRooktenderEngaged(guid)
	self:Nameplate(427260, 8.3, guid) -- Lightning Surge
end

function mod:LightningSurge(args)
	-- won't be cast if there are no Stormrooks nearby
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:LightningSurgeInterrupt(args)
	self:Nameplate(427260, 18.6, args.destGUID)
end

function mod:LightningSurgeSuccess(args)
	self:Nameplate(args.spellId, 18.6, args.sourceGUID)
end

function mod:CursedRooktenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Unruly Stormrook

do
	local prev = 0
	function mod:EnergizedBarrageApplied(args)
		if args.time - prev > 2 then
			prev = args.time
			self:TargetMessage(args.spellId, "orange", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

-- Void-Cursed Crusher

function mod:VoidCursedCrusherEngaged(guid)
	self:Nameplate(474031, 8.3, guid) -- Void Crush
end

do
	local prev, prevOnMe = 0, 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		self:TargetMessage(474031, "orange", name)
		if self:Me(guid) and t - prevOnMe > 3 then
			prevOnMe = t
			self:Say(474031, nil, nil, "Void Crush")
		end
		if t - prev > 2 then
			prev = t
			self:PlaySound(474031, "alarm", nil, name)
		end
	end

	function mod:VoidCrush(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:VoidCrushSuccess(args)
	self:Nameplate(args.spellId, 18.6, args.sourceGUID)
end

function mod:VoidCursedCrusherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Corrupted Oracle

function mod:CorruptedOracleEngaged(guid)
	self:Nameplate(430179, 16.5, guid) -- Seeping Corruption
end

function mod:SeepingCorruption(args)
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
end

function mod:SeepingCorruptionApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Seeping Corruption")
	end
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:CorruptedOracleDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Coalescing Void Diffuser

function mod:CoalescingVoidDiffuserEngaged(guid)
	self:Nameplate(430812, 5.7, guid) -- Attracting Shadows
	self:Nameplate(430805, 8.3, guid) -- Arcing Void
end

do
	local prev = 0
	function mod:AttractingShadows(args)
		self:Nameplate(args.spellId, 21.8, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(430805, "orange", name)
		self:PlaySound(430805, "alarm", nil, name)
	end

	function mod:ArcingVoid(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:ArcingVoidSuccess(args)
	self:Nameplate(args.spellId, 14.0, args.sourceGUID)
end

function mod:CoalescingVoidDiffuserDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Inflicted Civilian

do
	local prev = 0
	function mod:Instability(args)
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Void Ascendant

function mod:VoidAscendantEngaged(guid)
	self:Nameplate(1214523, 11.9, guid) -- Feasting Void
	self:Nameplate(1214546, 15.2, guid) -- Umbral Wave
end

function mod:UmbralWave(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:FeastingVoid(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 22.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidAscendantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Consuming Voidstone

function mod:ConsumingVoidstoneEngaged(guid)
	self:Nameplate(472764, 5.6, guid) -- Void Extraction
end

function mod:VoidExtraction(args)
	self:Message(args.spellId, "cyan")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:UnleashDarkness(args)
	-- 20s channel, only cast once
	self:Message(args.spellId, "yellow", CL.percent:format(40, args.spellName))
	-- puts Void Extraction on cooldown
	self:Nameplate(472764, 25.5, args.sourceGUID) -- Void Extraction
	self:PlaySound(args.spellId, "long")
end

function mod:ConsumingVoidstoneDeath(args)
	self:ClearNameplate(args.destGUID)
end
