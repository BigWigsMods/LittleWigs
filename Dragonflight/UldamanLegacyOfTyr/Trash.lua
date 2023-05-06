--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Uldaman: Legacy of Tyr Trash", 2451)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	184134, -- Scavenging Leaper
	184020, -- Hulking Berserker
	184023, -- Vicious Basilisk
	184132, -- Earthen Warder
	186420, -- Earthen Weaver
	184107, -- Runic Protector
	184301, -- Cavern Seeker
	184300, -- Ebonstone Golem
	184131, -- Earthen Guardian
	184335, -- Infinite Agent
	191220  -- Chrono-Lord Deios (RP version)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hulking_berserker = "Hulking Berserker"
	L.vicious_basilisk = "Vicious Basilisk"
	L.earthen_warder = "Earthen Warder"
	L.earthen_weaver = "Earthen Weaver"
	L.runic_protector = "Runic Protector"
	L.cavern_seeker = "Cavern Seeker"
	L.ebonstone_golem = "Ebonstone Golem"
	L.earthen_guardian = "Earthen Guardian"
	L.infinite_agent = "Infinite Agent"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		386104, -- Lost Tome of Tyr
		375500, -- Time Lock
		-- Hulking Berserker
		369811, -- Brutal Slam
		-- Vicious Basilisk
		{369823, "DISPEL"}, -- Spiked Carapace
		-- Earthen Warder
		{369400, "DISPEL"}, -- Earthen Ward
		{369365, "DISPEL"}, -- Curse of Stone
		{369366, "DISPEL", "SAY"}, -- Trapped in Stone
		-- Earthen Weaver
		369465, -- Hail of Stone
		-- Runic Protector
		369335, -- Fissuring Slam
		369337, -- Difficult Terrain
		369328, -- Earthquake
		-- Cavern Seeker
		369411, -- Sonic Burst
		-- Ebonstone Golem
		381593, -- Thunderous Clap
		-- Earthen Guardian
		382578, -- Blessing of Tyr
		-- Infinite Agent
		{377500, "DISPEL"}, -- Hasten
	}, {
		[386104] = CL.general,
		[369811] = L.hulking_berserker,
		[369823] = L.vicious_basilisk,
		[369400] = L.earthen_warder,
		[369465] = L.earthen_weaver,
		[369335] = L.runic_protector,
		[369411] = L.cavern_seeker,
		[381593] = L.ebonstone_golem,
		[382578] = L.earthen_guardian,
		[377500] = L.infinite_agent,
	}
end

function mod:OnBossEnable()
	-- General
	self:Log("SPELL_AURA_APPLIED", "LostTomeOfTyr", 386104)
	self:Log("SPELL_AURA_APPLIED", "TimeLock", 375500)
	self:Log("SPELL_CAST_SUCCESS", "TemporalTheft", 382264)

	-- Hulking Berserker
	self:Log("SPELL_CAST_START", "BrutalSlam", 369811)

	-- Vicious Basilisk
	self:Log("SPELL_CAST_START", "SpikedCarapace", 369823)
	self:Log("SPELL_AURA_APPLIED", "SpikedCarapaceApplied", 369823)

	-- Earthen Warder
	self:Log("SPELL_CAST_START", "EarthenWard", 369400)
	self:Log("SPELL_AURA_APPLIED", "EarthenWardApplied", 369400)
	self:Log("SPELL_CAST_START", "CurseOfStone", 369365)
	self:Log("SPELL_AURA_APPLIED", "CurseOfStoneApplied", 369365)
	self:Log("SPELL_AURA_APPLIED", "TrappedInStoneApplied", 369366)

	-- Earthen Weaver
	self:Log("SPELL_CAST_SUCCESS", "HailOfStone", 369465) -- doesn't go on CD until the channel starts

	-- Runic Protector
	self:Log("SPELL_CAST_START", "FissuringSlam", 369335)
	self:Log("SPELL_AURA_APPLIED", "DifficultTerrainApplied", 369337)
	self:Log("SPELL_CAST_SUCCESS", "Earthquake", 369328)

	-- Cavern Seeker
	self:Log("SPELL_CAST_START", "SonicBurst", 369411)

	-- Ebonstone Golem
	self:Log("SPELL_CAST_START", "ThunderousClap", 381593)

	-- Earthen Guardian
	self:Log("SPELL_CAST_START", "BlessingOfTyr", 382578)

	-- Infinite Agent
	self:Log("SPELL_CAST_START", "Hasten", 377500)
	self:Log("SPELL_AURA_APPLIED", "HastenApplied", 377500)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

do
	local prev = 0

	function mod:LostTomeOfTyr(args)
		-- for some reason this buff gets reapplied when you gain Time Lock, suppress alert
		if args.time - prev > 25 and self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end

	function mod:TimeLock(args)
		local t = args.time
		-- very long throttle
		if t - prev > 25 then
			prev = t
			self:Bar(args.spellId, 22.1)
		end
	end
end

function mod:TemporalTheft(args)
	-- Chrono-Lord Deios warmup
	local chronoLordDeiosModule = BigWigs:GetBossModule("Chrono-Lord Deios", true)
	if chronoLordDeiosModule then
		chronoLordDeiosModule:Enable()
		chronoLordDeiosModule:Warmup()
	end
end

-- Hulking Berserker

do
	local prev = 0
	function mod:BrutalSlam(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 20.6, args.sourceGUID)
	end
end

-- Vicious Basilisk

do
	local prev = 0
	function mod:SpikedCarapace(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 18.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:SpikedCarapaceApplied(args)
		if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

-- Earthen Warder

function mod:EarthenWard(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 32.6, args.sourceGUID)
end

function mod:EarthenWardApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local prev = 0
	function mod:CurseOfStone(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 46.0, args.sourceGUID)
	end
end

function mod:CurseOfStoneApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:TrappedInStoneApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

-- Earthen Weaver

do
	local prev = 0
	function mod:HailOfStone(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 21.7, args.sourceGUID)
	end
end

-- Runic Protector

function mod:FissuringSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 9.7, args.sourceGUID)
end

function mod:DifficultTerrainApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

function mod:Earthquake(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	--self:NameplateCDBar(args.spellId, 25.5, args.sourceGUID)
end

-- Cavern Seeker

do
	local prev = 0
	function mod:SonicBurst(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Ebonstone Golem

do
	local prev = 0
	function mod:ThunderousClap(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 19.0, args.sourceGUID)
	end
end

-- Earthen Guardian

function mod:BlessingOfTyr(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 48.6, args.sourceGUID)
end

-- Infinite Agent

do
	local prev = 0
	function mod:Hasten(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 22.6, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:HastenApplied(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
				self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end
