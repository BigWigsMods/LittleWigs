local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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
	212739, -- Consuming Voidstone
	207202 -- Void Fragment -- XXX removed in 11.1
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
	L.void_fragment = "Void Fragment" -- XXX removed in 11.1
end

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then
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
			{427616, "NAMEPLATE"}, -- Energized Barrage
			{430013, "NAMEPLATE"}, -- Thunderstrike
			-- Void-Cursed Crusher
			{474031, "SAY", "NAMEPLATE"}, -- Void Crush
			-- Corrupted Oracle
			{430754, "NAMEPLATE"}, -- Void Shell XXX removed in 11.1?
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
			[430754] = L.corrupted_oracle,
			[430812] = L.coalescing_void_diffuser,
			[443854] = L.inflicted_civilian,
			[1214546] = L.void_ascendant,
			[472764] = L.consuming_voidstone,
		}
	end
else -- XXX remove when 11.1 is live
	function mod:GetOptions()
		return {
			-- Quartermaster Koratite
			{426893, "NAMEPLATE"}, -- Bounding Void
			{450628, "NAMEPLATE"}, -- Entropy Shield
			-- Voidrider
			{427323, "NAMEPLATE"}, -- Charged Bombardment
			{427404, "NAMEPLATE"}, -- Localized Storm
			-- Cursed Rooktender
			{427260, "NAMEPLATE"}, -- Lightning Surge
			-- Unruly Stormrook
			{427616, "NAMEPLATE"}, -- Energized Barrage
			{430013, "NAMEPLATE"}, -- Thunderstrike
			-- Void-Cursed Crusher
			{423979, "NAMEPLATE"}, -- Implosion
			-- Corrupted Oracle
			{430754, "NAMEPLATE"}, -- Void Shell
			{430179, "SAY", "NAMEPLATE"}, -- Seeping Corruption
			-- Coalescing Void Diffuser
			{430812, "NAMEPLATE"}, -- Attracting Shadows
			-- Inflicted Civilian
			443854, -- Instability
			-- Void Ascendant
			{432959, "NAMEPLATE"}, -- Void Volley
			{432638, "NAMEPLATE"}, -- Command Void
			-- Consuming Voidstone
			{432781, "NAMEPLATE"}, -- Embrace the Void
			-- Void Fragment
			430288, -- Crushing Darkness
		}, {
			[426893] = L.quartermaster_koratite,
			[427323] = L.voidrider,
			[427260] = L.cursed_rooktender,
			[427616] = L.unruly_stormrook,
			[423979] = L.void_cursed_crusher,
			[430754] = L.corrupted_oracle,
			[430812] = L.coalescing_void_diffuser,
			[443854] = L.inflicted_civilian,
			[432959] = L.void_ascendant,
			[432781] = L.consuming_voidstone,
			[430288] = L.void_fragment,
		}
	end
end

function mod:OnBossEnable()
	-- Quartermaster Koratite
	self:RegisterEngageMob("QuartermasterKoratiteEngaged", 209801)
	self:Log("SPELL_CAST_START", "BoundingVoid", 426893)
	self:Log("SPELL_CAST_START", "EntropyShield", 450628)
	self:Death("QuartermasterKoratiteDeath", 209801)

	-- Voidrider
	self:RegisterEngageMob("VoidriderEngaged", 212786)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "WildLightning", 474018)
	else -- XXX remove when 11.1 is live
		self:Log("SPELL_CAST_START", "ChargedBombardment", 427323) -- XXX removed in 11.1
	end
	self:Log("SPELL_CAST_START", "LocalizedStorm", 427404)
	self:Death("VoidriderDeath", 212786)

	-- Cursed Rooktender
	self:RegisterEngageMob("CursedRooktenderEngaged", 207199)
	self:Log("SPELL_CAST_START", "LightningSurge", 427260)
	self:Log("SPELL_INTERRUPT", "LightningSurgeInterrupt", 427260)
	self:Log("SPELL_CAST_SUCCESS", "LightningSurgeSuccess", 427260)
	self:Death("CursedRooktenderDeath", 207199)

	-- Unruly Stormrook
	self:RegisterEngageMob("UnrulyStormrookEngaged", 207186)
	self:Log("SPELL_CAST_START", "EnergizedBarrage", 427616)
	if isElevenDotOne then
		self:Log("SPELL_INTERRUPT", "EnergizedBarrageInterrupt", 427616)
		self:Log("SPELL_CAST_SUCCESS", "EnergizedBarrageSuccess", 427616)
	else -- XXX remove when 11.1 is live
		self:Log("SPELL_CAST_START", "Thunderstrike", 430013) -- XXX removed in 11.1
	end
	self:Death("UnrulyStormrookDeath", 207186)

	-- Void-Cursed Crusher
	self:RegisterEngageMob("VoidCursedCrusherEngaged", 214419)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "VoidCrush", 474031)
		self:Log("SPELL_CAST_SUCCESS", "VoidCrushSuccess", 474031)
	else
		self:Log("SPELL_CAST_START", "Implosion", 423979)
	end
	self:Death("VoidCursedCrusherDeath", 214419)

	-- Corrupted Oracle
	self:RegisterEngageMob("CorruptedOracleEngaged", 214439)
	self:Log("SPELL_CAST_START", "VoidShell", 430754) -- XXX removed in 11.1?
	self:Log("SPELL_CAST_SUCCESS", "SeepingCorruption", 430179)
	self:Log("SPELL_AURA_APPLIED", "SeepingCorruptionApplied", 430179)
	self:Death("CorruptedOracleDeath", 214439)

	-- Coalescing Void Diffuser
	self:RegisterEngageMob("CoalescingVoidDiffuserEngaged", 214421)
	self:Log("SPELL_CAST_START", "AttractingShadows", 430812)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "ArcingVoid", 430805)
		self:Log("SPELL_CAST_SUCCESS", "ArcingVoidSuccess", 430805)
	end
	self:Death("CoalescingVoidDiffuserDeath", 214421)

	-- Inflicted Civilian
	self:Log("SPELL_CAST_SUCCESS", "Instability", 443854)

	-- Void Ascendant
	self:RegisterEngageMob("VoidAscendantEngaged", 212793)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "UmbralWave", 1214546)
		self:Log("SPELL_CAST_SUCCESS", "FeastingVoid", 1214523)
	else -- XXX remove when 11.1 is live
		self:Log("SPELL_CAST_START", "VoidVolley", 432959) -- XXX removed in 11.1
		self:Log("SPELL_INTERRUPT", "VoidVolleyInterrupt", 432959) -- XXX removed in 11.1
		self:Log("SPELL_CAST_SUCCESS", "VoidVolleySuccess", 432959) -- XXX removed in 11.1
		self:Log("SPELL_CAST_SUCCESS", "CommandVoid", 432638) -- XXX removed in 11.1
	end
	self:Death("VoidAscendantDeath", 212793)

	-- Consuming Voidstone
	self:RegisterEngageMob("ConsumingVoidstoneEngaged", 212739)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "VoidExtraction", 472764)
		self:Log("SPELL_CAST_SUCCESS", "UnleashDarkness", 1214628)
	else -- XXX remove when 11.1 is live
		self:Log("SPELL_CAST_START", "EmbraceTheVoid", 432781) -- XXX removed in 11.1
		self:Log("SPELL_CAST_SUCCESS", "EmbraceTheVoidSuccess", 432781) -- XXX removed in 11.1
		self:Log("SPELL_AURA_REMOVED", "EmbraceTheVoidRemoved", 432781) -- XXX removed in 11.1
	end
	self:Death("ConsumingVoidstoneDeath", 212739)

	if not isElevenDotOne then
		-- Void Fragment
		self:Log("SPELL_CAST_START", "CrushingDarkness", 430288) -- XXX removed in 11.1
	end
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
		self:CDBar(450628, 9.0) -- Entropy Shield
		self:Nameplate(450628, 9.0, guid) -- Entropy Shield
		timer = self:ScheduleTimer("QuartermasterKoratiteDeath", 30)
	end

	function mod:BoundingVoid(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 12.1)
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
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
	if isElevenDotOne then
		self:Nameplate(474018, 9.2, guid) -- Wild Lightning
		self:Nameplate(427404, 15.7, guid) -- Localized Storm
	else -- XXX remove when 11.1 is live
		self:Nameplate(427323, 4.0, guid) -- Charged Bombardment
		self:Nameplate(427404, 10.0, guid) -- Localized Storm
	end
end

function mod:WildLightning(args)
	-- this is also cast by the first boss (Kyrioss)
	if self:MobId(args.sourceGUID) ~= 209230 then -- Kyrioss
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 20.7, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ChargedBombardment(args) -- XXX remove when 11.1 is live
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:LocalizedStorm(args)
	self:Message(args.spellId, "yellow")
	if isElevenDotOne then
		self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	else -- XXX remove when 11.1 is live
		self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:VoidriderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursed Rooktender

function mod:CursedRooktenderEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(427260, 8.4, guid) -- Lightning Surge
	else -- XXX remove in 11.1
		self:Nameplate(427260, 3.5, guid) -- Lightning Surge
	end
end

function mod:LightningSurge(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:LightningSurgeInterrupt(args)
	if isElevenDotOne then
		self:Nameplate(427260, 18.6, args.destGUID)
	else -- XXX remove in 11.1
		self:Nameplate(427260, 15.0, args.destGUID)
	end
end

function mod:LightningSurgeSuccess(args)
	if isElevenDotOne then
		self:Nameplate(args.spellId, 18.6, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 15.0, args.sourceGUID)
	end
end

function mod:CursedRooktenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Unruly Stormrook

function mod:UnrulyStormrookEngaged(guid)
	if not isElevenDotOne then
		self:Nameplate(430013, 5.7, guid) -- Thunderstrike
	end
	self:Nameplate(427616, 9.4, guid) -- Energized Barrage
end

do
	local prev = 0
	function mod:Thunderstrike(args) -- TODO removed in 11.1
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

if isElevenDotOne then -- XXX remove this check when 11.1 is live
	do
		local prev = 0
		function mod:EnergizedBarrage(args)
			self:Nameplate(args.spellId, 0, args.sourceGUID)
			if args.time - prev > 1.5 then
				prev = args.time
				self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end

	function mod:EnergizedBarrageInterrupt(args)
		self:Nameplate(427616, 19.7, args.destGUID)
	end

	function mod:EnergizedBarrageSuccess(args)
		self:Nameplate(args.spellId, 19.7, args.sourceGUID)
	end
else -- XXX remove the block below when 11.1 is live
	do
		local prev = 0
		function mod:EnergizedBarrage(args)
			self:Nameplate(args.spellId, 23.0, args.sourceGUID)
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:Message(args.spellId, "purple")
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

function mod:UnrulyStormrookDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void-Cursed Crusher

function mod:VoidCursedCrusherEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(474031, 8.3, guid) -- Void Crush
	else
		self:Nameplate(423979, 5.2, guid) -- Implosion
	end
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
	if isElevenDotOne then
		self:Nameplate(args.spellId, 18.6, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 16.2, args.sourceGUID)
	end
end

function mod:Implosion(args) -- XXX remove when 11.1 is live
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoidCursedCrusherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Corrupted Oracle

function mod:CorruptedOracleEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(430179, 16.5, guid) -- Seeping Corruption
	else -- XXX remove in 11.1
		self:Nameplate(430179, 6.0, guid) -- Seeping Corruption
		self:Nameplate(430754, 8.1, guid) -- Void Shell
	end
end

do
	local prev = 0
	function mod:VoidShell(args) -- XXX removed in 11.1?
		-- unlike most other abilities, this goes on cooldown on cast start
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:SeepingCorruption(args)
	if isElevenDotOne then
		self:Nameplate(args.spellId, 23.1, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
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
	if isElevenDotOne then
		self:Nameplate(430805, 8.3, guid) -- Arcing Void
	end
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
		-- TODO verify target scanning works
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
	if isElevenDotOne then
		self:Nameplate(1214523, 11.9, guid) -- Feasting Void
		self:Nameplate(1214546, 15.9, guid) -- Umbral Wave
	else -- XXX remove in 11.1
		self:Nameplate(432638, 6.6, guid) -- Command Void
		self:Nameplate(432959, 9.3, guid) -- Void Volley
	end
end

function mod:UmbralWave(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 28.7, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:FeastingVoid(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 22.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidVolley(args) -- XXX removed in 11.1
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidVolleyInterrupt(args) -- XXX removed in 11.1
	self:Nameplate(432959, 15.0, args.destGUID)
end

function mod:VoidVolleySuccess(args) -- XXX removed in 11.1
	self:Nameplate(args.spellId, 15.0, args.sourceGUID)
end

function mod:CommandVoid(args) -- XXX removed in 11.1
	-- the alert for this is covered by :CrushingDarkness
	self:Nameplate(args.spellId, 6.1, args.sourceGUID)
end

function mod:VoidAscendantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Consuming Voidstone

function mod:ConsumingVoidstoneEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(472764, 5.7, guid) -- Void Extraction
	else -- XXX remove in 11.1
		self:Nameplate(432781, 8.0, guid) -- Embrace the Void
	end
end

function mod:VoidExtraction(args)
	self:Message(args.spellId, "cyan")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:UnleashDarkness(args)
	-- this is channeled until death, unless it's interrupted by Storm's Vengeance
	self:ClearNameplate(args.sourceGUID)
	self:Message(args.spellId, "yellow", CL.percent:format(40, args.spellName))
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:EmbraceTheVoid(args) -- XXX remove in 11.1
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:EmbraceTheVoidSuccess(args) -- XXX remove in 11.1
	self:Nameplate(args.spellId, 25.1, args.sourceGUID)
end

do
	local prev = 0
	function mod:EmbraceTheVoidRemoved(args) -- XXX remove in 11.1
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:ConsumingVoidstoneDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Fragment

do
	local prev = 0
	function mod:CrushingDarkness(args) -- XXX remove in 11.1
		-- Void Fragments cast this if a nearby Void Ascendant casts Command Void (432638)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
