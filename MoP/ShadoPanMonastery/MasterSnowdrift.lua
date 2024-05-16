--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Master Snowdrift", 959, 657)
if not mod then return end
mod:RegisterEnableMob(56541)
mod:SetEncounterID(1304)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	L.stage3_yell = "was but a cub"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage 1: True Strength!
		106853, -- Fists of Fury
		106434, -- Tornado Kick
		-- Stage 2: Spiritual Power!
		106747, -- Shado-pan Mirror Image
		-- Stage 3: I Can Do So Much More!
		118961, -- Chase Down
		106454, -- Parry Stance
	}, {
		[106853] = -5435, -- Stage 1: True Strength!
		[106747] = -5438, -- Stage 2: Spiritual Power!
		[118961] = -5440, -- Stage 3: I Can Do So Much More!
	}
end

function mod:VerifyEnable(unit)
	return self:GetHealth(unit) > 15
end

function mod:OnBossEnable()
	-- Stage 1: True Strength!
	self:Log("SPELL_CAST_START", "FistsOfFury", 106853)
	self:Log("SPELL_CAST_START", "TornadoKick", 106434)

	-- Stage 2: Spiritual Power!
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	-- Stage 3: I Can Do So Much More!
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:Log("SPELL_AURA_APPLIED", "ChaseDown", 118961)
	self:Log("SPELL_AURA_REMOVED", "ChaseDownRemoved", 118961)
	self:Log("SPELL_CAST_START", "ParryStance", 106454)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(106853, 5.0) -- Fists of Fury
	self:CDBar(106434, 15.9) -- Tornado Kick
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1: True Strength!

function mod:FistsOfFury(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.9)
end

function mod:TornadoKick(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 27.9)
end

-- Stage 2: Spiritual Power!

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 110324 then -- Shado-pan Vanish
		if self:GetStage() == 1 then
			self:StopBar(106853) -- Fists of Fury
			self:StopBar(106434) -- Tornado Kick
			self:SetStage(2)
			self:Message("stages", "cyan", CL.percent:format(60, CL.stage:format(2)), 106747)
			self:PlaySound("stages", "long")
		else
			self:Message(106747, "yellow") -- Shado-pan Mirror Image
			self:PlaySound(106747, "info")
		end
		self:CDBar(106747, 26.7) -- Shado-pan Mirror Image
	end
end

-- Stage 3: I Can Do So Much More!

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.stage3_yell, nil, true) then
		self:StopBar(106747) -- Shado-Pan Mirror Image
		self:SetStage(3)
		self:Message("stages", "cyan", CL.percent:format(30, CL.stage:format(3)), 118961) -- 118961 = Chase Down
		self:PlaySound("stages", "long")
		self:CDBar(118961, 9.5) -- Chase Down
		self:CDBar(106454, 32.7) -- Parry Stance
		self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	end
end

function mod:ChaseDown(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
	self:CDBar(args.spellId, 32.7)
	self:TargetBar(args.spellId, 11, args.destName)
end

function mod:ChaseDownRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:ParryStance(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 32.7)
end
