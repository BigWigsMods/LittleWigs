
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Horrific Vision of Stormwind Trash", 2213)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	155604, -- Image of Wrathion
	152704, -- Crawling Corruption
	158092, -- Fallen Heartpiercer
	153760, -- Enthralled Footman
	158146, -- Fallen Riftwalker
	157158, -- Cultist Slavedriver
	158136, -- Inquisitor Darkspeak
	158437, -- Fallen Taskmaster
	158158 -- Forge-Guard Hurrul
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
	}, {
		["altpower"] = "general",
		[296510] = L.crawling_corruption,
		[298584] = L.enthralled_footman,
		[308481] = L.fallen_riftwalker,
		[309882] = L.cultist_slavedriver,
		[308366] = L.inquisitor_darkspeak,
		[308998] = L.fallen_taskmaster,
		[308406] = L.forge_guard_hurrul,
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
