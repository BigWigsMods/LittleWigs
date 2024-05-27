--------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archbishop Benedictus", 940, 341)
if not mod then return end
mod:RegisterEnableMob(54938) -- Archbishop Benedictus
mod:SetEncounterID(1339)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: The Light Will Consume You!
		{103151, "SAY", "ME_ONLY_EMPHASIZE"}, -- Righteous Shear
		103565, -- Purifying Light
		103678, -- Wave of Virtue
		-- Stages Two: Drown in Shadow!
		{103363, "SAY", "ME_ONLY_EMPHASIZE"}, -- Twilight Shear
		103767, -- Corrupting Twilight
		103780, -- Wave of Twilight
	}, {
		[103151] = -4150, -- Stage One: The Light Will Consume You!
		[103363] = -4152, -- Stage Two: Drown in Shadow!
	}
end

function mod:OnBossEnable()
	-- Stage One: The Light Will Consume You!
	self:Log("SPELL_CAST_SUCCESS", "RighteousShear", 103151)
	self:Log("SPELL_CAST_SUCCESS", "PurifyingLight", 103565)
	self:Log("SPELL_CAST_SUCCESS", "WaterShell", 103688) -- Wave of Virtue

	-- Stage Two: Drown in Shadow!
	self:Log("SPELL_CAST_SUCCESS", "TwilightEpiphany", 103754) -- Stage 2
	self:Log("SPELL_CAST_SUCCESS", "TwilightShear", 103363)
	self:Log("SPELL_CAST_SUCCESS", "CorruptingTwilight", 103767)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Wave of Twilight
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(103151, 6.1) -- Righteous Shear
	self:CDBar(103565, 10.9) -- Purifying Light
	self:CDBar(103678, 30.4) -- Wave of Virtue
end

--------------------------------------------------------------------------------
--  Event Handlers
--

-- Stage One: The Light Will Consume You!

function mod:RighteousShear(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:CDBar(args.spellId, 46.1)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Righteous Shear")
	end
end

function mod:PurifyingLight(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 46.1)
end

function mod:WaterShell()
	self:Message(103678, "orange") -- Wave of Virtue
	self:PlaySound(103678, "alarm")
	self:CDBar(103678, 46.1)
end

-- Stage Two: Drown in Shadow!

function mod:TwilightEpiphany(args)
	self:StopBar(103151) -- Righteous Shear
	self:StopBar(103565) -- Purifying Light
	self:StopBar(103678) -- Wave of Virtue
	self:SetStage(2)
	self:Message("stages", "cyan", CL.percent:format(60, CL.stage:format(2)), args.spellId)
	self:PlaySound("stages", "long")
	self:CDBar(103767, 6.1) -- Corrupting Twilight
	self:CDBar(103363, 17.0) -- Twilight Shear
	self:CDBar(103780, 18.2) -- Wave of Twilight
end

function mod:TwilightShear(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:CDBar(args.spellId, 46.1)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Twilight Shear")
	end
end

function mod:CorruptingTwilight(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 46.1)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("103780", nil, true) then -- Wave of Twilight
		self:Message(103780, "orange")
		self:PlaySound(103780, "alarm")
		self:CDBar(103780, 46.1)
	end
end
