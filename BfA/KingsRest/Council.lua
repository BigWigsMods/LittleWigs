
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

local stage = 1

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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Log("SPELL_CAST_START", "PoisonNova", 267273)
	self:Log("SPELL_CAST_START", "CalloftheElements", 267060)

	self:Log("SPELL_CAST_START", "WhirlingAxes", 266206)
	self:Log("SPELL_CAST_SUCCESS", "SeveringAxeSuccess", 266231)
	self:Log("SPELL_AURA_APPLIED", "SeveringAxeApplied", 266231)

	self:Log("SPELL_CAST_START", "DebilitatingBackhand", 266237)
end

function mod:OnEngage()
	stage = 1
	self:CDBar(267273, 10.5) -- Poison Nova
	self:CDBar(267060, 21.5) -- Call of the Elements
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("266951") then -- Barrel Through
		self:TargetMessage2(266951, "red", destName)
		self:PlaySound(266951, "warning", nil, destName)
		local guid = UnitGUID(destName)
		if self:Me(guid) then
			self:Say(266951)
			self:SayCountdown(266951, 8)
		end
		self:Bar(266951, 23.5)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 34098 then -- ClearAllDebuffs // Stage Change
		self:StopBar(267273) -- Poison Nova
		self:StopBar(267060) -- Call of the Elements
		self:StopBar(266206) -- Whirling Axes
		self:StopBar(266231) -- Severing Axe
		-- XXX Roleplay timer
		-- XXX Killed Message?
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if stage > 2 and self:MobId(UnitGUID(unit)) == 135475 then -- Kula the Butcher
		if UnitCanAttack("player", unit) then
			stage = 2
			self:Message2("stages", "cyan", CL.stage:format(stage), false)
			self:PlaySound("stages", "long")
			self:CDBar(266206, 8) -- Whirling Axes
			self:CDBar(266231, 24) -- Severing Axe
		end
	elseif stage > 3 and self:MobId(UnitGUID(unit)) == 135470 then -- Aka'ali the Conqueror
		if UnitCanAttack("player", unit) then
			stage = 3
			self:Message2("stages", "cyan", CL.stage:format(stage), false)
			self:PlaySound("stages", "long")
			self:CDBar(266951, 5.5) -- Barrel Through
			self:CDBar(266237, 14) -- Debilitating Backhand
		end
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
	--self:CDBar(args.spellId, 13)
end

function mod:WhirlingAxes(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 10.5)
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
	self:CDBar(args.spellId, 24)
end
