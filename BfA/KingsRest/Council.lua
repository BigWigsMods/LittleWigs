
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Council of Tribes", 1762, 2170)
if not mod then return end
mod:RegisterEnableMob(135472, 135475, 135470) -- Zanazal the Wise, Kula the Butcher, Aka'ali the Conqueror
mod.engageId = 2140

--------------------------------------------------------------------------------
-- Locals
--

local stage = 0
local bossOrder = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Kula the Butcher
		266206, -- Whirling Axes
		266231, -- Severing Axe
		-- Aka'ali the Conqueror
		{266951, "SAY", "SAY_COUNTDOWN"}, -- Barrel Through
		{266237, "TANK"}, -- Debilitating Backhand
		-- Zanazal the Wise
		267273, -- Poison Nova
		267060, -- Call of the Elements
	}, {
		[266206] = -18261, -- Kula the Butcher
		[266951] = -18264, -- Aka'ali the Conqueror
		[267273] = -18267, -- Zanazal the Wise
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Barrel Through
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_START", "PoisonNova", 267273)
	self:Log("SPELL_CAST_START", "CalloftheElements", 267060)

	self:Log("SPELL_CAST_START", "WhirlingAxes", 266206)
	self:Log("SPELL_CAST_SUCCESS", "SeveringAxeSuccess", 266231)
	self:Log("SPELL_AURA_APPLIED", "SeveringAxeApplied", 266231)

	self:Log("SPELL_CAST_START", "DebilitatingBackhand", 266237)

	self:Death("BossDeath", 135475, 135470, 135472) -- Kula the Butcher, Aka'ali the Conqueror, Zanazal the Wise
end

function mod:OnEngage()
	stage = 0
	bossOrder = {}
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	-- This event will fire when totems spawn, so only run for each boss once
	local mobId = self:MobId(UnitGUID("boss1"))
	if not tContains(bossOrder, mobId) then
		stage = stage + 1
		bossOrder[stage] = mobId
		-- Start timers
		if mobId == 135475 then -- Kula the Butcher
			self:Bar(266206, 8) -- Whirling Axes
			self:Bar(266231, 24) -- Severing Axe
		elseif mobId == 135470 then -- Aka'ali the Conqueror
			self:Bar(266951, 5.5) -- Barrel Through
		elseif mobId == 135472 then -- Zanazal the Wise
			self:Bar(267273, 16) -- Poison Nova
			self:Bar(267060, 20) -- Call of the Elements
		end
	end
end

do
	local function startTimer(mobId, time)
		if mobId == 135475 then -- Kula the Butcher
			mod:Bar(266206, time) -- Whirling Axes
		elseif mobId == 135470 then -- Aka'ali the Conqueror
			mod:Bar(266951, time) -- Barrel Through
		elseif mobId == 135472 then -- Zanazal the Wise
			mod:Bar(267273, time) -- Poison Nova
		end
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 34098 then -- ClearAllDebuffs (boss death)
			local mobId = self:MobId(UnitGUID(unit))
			-- Stop timers
			if mobId == 135475 then -- Kula the Butcher
				local whirlingAxesTime = self:BarTimeLeft(266206)
				self:StopBar(266206) -- Whirling Axes
				self:StopBar(266231) -- Severing Axe
			elseif mobId == 135470 then -- Aka'ali the Conqueror
				self:StopBar(266951) -- Barrel Through
				self:StopSayCountdown(266951) -- Barrel Through
				self:StopBar(266237) -- Debilitating Backhan
			elseif mobId == 135472 then -- Zanazal the Wise
				self:StopBar(267273) -- Poison Nova
				self:StopBar(267060) -- Call of the Elements
			end
			if stage < 3 then
				-- The first boss's ability is used 23 sec after any death.
				-- The second boss's ability is used 55 sec after its death.
				startTimer(bossOrder[1], 23)
				if bossOrder[2] then
					startTimer(bossOrder[2], 55)
				end
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("266951") then -- Barrel Through
		self:TargetMessage2(266951, "red", destName)
		self:PlaySound(266951, "warning", nil, destName)
		local guid = UnitGUID(destName)
		if self:Me(guid) then
			self:Say(266951)
			self:SayCountdown(266951, 8)
		end
		local mobId = self:MobId(UnitGUID("boss1"))
		if mobId == 135470 then -- Aka'ali the Conqueror
			self:Bar(266951, 23.1) -- Barrel Through
			self:Bar(266237, 9) -- Debilitating Backhand
		else
			self:Bar(266951, 51) -- Barrel Through
		end
	end
end

function mod:PoisonNova(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	local mobId = self:MobId(UnitGUID("boss1"))
	self:CDBar(args.spellId, (mobId == 135472) and 29.2 or 51) -- Zanazal the Wise
end

function mod:CalloftheElements(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 53.5)
end

function mod:WhirlingAxes(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	local mobId = self:MobId(UnitGUID("boss1"))
	self:CDBar(args.spellId, (mobId == 135475) and 10.9 or 50) -- Kula the Butcher
end

function mod:SeveringAxeSuccess(args)
	self:CDBar(args.spellId, 21.9)
end

function mod:SeveringAxeApplied(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:DebilitatingBackhand(args)
	self:Message2(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end
