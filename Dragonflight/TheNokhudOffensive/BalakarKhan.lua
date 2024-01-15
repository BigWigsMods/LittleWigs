--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Balakar Khan", 2516, 2477)
if not mod then return end
mod:RegisterEnableMob(186151) -- Balakar Khan
mod:SetEncounterID(2580)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local tankComboCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Balakar's Might
		{376634, "SAY", "SAY_COUNTDOWN"}, -- Iron Spear
		376683, -- Iron Stampede
		375943, -- Upheaval
		{375937, "TANK_HEALER"}, -- Rending Strike
		-- Intermission: Stormwinds
		{376727, "CASTBAR"}, -- Siphon Power
		-- Stage Two: The Storm Unleashed
		{376864, "SAY", "SAY_COUNTDOWN"}, -- Static Spear
		376892, -- Crackling Upheaval
		{376827, "DISPEL"}, -- Conductive Strike
	}, {
		[376634] = -25185, -- Stage One: Balakar's Might
		[376727] = -25192, -- Intermission: Stormwinds
		[376864] = -25187, -- Stage Two: The Storm Unleashed
	}
end

function mod:OnBossEnable()
	-- Stage One: Balakar's Might
	self:Log("SPELL_AURA_APPLIED", "IronSpearApplied", 376634)
	self:Log("SPELL_AURA_REMOVED", "IronSpearRemoved", 376634)
	self:Log("SPELL_CAST_START", "IronSpear", 376644)
	self:Log("SPELL_CAST_START", "IronStampede", 376683)
	self:Log("SPELL_CAST_START", "Upheaval", 375943)
	self:Log("SPELL_CAST_START", "RendingStrike", 375937)

	-- Intermission: Stormwinds
	self:Log("SPELL_CAST_START", "SiphonPower", 376727)
	self:Log("SPELL_AURA_APPLIED", "CracklingShieldApplied", 376724)
	self:Log("SPELL_AURA_REMOVED", "CracklingShieldRemoved", 376724)

	-- Stage Two: The Storm Unleashed
	self:Log("SPELL_AURA_APPLIED", "StaticSpearApplied", 376864)
	self:Log("SPELL_AURA_REMOVED", "StaticSpearRemoved", 376864)
	self:Log("SPELL_CAST_START", "StaticSpear", 376865)
	self:Log("SPELL_CAST_START", "CracklingUpheaval", 376892)
	self:Log("SPELL_CAST_START", "ConductiveStrike", 376827)
	self:Log("SPELL_AURA_APPLIED", "ConductiveStrikeApplied", 376827)
end

function mod:OnEngage()
	tankComboCount = 0
	self:SetStage(1)
	self:Bar(375937, 8) -- Rending Strike
	self:Bar(376634, 21.5) -- Iron Spear
	self:Bar(375943, 37) -- Upheaval
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Balakar's Might

do
	local playerName

	function mod:IronSpearApplied(args)
		playerName = args.destName
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Iron Spear")
			self:SayCountdown(args.spellId, 6)
		end
	end

	function mod:IronSpearRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end

	function mod:IronSpear(args)
		self:TargetMessage(376634, "yellow", playerName)
		self:PlaySound(376634, "alarm", nil, playerName)
		self:Bar(376634, 37)
	end
end

function mod:IronStampede(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Upheaval(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 37)
end

function mod:RendingStrike(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- pull:8.0, 22.0, 15.0, 22.0, 15.0
	tankComboCount = tankComboCount + 1
	if tankComboCount % 2 == 1 then
		self:Bar(args.spellId, 22)
	else
		self:Bar(args.spellId, 15)
	end
end

-- Intermission: Stormwinds

function mod:SiphonPower(args)
	self:StopBar(376644) -- Iron Spear
	self:StopBar(375937) -- Rending Strike
	self:StopBar(375943) -- Upheaval
	self:CastBar(args.spellId, 4)
end

function mod:CracklingShieldApplied(args)
	tankComboCount = 0
	self:SetStage(2)
	self:Message("stages", "cyan", self:SpellName(-25192), args.spellId) -- Intermission: Stormwinds
	self:PlaySound("stages", "long")
end

function mod:CracklingShieldRemoved(args)
	self:SetStage(3)
	self:Message("stages", "cyan", self:SpellName(-25187), args.spellId) -- Stage Two: The Storm Unleashed
	self:PlaySound("stages", "long")
	self:Bar(376827, 8) -- Conductive Strike
	self:Bar(376864, 21.5) -- Static Spear
	self:Bar(376892, 37) -- Crackling Upheaval
end

-- Stage Two: The Storm Unleashed

do
	local playerName

	function mod:StaticSpearApplied(args)
		playerName = args.destName
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Static Spear")
			self:SayCountdown(args.spellId, 6)
		end
	end

	function mod:StaticSpearRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end

	function mod:StaticSpear(args)
		self:TargetMessage(376864, "yellow", playerName)
		self:PlaySound(376864, "alarm", nil, playerName)
		self:Bar(376864, 39)
	end
end

function mod:CracklingUpheaval(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 39)
end

function mod:ConductiveStrike(args)
	if self:Tank() or self:Healer() or self:Dispeller("magic", nil, args.spellId) then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		-- pull:8, 22.0, 17.0, 22.0, 17.0
		tankComboCount = tankComboCount + 1
		if tankComboCount % 2 == 1 then
			self:Bar(args.spellId, 22)
		else
			self:Bar(args.spellId, 17)
		end
	end
end

function mod:ConductiveStrikeApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end
