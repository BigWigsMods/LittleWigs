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
	184301  -- Cavern Seeker
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hulking_berserker = "Hulking Berserker"
	L.vicious_basilisk = "Vicious Basilisk"
	L.earthen_warder = "Earthen Warder"
	L.cavern_seeker = "Cavern Seeker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Hulking Berserker
		369811, -- Brutal Slam
		-- Vicious Basilisk
		369823, -- Spiked Carapace
		-- Earthen Warder
		{369400, "DISPEL"}, -- Earthen Ward
		{369365, "DISPEL"}, -- Curse of Stone
		{369366, "DISPEL"}, -- Trapped in Stone
		-- Cavern Seeker
		369411, -- Sonic Burst
	}, {
		[369811] = L.hulking_berserker,
		[369411] = L.cavern_seeker,
		[369823] = L.cavern_seeker,
	}
end

function mod:OnBossEnable()
	-- Hulking Berserker
	self:Log("SPELL_CAST_START", "BrutalSlam", 369811)

	-- Vicious Basilisk
	self:Log("SPELL_CAST_START", "SpikedCarapace", 369823)

	-- Earthen Warder
	self:Log("SPELL_CAST_START", "EarthenWard", 369400)
	self:Log("SPELL_AURA_APPLIED", "EarthenWardApplied", 369400)
	self:Log("SPELL_CAST_START", "CurseOfStone", 369365)
	self:Log("SPELL_AURA_APPLIED", "CurseOfStoneApplied", 369365)
	self:Log("SPELL_AURA_APPLIED", "TrappedInStoneApplied", 369366)

	-- Cavern Seeker
	self:Log("SPELL_CAST_START", "SonicBurst", 369411)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hulking Berserker

function mod:BrutalSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Vicious Basilisk

function mod:SpikedCarapace(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
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
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:TrappedInStoneApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning")
	end
end

-- Cavern Seeker

function mod:SonicBurst(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end
