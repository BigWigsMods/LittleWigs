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
	162040, -- Grand Overseer
	171376, -- Head Custodian Javlin
	162047, -- Insatiable Brute
	166396, -- Noble Skirmisher
	162038, -- Regal Mistdancer
	171805, -- Research Scribe
	162039, -- Wicked Oppressor
	168591, -- Ravenous Dreadbat
	162133, -- General Kaal (trash)
	162099 -- General Kaal (boss)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kaal_engage_trigger1 = "Guards! Slay them all!"
	L.kaal_engage_trigger2 = "That prisoner belongs to the Master. You will not take it!"
	L.kaal_engage_trigger3 = "These halls will be your tomb!"
	L.kaal_retreat_trigger1 = "Wretched mortals!"
	L.kaal_retreat_trigger2 = "You are nothing but Draven's dogs!"
	L.kaal_retreat_trigger3 = "Stubborn rebels. You will meet your end!"
	L.anima_collector = "Anima Collector"
	L.chamber_sentinel = "Chamber Sentinel"
	L.depths_warden = "Depths Warden"
	L.dreadful_huntmaster = "Dreadful Huntmaster"
	L.grand_overseer = "Grand Overseer"
	L.head_custodian_javlin = "Head Custodian Javlin"
	L.insatiable_brute = "Insatiable Brute"
	L.regal_mistdancer = "Regal Mistdancer"
	L.research_scribe = "Research Scribe"
	L.wicked_oppressor = "Wicked Oppressor"
	L.ravenous_dreadbat = "Ravenous Dreadbat"
	L.zrali = "Z'rali"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Anima Collector
		341331, -- Anima Drain
		-- Chamber Sentinel
		328170, -- Craggy Fracture
		{322429, "TANK_HEALER"}, -- Severing Slice
		322433, -- Stoneskin
		-- Depths Warden
		335305, -- Barbed Shackles
		{335308, "TANK_HEALER"}, -- Crushing Strike
		-- Dreadful Huntmaster
		334558, -- Volatile Trap
		-- Grand Overseer
		326827, -- Dread Bindings
		-- Head Custodian Javlin
		334329, -- Sweeping Slash
		{334326, "TANK_HEALER"}, -- Bludgeoning Bash
		-- Insatiable Brute
		{321178, "TANK"}, -- Slam
		334918, -- Umbral Crash
		-- Regal Mistdancer
		320991, -- Echoing Thrust
		-- Research Scribe
		334377, -- Explosive Vellum
		-- Wicked Oppressor
		{326836, "DISPEL"}, -- Curse of Suppression
		-- Ravenous Dreadbat
		321105, -- Sap Lifeblood
		-- Z'rali
		324089, -- Z'rali's Essence
		324086, -- Shining Radiance
	}, {
		[341331] = L.anima_collector,
		[328170] = L.chamber_sentinel,
		[335305] = L.depths_warden,
		[334558] = L.dreadful_huntmaster,
		[326827] = L.grand_overseer,
		[334329] = L.head_custodian_javlin,
		[321178] = L.insatiable_brute,
		[320991] = L.regal_mistdancer,
		[334377] = L.research_scribe,
		[326836] = L.wicked_oppressor,
		[321105] = L.ravenous_dreadbat,
		[324089] = L.zrali
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
	-- Ravenous Dreadbat
	self:Log("SPELL_CAST_START", "SapLifeblood", 321105) -- Sap Lifeblood
	-- General Kaal
	self:RegisterEvent("CHAT_MSG_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	-- Z'rali
	self:Log("SPELL_AURA_APPLIED", "ZralisEssenceApplied", 324089) -- Z'rali's Essence
	self:Log("SPELL_AURA_REMOVED", "ZralisEssenceRemoved", 324089) -- Z'rali's Essence
	self:Log("SPELL_CAST_SUCCESS", "ShiningRadiance", 324086) -- Shining Radiance
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Anima Collector

function mod:SummonAnimaCollectorStalker(args)
	self:Message(341331, "green", L.anima_collector) -- Anima Drain
	self:PlaySound(341331, "info") -- Anima Drain
	self:Bar(341331, 60, L.anima_collector) -- Anima Drain
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
	local canInterrupt, interruptReady = self:Interrupter()

	if canInterrupt then
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		if interruptReady then
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:StoneskinApplied(args)
	if not self:Player(args.destFlags) and self:Dispeller("magic", true) then
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
	if self:Dispeller("movement") or self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(335305, "yellow", args.destName)
		self:PlaySound(335305, "alert", nil, args.destName)
	end
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

-- Ravenous Dreadbat

function mod:SapLifeblood(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Z'rali

function mod:ZralisEssenceApplied(args)
	self:Message(args.spellId, "green", CL.on:format(args.spellName, self:ColorName(args.destName)))
	self:PlaySound(args.spellId, "info")
end

function mod:ZralisEssenceRemoved(args)
	self:Message(args.spellId, "green", CL.removed_from:format(args.spellName, self:ColorName(args.destName)))
	self:PlaySound(args.spellId, "info")
end

function mod:ShiningRadiance(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

-- General Kaal Gauntlet Event

function mod:CHAT_MSG_YELL(_, msg, playerName)
	-- General Kaal in the gauntlet event is bugged and uses the CHAT_MSG_YELL event for half of her lines and
	-- the correct CHAT_MSG_MONSTER_YELL for the other half.
	-- playerName will be an empty string for these bugged lines so pass them through to the MONSTER_YELL handler.
	if playerName == "" then
		self:CHAT_MSG_MONSTER_YELL(nil, msg)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.kaal_engage_trigger1 or msg == L.kaal_engage_trigger2 or msg == L.kaal_engage_trigger3 then
		local kaalModule = BigWigs:GetBossModule("General Kaal", true)
		if kaalModule then
			kaalModule:Enable()
			kaalModule:KaalGauntletEngage()
		end
	elseif msg == L.kaal_retreat_trigger1 or msg == L.kaal_retreat_trigger2 or msg == L.kaal_retreat_trigger3 then
		local kaalModule = BigWigs:GetBossModule("General Kaal", true)
		if kaalModule then
			kaalModule:Enable()
			kaalModule:KaalGauntletRetreat()
		end

		-- The gauntlet event is over once the third retreat line has triggered
		if msg == L.kaal_retreat_trigger3 then
			self:UnregisterEvent("CHAT_MSG_YELL")
			self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		end
	end
end
