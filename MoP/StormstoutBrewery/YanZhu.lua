
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Yan-Zhu the Uncasked", 961, 670)
if not mod then return end
mod:RegisterEnableMob(59479)
mod.engageId = 1414
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextBubbleShield = 0
local addsSpawned = 0
local mobCollector = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.summon = -5654 -- Yeasty Brew Alemental
	L.summon_desc = "Warn when Yan-Zhu summons a Yeasty Brew Alemental. They can cast |cff71d5ffFerment|r to heal the boss."
	L.summon_icon = 116155 -- Brew Bolt that they spam
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{114548, "TANK"}, -- Brew Bolt
		{106546, "SAY"}, -- Bloat
		106851, -- Blackout Brew
		106563, -- Bubble Shield
		"summon",
		114451, -- Ferment
		{115003, "CASTBAR"}, -- Carbonation
		-5658, -- Wall of Suds
	}, {
		[114548] = "general",
		[106546] = -5650, -- Brewmastery: Wheat
		[106563] = -5596, -- Brewmastery: Ale
		[115003] = -5598, -- Brewmastery: Stout
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BrewBolt", 114548)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BrewBolt", 114548)
	self:Log("SPELL_CAST_SUCCESS", "Bloat", 106546) -- the debuff has travel time, so this is more reliable for CDBars
	self:Log("SPELL_AURA_APPLIED", "BloatApplied", 106546)
	self:Log("SPELL_AURA_REMOVED", "BloatRemoved", 106546)
	self:Log("SPELL_CAST_SUCCESS", "BlackoutBrew", 106851) -- the debuff has travel time, so this is more reliable for CDBars
	self:Log("SPELL_AURA_APPLIED", "BlackoutBrewApplied", 106851)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlackoutBrewApplied", 106851)
	self:Log("SPELL_CAST_START", "BrewBoltAdds", 116155)
	self:Log("SPELL_HEAL", "Ferment", 114451)
	self:Log("SPELL_AURA_APPLIED", "BubbleShield", 106563)
	self:Log("SPELL_AURA_REMOVED", "BubbleShieldRemoved", 106563)
	self:Log("SPELL_CAST_START", "Carbonation", 115003)

	self:Death("AddDeath", 59494)
end

function mod:OnEngage()
	addsSpawned = 0
	mobCollector = {}

	self:StartTimers()
end

function mod:OnBossDisable()
	mobCollector = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	-- there are no SPELL_CAST_* and UNIT_SPELLCAST_* events for this mechanic
	-- fortunately, it consistently happens every 30 seconds
	local function warnForWallOfSuds(self)
		self:MessageOld(-5658, "red", "long", CL.incoming:format(self:SpellName(-5658)))
		self:CDBar(-5658, 30)
		self:ScheduleTimer(warnForWallOfSuds, 30, self)
	end

	function mod:StartTimers()
		-- There are 3 pairs of abilities
		-- Yan-Zhu can have only one from each pair
		if self:UnitBuff("boss1", 114929) then -- Bloating Brew
			self:CDBar(106546, 7.0) -- Bloat
		elseif self:UnitBuff("boss1", 114930) then -- Blackout Brew
			self:CDBar(106851, 6.6) -- Blackout Brew
		end

		if self:UnitBuff("boss1", 114931) then -- Bubbling Brew
			self:CDBar(106563, 22.1) -- Bubble Shield
		elseif self:UnitBuff("boss1", 114932) then -- Yeasty Brew (Can summon Yeasty Brew Alementals)
			self:CDBar("summon", 21.8, CL.next_add, 116155)
		end

		if self:UnitBuff("boss1", 114933) then -- Sudsy Brew
			self:CDBar(-5658, 29.8) -- Wall of Suds
			self:ScheduleTimer(warnForWallOfSuds, 29.8, self)
		elseif self:UnitBuff("boss1", 114934) then -- Fizzy Brew
			self:CDBar(115003, 45.8) -- Carbonation
		end
	end
end

function mod:BrewBolt(args)
	local amount = args.amount or 1
	if amount % 2 == 1 then
		self:StackMessageOld(args.spellId, args.destName, amount, "red", "alert") -- casts when there's nobody nearby
	end
end

function mod:Bloat(args)
	self:CDBar(args.spellId, 32.5)
end

function mod:BloatApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
	self:TargetBar(args.spellId, 30, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Bloat")
	end
end

function mod:BloatRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:BlackoutBrew(args)
	self:CDBar(args.spellId, 9.7)
end

function mod:BlackoutBrewApplied(args)
	local amount = args.amount or 3 -- 1 event for every 3 stacks
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, amount, "yellow", amount > 6 and "warning" or "alarm")
	end
end

function mod:BrewBoltAdds(args)
	if not mobCollector[args.sourceGUID] then
		mobCollector[args.sourceGUID] = true
		addsSpawned = addsSpawned + 1
		self:MessageOld("summon", "cyan", nil, CL.spawned:format(self:SpellName(L.summon)), 116155)
		if addsSpawned < 5 then
			self:CDBar("summon", 18, CL.next_add, 116155) -- 18-22s
		end
	end
end

do
	local prev = 0
	function mod:Ferment(args)
		if not mobCollector[args.sourceGUID] then
			mobCollector[args.sourceGUID] = true
			addsSpawned = addsSpawned + 1
			self:MessageOld("summon", "cyan", nil, CL.spawned:format(self:SpellName(L.summon)), 116155)
			if addsSpawned < 5 then
				self:CDBar("summon", 18, CL.next_add, 116155) -- 18-22s
			end
		end
		if self:MobId(args.destGUID) == 59479 then -- players can be healed by this if they intercept the beams
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "orange", not self:UnitDebuff("player", 114451) and "warning", CL.onboss:format(args.spellName)) -- don't annoy with sounds those who are already intercepting some
			end
		end
	end
end

function mod:BubbleShield(args)
	nextBubbleShield = GetTime() + 43
	self:MessageOld(args.spellId, "orange", "alert", CL.onboss:format(args.spellName))
end

function mod:BubbleShieldRemoved(args)
	local remaining = nextBubbleShield - GetTime()
	self:MessageOld(args.spellId, "green", "info", CL.removed:format(args.spellName))
	self:CDBar(args.spellId, remaining > 2.5 and remaining or 2.5)
end

function mod:Carbonation(args)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
	self:CDBar(args.spellId, 63.3)
end

function mod:AddDeath(args)
	-- if adds die before they get to cast anything
	if not mobCollector[args.destGUID] then
		mobCollector[args.destGUID] = true
		addsSpawned = addsSpawned + 1
		if addsSpawned < 5 then
			self:CDBar("summon", 18, CL.next_add, 116155) -- 18-22s
		end
	end
end
