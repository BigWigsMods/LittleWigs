--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Uldaman: Legacy of Tyr Trash", 2451)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	184020, -- Hulking Berserker
	184023, -- Vicious Basilisk
	184132, -- Earthen Warder
	186420, -- Earthen Weaver
	184301, -- Cavern Seeker
	184107, -- Runic Protector
	184300  -- Ebonstone Golem
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
	L.cavern_seeker = "Cavern Seeker"
	L.runic_protector = "Runic Protector"
	L.ebonstone_golem = "Ebonstone Golem"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Hulking Berserker
		369811, -- Brutal Slam
		-- Vicious Basilisk
		{369823, "DISPEL"}, -- Spiked Carapace
		-- Earthen Warder
		{369400, "DISPEL"}, -- Earthen Ward
		{369365, "DISPEL"}, -- Curse of Stone
		{369366, "DISPEL"}, -- Trapped in Stone
		-- Earthen Weaver
		369465, -- Hail of Stone
		-- Cavern Seeker
		369411, -- Sonic Burst
		-- Runic Protector
		369337, -- Difficult Terrain
		-- Ebonstone Golem
		381593, -- Thunderous Clap
	}, {
		[369811] = L.hulking_berserker,
		[369823] = L.vicious_basilisk,
		[369400] = L.earthen_warder,
		[369465] = L.earthen_weaver,
		[369411] = L.cavern_seeker,
		[369337] = L.runic_protector,
		[381593] = L.ebonstone_golem,
	}
end

function mod:OnBossEnable()
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
	self:Log("SPELL_CAST_SUCCESS", "HailOfStone", 369465)

	-- Cavern Seeker
	self:Log("SPELL_CAST_START", "SonicBurst", 369411)

	-- Runic Protector
	self:Log("SPELL_AURA_APPLIED", "DifficultTerrainApplied", 369337)

	-- Runic Protector
	self:Log("SPELL_CAST_START", "ThunderousClap", 381593)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
end

function mod:EarthenWardApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:CurseOfStone(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:CurseOfStoneApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:TrappedInStoneApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

-- Earthen Weaver

function mod:HailOfStone(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Cavern Seeker

do
	local prev = 0
	function mod:SonicBurst(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Runic Protector

function mod:DifficultTerrainApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

-- Ebonstone Golem

do
	local prev = 0
	function mod:ThunderousClap(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
