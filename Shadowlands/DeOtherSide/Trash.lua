--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("De Other Side Trash", 2291)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	-- [[ The ring ]] --
	168992, -- Risen Cultist
	169905, -- Risen Warlord
	168934, -- Enraged Spirit
	168942, -- Death Speaker

	-- [[ Path to Hakkar ]] --
	170480, -- Atal'ai Deathwalker
	170490, -- Atal'ai High Priest
	170572, -- Atal'ai Hoodoo Hexxer

	-- [[ Path to the Manastorms ]] --
	167962, -- Defunct Dental Drill
	167964, -- 4.RF-4.RF
	167965, -- Lubricator
	167963, -- Headless Client

	-- [[ Path to Xyexa ]] --
	164862, -- Weald Shimmermoth
	171184 -- Mythresh, Sky's Talons
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- [[ The ring ]] --
	L.cultist = "Risen Cultist"
	L.warlord = "Risen Warlord"
	L.enraged = "Enraged Spirit"
	L.speaker = "Death Speaker"

	-- [[ Path to Hakkar ]] --
	L.deathwalker = "Atal'ai Deathwalker"
	L.priest = "Atal'ai High Priest"
	L.hexxer = "Atal'ai Hoodoo Hexxer"

	-- [[ Path to the Manastorms ]] --
	L.drill = "Defunct Dental Drill"
	L.arf_arf = "4.RF-4.RF"
	L.lubricator = "Lubricator"
	L.headless = "Headless Client"

	-- [[ Path to Xyexa ]] --
	L.shimmermoth = "Weald Shimmermoth"
	L.mythresh = "Mythresh, Sky's Talons"

	L.soporific_shimmerdust = 334496
	L.soporific_shimmerdust_desc = "Curse that makes your character fall asleep at 10 stacks. Jumping resets stacks."
	L.soporific_shimmerdust_icon = "spell_nature_drowsy"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- [[ The ring ]] --
		-- Risen Cultist
		328740, -- Dark Lotus
		-- Risen Warlord
		{333227, "NAMEPLATEBAR"}, -- Undying Rage
		333250, -- Reaver
		-- Enraged Spirit
		{333787, "CASTBAR"}, -- Rage
		-- Death Speaker
		{334051, "CASTBAR"}, -- Erupting Darkness

		-- [[ Path to Hakkar ]] --
		-- Atal'ai Deathwalker
		{332678, "TANK_HEALER"}, -- Gushing Wound
		332672, -- Bladestorm
		-- Atal'ai High Priest
		332706, -- Heal
		-- Atal'ai Hoodoo Hexxer
		332612, -- Healing Wave
		332605, -- Hex
		{332608, "SAY"}, -- Lightning Discharge

		-- [[ Path to the Manastorms ]] --
		-- Defunct Dental Drill
		{331927, "NAMEPLATEBAR", "CASTBAR"}, -- Haywire
		-- 4.RF-4.RF
		{331548, "TANK_HEALER"}, -- Metallic Jaws
		{331846, "SAY", "SAY_COUNTDOWN", "CASTBAR"}, -- W-00F
		-- Lubricator
		332084, -- Self-Cleaning Cycle
		-- Headless Client
		332157, -- Spinning Up

		-- [[ Path to Xyexa ]] --
		-- Weald Shimmermoth
		"soporific_shimmerdust",
		-- Mythresh, Sky's Talons
		{340026, "CASTBAR"}, -- Wailing Grief
	}, {
		[328740] = L.cultist,
		[333227] = L.warlord,
		[333787] = L.enraged,
		[334051] = L.speaker,

		[332678] = L.deathwalker,
		[332706] = L.priest,
		[332612] = L.hexxer,

		[331927] = L.drill,
		[331548] = L.arf_arf,
		[332084] = L.lubricator,
		[332157] = L.headless,

		["soporific_shimmerdust"] = L.shimmermoth,
		[340026] = L.mythresh,
	}
end

function mod:OnBossEnable()
	-- [[ The ring ]] --
	self:Log("SPELL_CAST_SUCCESS", "DarkLotus", 328740)
	self:Log("SPELL_AURA_APPLIED", "UndyingRageApplied", 333227)
	self:Log("SPELL_AURA_REMOVED", "UndyingRageRemoved", 333227)
	self:Log("SPELL_AURA_APPLIED", "ReaverApplied", 333250)
	self:Log("SPELL_PERIODIC_DAMAGE", "ReaverApplied", 333250)
	self:Log("SPELL_PERIODIC_MISSED", "ReaverApplied", 333250)
	self:Log("SPELL_CAST_SUCCESS", "Rage", 333787)
	self:Log("SPELL_CAST_START", "EruptingDarkness", 334051)

	-- [[ Path to Hakkar ]] --
	self:Log("SPELL_AURA_APPLIED_DOSE", "GushingWound", 332678)
	self:Log("SPELL_CAST_START", "Bladestorm", 332671)
	self:Log("SPELL_CAST_START", "Heal", 332706)
	self:Log("SPELL_CAST_START", "HealingWave", 332612)
	self:Log("SPELL_CAST_START", "Hex", 332605)
	self:Log("SPELL_CAST_START", "LightningDischarge", 332608)

	-- [[ Path to the Manastorms ]] --
	self:Log("SPELL_CAST_START", "HaywirePreCast", 331927)
	self:Log("SPELL_CAST_SUCCESS", "Haywire", 331927)
	self:Log("SPELL_AURA_REMOVED", "HaywireOver", 331927)
	self:Log("SPELL_CAST_START", "MetallicJaws", 331548)
	self:Log("SPELL_CAST_SUCCESS", "MetallicJawsSuccess", 331548)
	self:Log("SPELL_CAST_START", "Woof", 331846)
	self:Log("SPELL_CAST_SUCCESS", "WoofSuccess", 331846)
	self:Log("SPELL_CAST_START", "SelfCleaningCycle", 332084)
	self:Death("ArfArfDeath", 167964)

	-- [[ Path to Xyexa ]] --
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoporificShimmerdust", 334496)
	self:Log("SPELL_CAST_START", "WailingGrief", 340026)
	self:Log("SPELL_CAST_SUCCESS", "WailingGriefSuccess", 340026)
	self:Death("MythreshDeath", 171184)

	-- [[ Common ]] --
	self:Log("SPELL_DAMAGE", "PeriodicDamage", 332672, 332157) -- Bladestorm, Spinning Up
	self:Log("SPELL_MISSED", "PeriodicDamage", 332672, 332157)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- [[ The ring ]] --
-- Risen Cultist
do
	local prev = 0
	function mod:DarkLotus(args)
		if self:Friendly(args.sourceFlags) then return end

		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Risen Warlord
function mod:UndyingRageApplied(args)
	self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
	self:PlaySound(args.spellId, (self:Tank() or self:Dispeller("enrage", true)) and "warning" or "alert")
	self:NameplateCDBar(args.spellId, 33, args.sourceGUID)
end

function mod:UndyingRageRemoved(args)
	self:Message(args.spellId, "green", CL.removed_from:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:ReaverApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Death Speaker
function mod:EruptingDarkness(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 4)
end

-- Enraged Spirit
function mod:Rage(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 6)
end

-- [[ Path to Hakkar ]] --
-- Atal'ai Deathwalker
function mod:GushingWound(args)
	local stacks = args.amount
	if stacks % 3 == 0 then
		self:StackMessageOld(args.spellId, args.destName, stacks, "purple")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:Bladestorm(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(332672, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(332672, "info")
		end
	end
end

-- Atal'ai High Priest
function mod:Heal(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Atal'ai Hoodoo Hexxer
function mod:HealingWave(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:Hex(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(332608, "orange", name)
		self:PlaySound(332608, "alarm", nil, name)

		if self:Me(guid) then
			self:Say(332608, nil, nil, "Lightning Discharge")
		end
	end

	function mod:LightningDischarge(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

-- [[ Path to the Manastorms ]] --
-- Defunct Dental Drill
function mod:HaywirePreCast(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:Haywire(args)
	self:CastBar(args.spellId, 4)
	self:NameplateCDBar(args.spellId, 19, args.sourceGUID)
end

function mod:HaywireOver(args)
	self:StopBar(CL.cast:format(args.spellName))
end

-- 4.RF-4.RF
function mod:MetallicJaws(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:MetallicJawsSuccess(args)
	self:CDBar(args.spellId, 9.9)
end

do
	local startedAt = 0
	local function printTarget(self, name, guid)
		local left = startedAt + 3 - GetTime()
		local isOnMe = self:Me(guid)

		self:TargetMessage(331846, "orange", name)
		self:PlaySound(331846, isOnMe and "warning" or "alert", nil, name)
		self:CastBar(331846, left)

		if isOnMe then
			self:Say(331846, nil, nil, "Woof")
			self:SayCountdown(331846, left, nil, 2)
		end
	end

	function mod:Woof(args)
		startedAt = GetTime()
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:WoofSuccess(args)
	self:CDBar(args.spellId, 6.7)
end

function mod:ArfArfDeath()
	self:StopBar(331548) -- Metallic Jaws

	-- W-00F
	self:StopBar(331846)
	self:StopBar(CL.cast:format(self:SpellName(331846)))
	self:CancelSayCountdown(331846)
end

-- Lubricator
function mod:SelfCleaningCycle(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- [[ Path to Xyexa ]] --
-- Weald Shimmermoth
function mod:SoporificShimmerdust(args)
	if self:Me(args.destGUID) then
		local stacks = args.amount
		if stacks % 2 == 0 or stacks >= 8 then
			self:StackMessageOld("soporific_shimmerdust", args.destName, stacks, "blue", nil, self:SpellName(L.soporific_shimmerdust), L.soporific_shimmerdust_icon)
			self:PlaySound("soporific_shimmerdust", stacks >= 8 and "warning" or "alarm")
		end
	end
end

-- Mythresh, Sky's Talons
function mod:WailingGrief(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 3)
end

function mod:WailingGriefSuccess(args)
	self:Bar(args.spellId, 15.2)
end

function mod:MythreshDeath()
	-- Wailing Grief
	self:StopBar(340026)
	self:StopBar(CL.cast:format(self:SpellName(340026)))
end

-- [[ Common ]] --
do
	local prev = 0
	function mod:PeriodicDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > (self:Melee() and 6 or 1.5) then
				prev = t

				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end
