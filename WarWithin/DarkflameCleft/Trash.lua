if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkflame Cleft Trash", 2651)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	211121, -- Rank Overseer
	210818, -- Lowly Moleherd
	208450, -- Wandering Candle
	220815, -- Blazing Fiend
	223774, -- Blazing Fiend
	223775, -- Blazing Fiend
	223777, -- Blazing Fiend
	212412, -- Sootsnout
	212411, -- Torchsnarl
	208456 -- Shuffling Horror
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rank_overseer = "Rank Overseer"
	L.lowly_moleherd = "Lowly Moleherd"
	L.wandering_candle = "Wandering Candle"
	L.blazing_fiend = "Blazing Fiend"
	L.sootsnout = "Sootsnout"
	L.torchsnarl = "Torchsnarl"
	L.shuffling_horror = "Shuffling Horror"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Rank Overseer
		423501, -- Wild Wallop
		-- Lowly Moleherd
		425536, -- Mole Frenzy
		-- Wandering Candle
		440652, -- Surging Wax
		-- Blazing Fiend
		424322, -- Explosive Flame
		-- Sootsnout
		426261, -- Ceaseless Flame
		426295, -- Flaming Tether
		-- Torchsnarl
		426619, -- One-Hand Headlock
		426260, -- Pyro-pummel
		-- Shuffling Horror
		422414, -- Shadow Smash
		422541, -- Drain Light
	}, {
		[423501] = L.rank_overseer,
		[425536] = L.lowly_moleherd,
		[440652] = L.wandering_candle,
		[424322] = L.blazing_fiend,
		[426261] = L.sootsnout,
		[426619] = L.torchsnarl,
		[422414] = L.shuffling_horror,
	}
end

function mod:OnBossEnable()
	-- Rank Overseer
	self:Log("SPELL_CAST_START", "WildWallop", 423501)

	-- Lowly Moleherd
	self:Log("SPELL_CAST_START", "MoleFrenzy", 425536)

	-- Wandering Candle
	self:Log("SPELL_CAST_START", "SurgingWax", 440652)

	-- Blazing Fiend
	self:Log("SPELL_CAST_START", "ExplosiveFlame", 424322)

	-- Sootsnout
	self:Log("SPELL_CAST_START", "CeaselessFlame", 426261)
	self:Log("SPELL_CAST_START", "FlamingTether", 426295)
	self:Death("SootsnoutDeath", 212412)

	-- Torchsnarl
	self:Log("SPELL_CAST_START", "OneHandHeadlock", 426619)
	self:Log("SPELL_CAST_START", "Pyropummel", 426260)
	self:Death("TorchsnarlDeath", 212411)

	-- Shuffling Horror
	self:Log("SPELL_CAST_START", "ShadowSmash", 422414)
	self:Log("SPELL_CAST_START", "DrainLight", 422541)

	-- TODO Creaky Mine Cart minigame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Rank Overseer

function mod:WildWallop(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Lowly Moleherd

do
	local prev = 0
	function mod:MoleFrenzy(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Wandering Candle

function mod:SurgingWax(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Blazing Fiend

function mod:ExplosiveFlame(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Sootsnout

do
	local timer

	function mod:CeaselessFlame(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 35.7)
		timer = self:ScheduleTimer("SootsnoutDeath", 30)
	end

	function mod:FlamingTether(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 38.9)
		timer = self:ScheduleTimer("SootsnoutDeath", 30)
	end

	function mod:SootsnoutDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(426261) -- Ceaseless Flame
		self:StopBar(426295) -- Flaming Tether
	end
end

-- Torchsnarl

do
	local timer

	function mod:OneHandHeadlock(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		if self:Tank() then
			-- spell description says random enemy but actually only targets the tank
			self:PlaySound(args.spellId, "alarm")
		end
		self:CDBar(args.spellId, 36.4)
		timer = self:ScheduleTimer("TorchsnarlDeath", 30)
	end

	function mod:Pyropummel(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		--self:CDBar(args.spellId, 38.9) TODO unknown CD
		timer = self:ScheduleTimer("TorchsnarlDeath", 30)
	end

	function mod:TorchsnarlDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(426619) -- One-Hand Headlock
		--self:StopBar(426260) -- Pyro-pummel TODO uncomment when bar added
	end
end

-- Shuffling Horror

function mod:ShadowSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:DrainLight(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end
