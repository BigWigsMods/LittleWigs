
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Horrific Vision of Stormwind Trash", 2213)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	155604, -- Image of Wrathion
	152704, -- Crawling Corruption
	160061, -- Crawling Corruption
	158092, -- Fallen Heartpiercer
	153760, -- Enthralled Footman
	158146, -- Fallen Riftwalker
	157158, -- Cultist Slavedriver
	158136, -- Inquisitor Darkspeak
	158437, -- Fallen Taskmaster
	158158, -- Forge-Guard Hurrul
	152722, -- Fallen Voidspeaker
	156795, -- SI:7 Informant
	152809, -- Alx'kov the Infested
	156949, -- Armsmaster Terenson
	153130, -- Greater Void Elemental
	152939, -- Boundless Corruption
	152722, -- Fallen Voidspeaker
	159275, -- Portal Keeper
	158371 -- Zardeth of the Black Claw
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.crawling_corruption = "Crawling Corruption"
	L.fallen_heartpiercer = "Fallen Heartpiercer"
	L.enthralled_footman = "Enthralled Footman"
	L.fallen_riftwalker = "Fallen Riftwalker"
	L.cultist_slavedriver = "Cultist Slavedriver"
	L.inquisitor_darkspeak = "Inquisitor Darkspeak"
	L.fallen_taskmaster = "Fallen Taskmaster"
	L.forge_guard_hurrul = "Forge-Guard Hurrul"
	L.fallen_voidspeaker = "Fallen Voidspeaker"
	L.si7_informant = "SI:7 Informant"
	L.alxkov_the_infested = "Alx'kov the Infested"
	L.armsmaster_terenson = "Armsmaster Terenson"
	L.greater_void_elemental = "Greater Void Elemental"
	L.boundless_corruption = "Boundless Corruption"
	L.portal_keeper = "Portal Keeper"
	L.zardeth_of_the_black_claw = "Zardeth of the Black Claw"
end


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"altpower",
		311996, -- Open Vision
		-- Crawling Corruption
		296510, -- Creepy Crawler
		-- Fallen Heartpiercer
		{308308, "SAY"}, -- Piercing Shot
		-- Enthralled Footman
		298584, -- Repel
		-- Fallen Riftwalker
		308481, -- Rift Strike
		308575, -- Shadow Shift
		-- Cultist Slavedriver
		309882, -- Brutal Smash
		-- Inquisitor Darkspeak
		308366, -- Agonizing Torment
		308380, -- Convert
		-- Fallen Taskmaster
		308998, -- Improve Morale
		308967, -- Continuous Beatings
		-- Forge-Guard Hurrul
		308406, -- Entropic Leap
		-- Fallen Voidspeaker
		308375, -- Psychic Scream
		-- SI:7 Informant
		298033, -- Touch of the Abyss
		-- Alx'kov the Infested
		{308265, "DISPEL"}, -- Corrupted Blight
		296669, -- Lurking Appendage
		{308305, "SAY"}, -- Blight Eruption
		-- Armsmaster Terenson
		311399, -- Blade Flourish
		311456, -- Roaring Blast
		-- Greater Void Elemental
		297315, -- Void Buffet
		-- Boundless Corruption
		296911, -- Chaos Breath
		-- Fallen Voidspeaker
		308375, -- Psychic Scream
		-- Zardeth of the Black Claw
		308801, -- Rain of Fire
	}, {
		["altpower"] = "general",
		[296510] = L.crawling_corruption,
		[298584] = L.enthralled_footman,
		[308481] = L.fallen_riftwalker,
		[309882] = L.cultist_slavedriver,
		[308366] = L.inquisitor_darkspeak,
		[308998] = L.fallen_taskmaster,
		[308406] = L.forge_guard_hurrul,
		[308375] = L.fallen_voidspeaker,
		[298033] = L.si7_informant,
		[308265] = L.alxkov_the_infested,
		[311399] = L.armsmaster_terenson,
		[297315] = L.greater_void_elemental,
		[296911] = L.boundless_corruption,
		[308375] = L.fallen_voidspeaker,
		[308801] = L.zardeth_of_the_black_claw,
	}
end

-- Some mob ids are shared by different visions
function mod:VerifyEnable()
	local _, _, _, _, _, _, _, instanceId = GetInstanceInfo()
	return instanceId == 2213
end

function mod:OnBossEnable()
	self:OpenAltPower("altpower", 318335, "ZA") -- Sanity

	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:Log("SPELL_CAST_SUCCESS", "MindProtected", 291295)	-- Cast when the vision ends
	self:Log("SPELL_CAST_START", "CreepyCrawler", 296510)
	self:Log("SPELL_CAST_START", "PiercingShot", 308308)
	self:Log("SPELL_CAST_SUCCESS", "Repel", 298584)
	self:Log("SPELL_CAST_START", "RiftStrike", 308481)
	self:Log("SPELL_CAST_START", "ShadowShift", 308575)
	self:Log("SPELL_CAST_START", "BrutalSmash", 309882)
	self:Log("SPELL_CAST_START", "AgonizingTorment", 308366)
	self:Log("SPELL_CAST_START", "Convert", 308380)
	self:Log("SPELL_CAST_START", "ImproveMorale", 308998)
	self:Log("SPELL_AURA_APPLIED", "ContinuousBeatingsApplied", 308967)
	self:Log("SPELL_CAST_START", "EntropicLeap", 308406)
	self:Log("SPELL_CAST_START", "PsychicScream", 308375)
	self:Log("SPELL_CAST_START", "TouchOfTheAbyss", 298033)
	self:Log("SPELL_AURA_APPLIED", "CorruptedBlightApplied", 308265)
	self:Log("SPELL_CAST_START", "LurkingAppendage", 296669)
	self:Log("SPELL_CAST_START", "BlightEruption", 308305)
	self:Log("SPELL_CAST_START", "BladeFlourish", 311399)
	self:Log("SPELL_CAST_START", "RoaringBlast", 311456)
	self:Log("SPELL_CAST_START", "VoidBuffet", 297315)
	self:Log("SPELL_CAST_START", "ChaosBreath", 296911)
	self:Log("SPELL_CAST_START", "PsychicScream", 308375)
	self:Log("SPELL_CAST_START", "RainOfFire", 308801)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevCastGUID
	function mod:UNIT_SPELLCAST_START(_, _, castGUID, spellId)
		if spellId == 311996 and castGUID ~= prevCastGUID then -- Open Vision
			prevCastGUID = castGUID
			self:Message2(311996, "cyan")
			self:PlaySound(311996, "long")
			self:Bar(311996, 10) -- Open Vision
		end
	end
end

function mod:MindProtected(args)
	self:CloseAltPower("altpower")
end

do
	local prev = 0
	function mod:CreepyCrawler(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(308308)
		end
	end
	
	function mod:PiercingShot(args)
		self:Message2(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:GetUnitTarget(printTarget, 0.6, args.sourceGUID)
	end
end

function mod:Repel(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if t-prev > 1.5 and IsItemInRange(37727, name) then -- Ruby Acorn, 5yd
			prev = t
			self:Message2(308481, "blue", CL.near:format(self:SpellName(308481)))
			self:PlaySound(308481, "alarm")
		end
	end
	
	function mod:RiftStrike(args)
		-- Does an AoE around the target
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:ShadowShift(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BrutalSmash(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:AgonizingTorment(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:Convert(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

function mod:ImproveMorale(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:ContinuousBeatingsApplied(args)
	self:Message2(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "alert")
end

function mod:EntropicLeap(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:PsychicScream(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:TouchOfTheAbyss(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:CorruptedBlightApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:LurkingAppendage(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BlightEruption(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if self:UnitDebuff("player", 308265) then -- Corrupted Blight
		self:Say(args.spellId)
	end
end

function mod:BladeFlourish(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:RoaringBlast(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoidBuffet(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:ChaosBreath(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:PsychicScream(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:RainOfFire(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
