
--------------------------------------------------------------------------------
-- TODO
--

-- Add spellID of periodic damage caused by Purification Strike (Purification Construct);
-- Maybe there's a way to detect Pool of Darkness spawns, no SPELL_SUMMON, SPELL_CAST_* events (Shadow of Zul).

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King's Rest Trash", 1762)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	133935, -- Animated Guardian
	133943, -- Minion of Zul
	134158, -- Shadow-Borne Champion
	134174, -- Shadow-Borne Witchdoctor
	134157, -- Shadow-Borne Warrior
	137474, -- King Timalji
	137478, -- Queen Wasi
	134331, -- King Rahu'ai
	137473, -- Guard Captain Atu
	134251, -- Seneschal M'bara
	137486, -- Queen Patla
	137487, -- Skeletal Hunting Raptor
	135192, -- Honored Raptor
	137484, -- King A'akul
	137485, -- Bloodsworn Agent
	134739, -- Purification Construct
	137989, -- Embalming Fluid
	137969, -- Interment Construct
	135204, -- Spectral Hex Priest
	135167, -- Spectral Berserker
	135239, -- Spectral Witch Doctor
	135235, -- Spectral Beastmaster
	135231, -- Spectral Brute
	138489 -- Shadow of Zul
)

--------------------------------------------------------------------------------
-- Locals
--

local prevTable = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.guardian = "Animated Guardian"
	L.minion = "Minion of Zul"
	L.champion = "Shadow-Borne Champion"
	L.shadow_witchdoctor = "Shadow-Borne Witchdoctor"
	L.warrior = "Shadow-Borne Warrior"
	L.timalji = "King Timalji"
	L.wasi = "Queen Wasi"
	L.rahuai = "King Rahu'ai"
	L.atu = "Guard Captain Atu"
	L.mbara = "Seneschal M'bara"
	L.patla = "Queen Patla"
	L.raptor = "Skeletal Hunting Raptor"
	L.aakul = "King A'akul"
	L.agent = "Bloodsworn Agent"
	L.purification_construct = "Purification Construct"
	L.fluid = "Embalming Fluid"
	L.interment_construct = "Interment Construct"
	L.hex_priest = "Spectral Hex Priest"
	L.berserker = "Spectral Berserker"
	L.spectral_witchdoctor = "Spectral Witch Doctor"
	L.beastmaster = "Spectral Beastmaster"
	L.brute = "Spectral Brute"
	L.zul = "Shadow of Zul"

	L.healing_tide_totem = 270497
	L.healing_tide_totem_desc = 270497
	L.healing_tide_totem_icon = "ability_shaman_healingtide"

	L.casting_on_you = "Casting %s on YOU"
	L.casting_on_other = "Casting %s: %s"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Animated Guardian
		270003, -- Suppression Slam
		270016, -- Released Inihibitors

		-- Minion of Zul
		{269936, "SAY"}, -- Fixate

		-- Shadow-Borne Champion
		269976, -- Ancestral Fury

		-- Shadow-Borne Witchdoctor
		269972, -- Shadow Bolt Volley

		-- Shadow-Borne Warrior
		269931, -- Gust Slash

		-- King Timalji
		{270928, "SAY", "CASTBAR"}, -- Bladestorm

		-- Queen Wasi
		270920, -- Seduction

		-- King Rahu'ai
		270891, -- Channel Lightning

		-- Guard Captain Atu
		270084, -- Axe Barrage

		-- Seneschal M'bara
		270901, -- Induce Regeneration

		-- Queen Patla
		270931, -- Darkshot

		-- Skeletal Hunting Raptor, Honored Raptor
		270503, -- Hunting Leap

		-- King A'akul
		{270865, "SAY"}, -- Hidden Blade

		-- Bloodsworn Agent
		270872, -- Shadow Whirl

		-- Purification Construct
		270284, -- Purification Beam

		-- Embalming Fluid
		271564, -- Embalming Fluid

		-- Interment Construct
		271555, -- Entomb

		-- Spectral Hex Priest
		270492, -- Hex

		-- Spectral Berserker
		{270487, "TANK_HEALER"}, -- Severing Blade
		270482, -- Blooded Leap

		-- Spectral Witch Doctor
		"healing_tide_totem",
		270499, -- Frost Shock

		-- Spectral Beastmaster
		{270507, "SAY", "FLASH"}, -- Poison Barrage
		{270506, "FLASH", "ME_ONLY_EMPHASIZE"}, -- Deadeye Shot

		-- Spectral Brute
		270514, -- Ground Crush

		-- Shadow of Zul
		{271640, "SAY", "SAY_COUNTDOWN"}, -- Dark Revelation
	}, {
		[270003] = L.guardian,
		[269936] = L.minion,
		[269976] = L.champion,
		[269972] = L.shadow_witchdoctor,
		[269931] = L.warrior,
		[270928] = L.timalji,
		[270920] = L.wasi,
		[270891] = L.rahuai,
		[270084] = L.atu,
		[270901] = L.mbara,
		[270931] = L.patla,
		[270503] = L.raptor,
		[270865] = L.aakul,
		[270872] = L.agent,
		[270284] = L.purification_construct,
		[271564] = L.fluid,
		[271555] = L.interment_construct,
		[270492] = L.hex_priest,
		[270487] = L.berserker,
		["healing_tide_totem"] = L.spectral_witchdoctor,
		[270507] = L.beastmaster,
		[270514] = L.brute,
		[271640] = L.zul,
	}
end

function mod:OnBossEnable()
	-- Animated Guardian
	self:Log("SPELL_CAST_START", "SuppressionSlam", 270003)
	self:Log("SPELL_AURA_APPLIED", "ReleasedInihibitors", 270016)

	-- Minion of Zul
	self:Log("SPELL_AURA_APPLIED", "Fixate", 269936)

	-- Shadow-Borne Champion
	self:Log("SPELL_AURA_APPLIED", "AncestralFury", 269976)

	-- Shadow-Borne Witchdoctor
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 269972)

	-- Shadow-Borne Warrior
	self:Log("SPELL_CAST_START", "GustSlash", 269931)
	self:Log("SPELL_AURA_APPLIED", "GustSlashApplied", 269932)

	-- King Timalji
	self:Log("SPELL_AURA_APPLIED", "Bladestorm", 270927)
	self:Log("SPELL_AURA_REMOVED", "BladestormRemoved", 270927)

	-- Queen Wasi
	self:Log("SPELL_AURA_APPLIED", "Seduction", 270920)
	self:Log("SPELL_AURA_REMOVED", "SeductionRemoved", 270920)

	-- King Rahu'ai
	self:Log("SPELL_CAST_START", "ChannelLightning", 270889)

	-- Guard Captain Atu
	self:Log("SPELL_CAST_START", "AxeBarrage", 270084)

	-- Seneschal M'bara
	self:Log("SPELL_CAST_START", "InduceRegeneration", 270901)
	self:Log("SPELL_AURA_APPLIED", "InduceRegenerationApplied", 270901)
	self:Log("SPELL_AURA_REMOVED", "InduceRegenerationRemoved", 270901)

	-- King A'akul
	self:Log("SPELL_AURA_APPLIED", "HiddenBladeApplied", 270865)
	self:Log("SPELL_AURA_REMOVED", "HiddenBladeRemoved", 270865)

	-- Bloodsworn Agent
	self:Log("SPELL_CAST_START", "ShadowWhirl", 270872)

	-- Purification Construct
	self:Log("SPELL_CAST_START", "PurificationBeam", 270284)
	self:Log("SPELL_AURA_APPLIED", "PurificationBeamApplied", 270289)

	-- Embalming Fluid
	self:Log("SPELL_AURA_APPLIED", "EmbalmingFluid", 271564)
	self:Log("SPELL_AURA_APPLIED_DOSE", "EmbalmingFluid", 271564)

	-- Interment Construct
	self:Log("SPELL_AURA_APPLIED", "Entomb", 271555)

	-- Spectral Hex Priest
	self:Log("SPELL_CAST_START", "Hex", 270492)
	self:Log("SPELL_AURA_APPLIED", "HexApplied", 270492)
	self:Log("SPELL_AURA_REMOVED", "HexRemoved", 270492)

	-- Spectral Berserker
	self:Log("SPELL_AURA_APPLIED", "SeveringBlade", 270487)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SeveringBlade", 270487)
	self:Log("SPELL_CAST_START", "BloodedLeap", 270482)

	-- Spectral Witch Doctor
	self:Log("SPELL_SUMMON", "HealingTideTotem", 270497)
	self:Log("SPELL_AURA_APPLIED", "FrostShockApplied", 270499)
	self:Log("SPELL_AURA_REMOVED", "FrostShockRemoved", 270499)

	-- Spectral Beastmaster
	self:Log("SPELL_CAST_START", "PoisonBarrage", 270507)
	self:Log("SPELL_AURA_APPLIED", "PoisonBarrageApplied", 270507)
	self:Log("SPELL_CAST_START", "DeadeyeShot", 270506)

	-- Spectral Brute
	self:Log("SPELL_CAST_START", "GroundCrush", 270514)

	-- Shadow of Zul
	self:Log("SPELL_AURA_APPLIED", "DarkRevelation", 271640)
	self:Log("SPELL_AURA_REMOVED", "DarkRevelationRemoved", 271640)

	-- Periodic damage that surrounds a casting mob (higher throttle for melees):
	self:Log("SPELL_PERIODIC_DAMAGE", "MeleeUnfriendlyPeriodicDamage", 270928, 270891) -- Bladestorm, Channel Lightning
	self:Log("SPELL_PERIODIC_MISSED", "MeleeUnfriendlyPeriodicDamage", 270928, 270891)

	-- Periodic damage that does not:
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 270931, 270503) -- Darkshot, Hunting Leap
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 270931, 270503)
end

function mod:OnBossDisable()
	prevTable = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local function isThrottled(spellId, timediff)
	local t = GetTime()
	if t - (prevTable[spellId] or 0) > (timediff or 1) then
		prevTable[spellId] = t
		return false
	end
	return true
end

-- Animated Guardian
function mod:SuppressionSlam(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:ReleasedInihibitors(args)
	self:Message(args.spellId, "orange", CL.other:format(args.spellName, args.destName))

	if isThrottled(args.spellId) then return end
	self:PlaySound(args.spellId, "info")
end

-- Minion of Zul
function mod:Fixate(args)
	if self:Me(args.destGUID) and not isThrottled(args.spellId) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alert")
		self:Say(args.spellId, nil, nil, "Fixate")
	end
end

-- Shadow-Borne Champion
function mod:AncestralFury(args)
	self:Message(args.spellId, "orange", CL.other:format(args.spellName, args.destName))

	if isThrottled(args.spellId) then return end
	self:PlaySound(args.spellId, self:Dispeller("enrage", true) and "alarm" or "info")
end

-- Shadow-Borne Witchdoctor
function mod:ShadowBoltVolley(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Shadow-Borne Warrior
function mod:GustSlash(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:GustSlashApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(269931)
		self:PlaySound(269931, "alert")
	end
end

-- King Timalji
function mod:Bladestorm(args)
	if self:MobId(args.destGUID) == 137474 then return end -- applies to himself too
	self:CastBar(270928, 10)
	self:TargetMessage(270928, "orange", args.destName)
	self:PlaySound(270928, "alarm", nil, args.destName)

	if self:Me(args.destGUID) then
		self:Say(270928, nil, nil, "Bladestorm")
	end
end

function mod:BladestormRemoved(args)
	self:StopBar(CL.cast:format(args.spellName))
end

-- Queen Wasi
function mod:Seduction(args)
	self:TargetBar(args.spellId, 30, args.destName)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, self:Dispeller("magic", true) and "warning" or "long", nil, args.destName)
end

function mod:SeductionRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- King Rahu'ai
function mod:ChannelLightning(args)
	self:Message(270891, "orange", CL.casting:format(args.spellName))
	self:PlaySound(270891, "long")
end

-- Guard Captain Atu
function mod:AxeBarrage(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Seneschal M'bara
function mod:InduceRegeneration(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:InduceRegenerationApplied(args)
	if self:MobId(args.sourceGUID) ~= 134251 then return end -- filter out Spellsteal
	self:TargetBar(args.spellId, 10, args.destName)
	self:Message(args.spellId, "cyan", CL.other:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "info")
end

function mod:InduceRegenerationRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- King A'akul
function mod:HiddenBladeApplied(args)
	local isOnMe = self:Me(args.destGUID)

	if isOnMe then
		self:Say(args.spellId, nil, nil, "Hidden Blade")
	end

	if isOnMe or self:Dispeller("poison") or self:Healer() then
		self:TargetBar(args.spellId, 4, args.destName)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:HiddenBladeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Bloodsworn Agent
function mod:ShadowWhirl(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Purification Construct
function mod:PurificationBeam(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:PurificationBeamApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(270284)
		self:PlaySound(270284, "alert")
	end
end

-- Embalming Fluid
function mod:EmbalmingFluid(args)
	if self:Me(args.destGUID) then
		if isThrottled(args.spellId, 1.5) then return end
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "alert")
	end
end

-- Interment Construct
function mod:Entomb(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

-- Spectral Hex Priest
function mod:Hex(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:HexApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse") or self:Healer(args.destName) then
		self:TargetBar(args.spellId, 10, args.destName)
		self:TargetMessage(args.spellId, "cyan", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:HexRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Spectral Berserker
function mod:SeveringBlade(args)
	self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "long", nil, args.destName)
end

function mod:BloodedLeap(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Spectral Witch Doctor
function mod:HealingTideTotem()
	self:Message("healing_tide_totem", "red", self:SpellName(L.healing_tide_totem), L.healing_tide_totem_icon) -- 5th arg is ignored if 4th is a number

	if isThrottled("healing_tide_totem") then return end
	self:PlaySound("healing_tide_totem", "warning")
end

function mod:FrostShockApplied(args)
	local isOnMe = self:Me(args.destGUID)

	if isOnMe then
		self:TargetBar(args.spellId, 15, args.destName)
	end

	if isOnMe or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "cyan", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:FrostShockRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Spectral Beastmaster
do
	local function printTarget(self, name, guid)
		if isThrottled(("%d-%s"):format(270507, guid)) then return end
		if self:Me(guid) then
			self:Message(270507, "red", L.casting_on_you:format(self:SpellName(270507)))
			self:Flash(270507)
			self:Say(270507, nil, nil, "Poison Barrage")
		else
			self:Message(270507, "red", L.casting_on_other:format(self:SpellName(270507), self:ColorName(name)))
		end
		self:PlaySound(270507, "warning", nil, name)
	end

	function mod:PoisonBarrage(args)
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
	end
end

do
	local isOnMe = nil
	local playerList = {}

	local function announceDebuffs()
		if isOnMe or mod:Dispeller("poison") then
			if isOnMe or not mod:CheckOption(270507, "ME_ONLY") then
				-- PlaySound only plays the sound when the table
				-- has 1 entry, if ME_ONLY is disabled.
				mod:PlaySound(270507, "alert")
			end
			local numInTable = #playerList
			mod:TargetsMessageOld(270507, "cyan", mod:ColorName(playerList), numInTable)
		else
			playerList = {}
		end
		isOnMe = nil
	end

	function mod:PoisonBarrageApplied(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:SimpleTimer(announceDebuffs, 0.2)
		end
		if self:Me(args.destGUID) then
			isOnMe = true
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(270506, "red", name)
		self:PlaySound(270506, "warning", nil, name)
		if self:Me(guid) then
			self:Flash(270506)
		end
	end

	function mod:DeadeyeShot(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:DarkRevelation(args)
	self:TargetBar(args.spellId, 10, args.destName)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)

	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Dark Revelation")
		self:SayCountdown(args.spellId, 10)
	end
end

function mod:DarkRevelationRemoved(args)
	self:StopBar(args.spellName, args.destName)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Spectral Brute
function mod:GroundCrush(args)
	if isThrottled(args.spellId) then return end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Bladestorm, Channel Lightning
function mod:MeleeUnfriendlyPeriodicDamage(args)
	if self:Me(args.destGUID) then
		if isThrottled(args.spellId, self:Melee() and 6 or 1.5) then return end
		self:PersonalMessage(args.spellId, "near")
		self:PlaySound(args.spellId, "alert")
	end
end

-- Darkshot, Hunting Leap
function mod:PeriodicDamage(args)
	if self:Me(args.destGUID) then
		if isThrottled(args.spellId, 1.5) then return end
		if args.spellId == 270503 then
			self:PersonalMessage(args.spellId, "near")
		else
			self:PersonalMessage(args.spellId, "underyou")
		end
		self:PlaySound(args.spellId, "alert")
	end
end
