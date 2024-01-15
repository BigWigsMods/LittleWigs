
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Council of Tribes", 1762, 2170)
if not mod then return end
mod:RegisterEnableMob(135475, 135470, 135472) -- Kula the Butcher, Aka'ali the Conqueror, Zanazal the Wise
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
end

function mod:OnEngage()
	stage = 0
	bossOrder = {}
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	-- IEEU engages the boss module, so the first time the event fires, it is not yet registered here.
	self:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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

	function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		-- IEEU fires on living boss spawn and death
		-- mobId will be nil if the boss died
		local guid = self:UnitGUID("boss1")
		if guid then -- Boss spawned
			stage = stage + 1
			local mobId = self:MobId(guid)
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

			if stage == 2 or stage == 3 then
				self:Message("stages", "cyan", CL.stage:format(stage), false)
				self:PlaySound("stages", "long")
				-- The dead bosses use their abilities a number of seconds after the current living one spawns
				startTimer(bossOrder[1], 15.8)
				if stage == 3 then
					startTimer(bossOrder[2], 48.1)
				end
			end
		else -- Boss killed
			-- Kula the Butcher
			self:StopBar(266231) -- Severing Axe
			self:StopBar(266206) -- Whirling Axes
			-- Aka'ali the Conqueror
			self:StopBar(266951) -- Barrel Through
			self:CancelSayCountdown(266951) -- Barrel Through
			self:StopBar(266237) -- Debilitating Backhan
			-- Zanazal the Wise
			self:StopBar(267060) -- Call of the Elements
			self:StopBar(267273) -- Poison Nova
			if stage == 1 or stage == 2 then
				self:Bar("stages", 6, CL.stage:format(stage + 1), "achievement_dungeon_kingsrest")
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("266951") then -- Barrel Through
		self:TargetMessage(266951, "red", destName)
		self:PlaySound(266951, "warning", nil, destName)
		local guid = self:UnitGUID(destName)
		if self:Me(guid) then
			self:Say(266951, nil, nil, "Barrel Through")
			self:SayCountdown(266951, 8)
		end
		local mobId = self:MobId(self:UnitGUID("boss1"))
		if mobId == 135470 then -- Aka'ali the Conqueror
			self:Bar(266951, 23.1) -- Barrel Through
			self:Bar(266237, 9) -- Debilitating Backhand
		else
			self:Bar(266951, 51) -- Barrel Through
		end
	end
end

function mod:PoisonNova(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	local mobId = self:MobId(self:UnitGUID("boss1"))
	self:Bar(args.spellId, mobId == 135472 and 29.2 or 51) -- Zanazal the Wise
end

function mod:CalloftheElements(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 53.5) -- Can be delayed if the boss is casting Poison Nova
end

function mod:WhirlingAxes(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	local mobId = self:MobId(self:UnitGUID("boss1"))
	self:Bar(args.spellId, mobId == 135475 and 10.9 or 50) -- Kula the Butcher
end

function mod:SeveringAxeSuccess(args)
	self:Bar(args.spellId, 21.9)
end

function mod:SeveringAxeApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:DebilitatingBackhand(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end
