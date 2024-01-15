--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Uldaman: Legacy of Tyr Trash", 2451)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	184134, -- Scavenging Leaper
	184020, -- Hulking Berserker
	184022, -- Stonevault Geomancer
	184023, -- Vicious Basilisk
	184319, -- Refti Custodian
	184130, -- Earthen Custodian
	186420, -- Earthen Weaver
	184132, -- Earthen Warder
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
	L.stonevault_geomancer = "Stonevault Geomancer"
	L.vicious_basilisk = "Vicious Basilisk"
	L.refti_custodian = "Refti Custodian"
	L.earthen_custodian = "Earthen Custodian"
	L.earthen_weaver = "Earthen Weaver"
	L.earthen_warder = "Earthen Warder"
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
		-- Stonevault Geomancer
		369675, -- Chain Lightning
		-- Vicious Basilisk
		{369823, "DISPEL"}, -- Spiked Carapace
		-- Refti Custodian
		{377732, "TANK"}, -- Jagged Bite
		377738, -- Ancient Power
		377724, -- Systemic Vulnerability
		-- Earthen Custodian
		369409, -- Cleave
		-- Earthen Weaver
		369465, -- Hail of Stone
		-- Earthen Warder
		{369400, "DISPEL"}, -- Earthen Ward
		{369365, "DISPEL"}, -- Curse of Stone
		{369366, "DISPEL", "SAY"}, -- Trapped in Stone
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
		[369675] = L.stonevault_geomancer,
		[369823] = L.vicious_basilisk,
		[377732] = L.refti_custodian,
		[369409] = L.earthen_custodian,
		[369465] = L.earthen_weaver,
		[369400] = L.earthen_warder,
		[369335] = L.runic_protector,
		[369411] = L.cavern_seeker,
		[381593] = L.ebonstone_golem,
		[382578] = L.earthen_guardian,
		[377500] = L.infinite_agent,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterMessage("BigWigs_OnBossWin")
	self:Log("SPELL_AURA_APPLIED", "LostTomeOfTyr", 386104)
	self:Log("SPELL_AURA_APPLIED", "TimeLock", 375500)
	self:Log("SPELL_CAST_SUCCESS", "TemporalTheft", 382264)

	-- Hulking Berserker
	self:Log("SPELL_CAST_START", "BrutalSlam", 369811)

	-- Stonevault Geomancer
	self:Log("SPELL_CAST_START", "ChainLightning", 369675)

	-- Vicious Basilisk
	self:Log("SPELL_CAST_START", "SpikedCarapace", 369823)
	self:Log("SPELL_AURA_APPLIED", "SpikedCarapaceApplied", 369823)

	-- Refti Custodian
	self:Log("SPELL_CAST_START", "JaggedBite", 377732)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AncientPowerApplied", 377738)
	self:Log("SPELL_AURA_APPLIED", "SystemicVulnerabilityApplied", 377724)

	-- Earthen Custodian
	self:Log("SPELL_CAST_START", "Cleave", 369409)
	self:Log("SPELL_DAMAGE", "CleaveDamage", 369409)
	self:Log("SPELL_MISSED", "CleaveDamage", 369409)

	-- Earthen Weaver
	self:Log("SPELL_CAST_START", "HailOfStone", 369465)

	-- Earthen Warder
	self:Log("SPELL_CAST_START", "EarthenWard", 369400)
	self:Log("SPELL_AURA_APPLIED", "EarthenWardApplied", 369400)
	self:Log("SPELL_CAST_START", "CurseOfStone", 369365)
	self:Log("SPELL_AURA_APPLIED", "CurseOfStoneApplied", 369365)
	self:Log("SPELL_AURA_APPLIED", "TrappedInStoneApplied", 369366)

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

function mod:BigWigs_OnBossWin(event, module)
	if module:GetJournalID() == 2479 then -- Chrono-Lord Deios
		-- disable the trash module when defeating the last boss, this avoids some
		-- spam from LostTomeofTyr when someone leaves the group.
		self:Disable()
	end
end

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
			if not self:MythicPlus() then
				-- the RP starts automatically in Mythic+ and Time Lock ends when the RP ends
				self:Bar(args.spellId, 22.1)
			end
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

-- Stonevault Geomancer

do
	local prev = 0
	function mod:ChainLightning(args)
		if self:MobId(args.sourceGUID) == 184022 then -- Stonevault Geomancer (trash version)
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "red", CL.casting:format(args.spellName))
				self:PlaySound(args.spellId, "alert")
			end
			--self:NameplateCDBar(args.spellId, 25.0, args.sourceGUID)
		end
	end
end

-- Vicious Basilisk

do
	local prev = 0
	function mod:SpikedCarapace(args)
		local t = args.time
		if t - prev > 1.5 then
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
			if t - prev > 2 then
				prev = t
				self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

-- Refti Custodian

do
	local prev = 0
	function mod:JaggedBite(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 13.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:AncientPowerApplied(args)
		local t = args.time
		-- throttle because there can be more than one and they start in sync
		if args.amount >= 3 and args.amount % 2 == 1 and t - prev > 1.5 then -- 3, 5, 7, ...
			prev = t
			self:StackMessage(args.spellId, "yellow", args.destName, args.amount, 6)
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:SystemicVulnerabilityApplied(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "green")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Earthen Custodian

do
	local prev = 0
	function mod:Cleave(args)
		-- trivial damage for tanks, deadly for others
		if not self:Tank() then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "purple")
			end
			--self:NameplateCDBar(args.spellId, 15.0, args.sourceGUID)
		end
	end
end

do
	local prev = 0
	function mod:CleaveDamage(args)
		-- trivial damage for tanks, deadly for others
		if not self:Tank() and self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "alarm")
			end
		end
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
			self:PlaySound(args.spellId, "info")
		end
		--self:NameplateCDBar(args.spellId, 21.7, args.sourceGUID)
	end
end

-- Earthen Warder

do
	local prev = 0
	function mod:EarthenWard(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 32.6, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:EarthenWardApplied(args)
		local t = args.time
		if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) and t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
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
		self:Say(args.spellId, nil, nil, "Trapped in Stone")
	end
end

-- Runic Protector

function mod:FissuringSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 9.7, args.sourceGUID)
end

do
	local prev = 0
	function mod:DifficultTerrainApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
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
