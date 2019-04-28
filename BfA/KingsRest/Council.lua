
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
local bossStages = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
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

	self:Log("SPELL_CAST_START", "PoisonNova", 267273)
	self:Log("SPELL_CAST_START", "CalloftheElements", 267060)

	self:Log("SPELL_CAST_START", "WhirlingAxes", 266206)
	self:Log("SPELL_CAST_SUCCESS", "SeveringAxeSuccess", 266231)
	self:Log("SPELL_AURA_APPLIED", "SeveringAxeApplied", 266231)

	self:Log("SPELL_CAST_START", "DebilitatingBackhand", 266237)

	self:Death("BossDeath", 135475, 135470, 135472) -- Kula the Butcher, Aka'ali the Conqueror, Zanazal the Wise
end

function mod:OnEngage()
	bossStages = {}
	stage = 0
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local mobId = self:MobId(UnitGUID("boss1"))
	if not bossStages[mobId] then
		stage = stage + 1
		bossStages[mobId] = stage
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

function mod:BossDeath(args)
	local mobId = self:MobId(args.destGUID)
	-- Stop timers
	if mobId == 135475 then -- Kula the Butcher
		self:StopBar(266206) -- Whirling Axes XXX add timer while boss is not active
		self:StopBar(266231) -- Severing Axe
	elseif mobId == 135470 then -- Aka'ali the Conqueror
		self:StopBar(266951) -- Barrel Through XXX add timer while boss is not active
		self:StopSayCountdown(266951) -- Barrel Through
		self:StopBar(266237) -- Debilitating Backhan
	elseif mobId == 135472 then -- Zanazal the Wise
		self:StopBar(267273) -- Poison Nova XXX add timer while boss is not active
		self:StopBar(267060) -- Call of the Elements
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("266951") then -- Barrel Through
		self:TargetMessage2(266951, "red", destName)
		local guid = UnitGUID(destName)
		if self:Me(guid) then
			self:PlaySound(266951, "warning", "runaway")
			self:Say(266951)
			self:SayCountdown(266951, 8)
		end
		self:Bar(266951, 23.5) -- Barrel Through
		self:Bar(266237, 9) -- Debilitating Backhand
	end
end

function mod:PoisonNova(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26)
end

function mod:CalloftheElements(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 50) -- XXX check this
end

function mod:WhirlingAxes(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	local mobId = self:MobId(UnitGUID("boss1"))
	self:CDBar(args.spellId, mobId == 135475 and 10.5 or 50) -- Kula the Butcher
end

function mod:SeveringAxeSuccess(args)
	self:CDBar(args.spellId, 21.5)
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
