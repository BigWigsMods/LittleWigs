
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sanguine Depths Trash", 2284)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	174001, -- Anima Collector
	162057, -- Chamber Sentinel
	171799, -- Depths Warden
	171448, -- Dreadful Huntmaster
	162046, -- Famished Tick
	162133, -- General Kaal
	162040, -- Grand Overseer
	171376, -- Head Custodian Javlin
	162047, -- Insatiable Brute
	166396, -- Noble Skirmisher
	162038, -- Regal Mistdancer
	171805, -- Research Scribe
	162039 -- Wicked Oppressor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.anima_collector = "Anima Collector"
	L.chamber_sentinel = "Chamber Sentinel"
	L.depths_warden = "Depths Warden"
	L.dreadful_huntmaster = "Dreadful Huntmaster"
	L.general_kaal = "General Kaal"
	L.grand_overseer = "Grand Overseer"
	L.head_custodian_javlin = "Head Custodian Javlin"
	L.insatiable_brute = "Insatiable Brute"
	L.regal_mistdancer = "Regal Mistdancer"
	L.research_scribe = "Research Scribe"
	L.wicked_oppressor = "Wicked Oppressor"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Anima Collector
		341321, -- Summon Anima Collector Stalker
		-- Chamber Sentinel
		328170, -- Craggy Fracture
		322429, -- Severing Slice
		322433, -- Stoneskin
		-- Depths Warden
		335305, -- Barbed Shackles
		{335308, "TANK_HEALER"}, -- Crushing Strike
		-- Dreadful Huntmaster
		334558, -- Volatile Trap
		-- General Kaal
		324103, -- Gloom Squall
		324086, -- Shining Radiance
		-- Grand Overseer
		326827, -- Dread Bindings
		-- Head Custodian Javlin
		334329, -- Sweeping Slash
		{334326, "TANK_HEALER"}, -- Bludgeoning Bash
		-- Insatiable Brute
		{321178, "TANK_HEALER"}, -- Slam
		334918, -- Umbral Crash
		-- Regal Mistdancer
		320991, -- Echoing Thrust
		-- Research Scribe
		334377, -- Explosive Vellum
		-- Wicked Oppressor
		{326836, "DISPEL"}, -- Curse of Suppression
	}, {
		[341321] = L.anima_collector,
		[328170] = L.chamber_sentinel,
		[335305] = L.depths_warden,
		[334558] = L.dreadful_huntmaster,
		[324103] = L.general_kaal,
		[326827] = L.grand_overseer,
		[334329] = L.head_custodian_javlin,
		[321178] = L.insatiable_brute,
		[320991] = L.regal_mistdancer,
		[334377] = L.research_scribe,
		[326836] = L.wicked_oppressor,
	}
end

function mod:OnBossEnable()
		-- Anima Container
		self:Log("SPELL_SUMMON", "SummonAnimaCollectorStalker", 341321)
		-- Chamber Sentinel
		self:Log("SPELL_CAST_START", "CraggyFracture", 328170) -- Craggy Fracture
		self:Log("SPELL_CAST_START", "SeveringSlice", 322429) -- Severing Slice
		self:Log("SPELL_CAST_START", "Stoneskin", 322433) -- Stoneskin
		self:Log("SPELL_AURA_APPLIED", "StoneskinApplied", 322433) -- Stoneskin
		-- Depths Warden
		self:Log("SPELL_CAST_START", "BarbedShackles", 335305) -- Barbed Shackles
		self:Log("SPELL_AURA_APPLIED", "BarbedShacklesApplied", 335306) -- Barbed Shackles
		self:Log("SPELL_CAST_START", "CrushingStrike", 335308) -- Crushing Strike
		-- Dreadful Huntmaster
		self:Log("SPELL_CAST_SUCCESS", "VolatileTrap", 334558) -- Volatile Trap
		-- General Kaal
		self:Log("SPELL_CAST_START", "GloomSquall", 324103) -- Gloom Squall
		self:Log("SPELL_CAST_SUCCESS", "ShiningRadiance", 324086) -- Shining Radiance
		-- Grand Overseer
		self:Log("SPELL_CAST_START", "DreadBindings", 326827) -- Dread Bindings
		self:Log("SPELL_AURA_REMOVED", "DreadBindingsRemoved", 326827)
		-- Head Custodian Javlin
		self:Log("SPELL_CAST_START", "SweepingSlash", 334329) -- Sweeping Slash
		self:Log("SPELL_CAST_START", "BludgeoningBash", 334326) -- Bludgeoning Bash
		-- Insatiable Brute
		self:Log("SPELL_CAST_START", "Slam", 321178) -- Slam
		self:Log("SPELL_CAST_START", "UmbralCrash", 334918) -- Umbral Crash
		-- Regal Mistdancer
		self:Log("SPELL_CAST_START", "EchoingThrust", 320991) -- Echoing Thrust
		-- Research Scribe
		self:Log("SPELL_CAST_SUCCESS", "ExplosiveVellum", 334377) -- Explosive Vellum
		-- Wicked Oppressor
		self:Log("SPELL_CAST_START", "CurseOfSuppression", 326836) -- Curse of Suppression
		self:Log("SPELL_AURA_APPLIED", "CurseOfSuppressionApplied", 326836) -- Curse of Suppression
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Anima Collector

function mod:SummonAnimaCollectorStalker(args)
	self:Message(args.spellId, "green", L.anima_collector)
	self:PlaySound(args.spellId, "info")
end

-- Chamber Sentinel

function mod:CraggyFracture(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SeveringSlice(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Stoneskin(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:StoneskinApplied(args)
	if bit.band(args.destFlags, 0x400) == 0 then -- COMBATLOG_OBJECT_TYPE_PLAYER
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Depths Warden

function mod:BarbedShackles(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:BarbedShacklesApplied(args)
	self:TargetMessage(335305, "yellow", args.destName)
	self:PlaySound(335305, "alert", nil, args.destName)
end

function mod:CrushingStrike(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Dreadful Huntmaster

do
	local prev = 0
	function mod:VolatileTrap(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- General Kaal

function mod:GloomSquall(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:ShiningRadiance(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

-- Grand Overseer

function mod:DreadBindings(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:DreadBindingsRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Head Custodian Javlin

function mod:SweepingSlash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:BludgeoningBash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Insatiable Brute

function mod:Slam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:UmbralCrash(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Regal Mistdancer

do
	local prev = 0
	function mod:EchoingThrust(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Research Scribe

do
	local prev = 0
	function mod:ExplosiveVellum(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Wicked Oppressor

do
	local prev = 0
	function mod:CurseOfSuppression(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:CurseOfSuppressionApplied(args)
	if self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end
