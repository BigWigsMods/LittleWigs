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

local spearCount = 1
local tankComboCount = 1
local upheavalCount = 1

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
	spearCount = 1
	tankComboCount = 1
	upheavalCount = 1
	self:SetStage(1)
	self:Bar(375937, 8, CL.count:format(self:SpellName(375937), tankComboCount)) -- Rending Strike
	self:Bar(376634, 21.5, CL.count:format(self:SpellName(376634), spearCount)) -- Iron Spear
	self:Bar(375943, 37, CL.count:format(self:SpellName(375943), upheavalCount)) -- Upheaval
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
		self:StopBar(CL.count:format(args.spellName, spearCount))
		self:TargetMessage(376634, "yellow", playerName, CL.count:format(args.spellName, spearCount))
		self:PlaySound(376634, "alarm", nil, playerName)
		spearCount = spearCount + 1
		self:Bar(376634, 37, CL.count:format(args.spellName, spearCount))
	end
end

function mod:IronStampede(args)
	-- cast immediately after Iron Spear / Static Spear
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Upheaval(args)
	self:StopBar(CL.count:format(args.spellName, upheavalCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, upheavalCount))
	self:PlaySound(args.spellId, "alarm")
	upheavalCount = upheavalCount + 1
	self:Bar(args.spellId, 37, CL.count:format(args.spellName, upheavalCount))
end

function mod:RendingStrike(args)
	self:StopBar(CL.count:format(args.spellName, tankComboCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, tankComboCount))
	self:PlaySound(args.spellId, "alert")
	-- pull:8.0, 22.0, 15.0, 22.0, 15.0
	tankComboCount = tankComboCount + 1
	if tankComboCount % 2 == 0 then
		self:Bar(args.spellId, 22, CL.count:format(args.spellName, tankComboCount))
	else
		self:Bar(args.spellId, 15, CL.count:format(args.spellName, tankComboCount))
	end
end

-- Intermission: Stormwinds

function mod:SiphonPower(args)
	self:StopBar(CL.count:format(self:SpellName(376634), spearCount)) -- Iron Spear
	self:StopBar(CL.count:format(self:SpellName(375937), tankComboCount)) -- Rending Strike
	self:StopBar(CL.count:format(self:SpellName(375943), upheavalCount)) -- Upheaval
	self:CastBar(args.spellId, 4)
end

function mod:CracklingShieldApplied(args)
	spearCount = 1
	tankComboCount = 1
	upheavalCount = 1
	self:SetStage(2)
	if not self:Normal() then
		-- this stage ends instantly on Normal, don't bother showing the alert
		self:Message("stages", "cyan", self:SpellName(-25192), args.spellId) -- Intermission: Stormwinds
		self:PlaySound("stages", "long")
	end
end

function mod:CracklingShieldRemoved(args)
	self:SetStage(3)
	self:Message("stages", "cyan", self:SpellName(-25187), args.spellId) -- Stage Two: The Storm Unleashed
	self:PlaySound("stages", "long")
	self:Bar(376827, 8, CL.count:format(self:SpellName(376827), tankComboCount)) -- Conductive Strike
	self:Bar(376864, 21.5, CL.count:format(self:SpellName(376864), spearCount)) -- Static Spear
	self:Bar(376892, 37, CL.count:format(self:SpellName(376892), upheavalCount)) -- Crackling Upheaval
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
		self:StopBar(CL.count:format(args.spellName, spearCount))
		self:TargetMessage(376864, "yellow", playerName, CL.count:format(args.spellName, spearCount))
		self:PlaySound(376864, "alarm", nil, playerName)
		spearCount = spearCount + 1
		self:Bar(376864, 39, CL.count:format(args.spellName, spearCount))
	end
end

function mod:CracklingUpheaval(args)
	self:StopBar(CL.count:format(args.spellName, upheavalCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, upheavalCount))
	self:PlaySound(args.spellId, "alarm")
	upheavalCount = upheavalCount + 1
	self:Bar(args.spellId, 39, CL.count:format(args.spellName, upheavalCount))
end

function mod:ConductiveStrike(args)
	if self:Tank() or self:Healer() or self:Dispeller("magic", nil, args.spellId) then
		self:StopBar(CL.count:format(args.spellName, tankComboCount))
		self:Message(args.spellId, "purple", CL.count:format(args.spellName, tankComboCount))
		self:PlaySound(args.spellId, "alert")
		-- pull:8, 22.0, 17.0, 22.0, 17.0
		tankComboCount = tankComboCount + 1
		if tankComboCount % 2 == 0 then
			self:Bar(args.spellId, 22, CL.count:format(args.spellName, tankComboCount))
		else
			self:Bar(args.spellId, 17, CL.count:format(args.spellName, tankComboCount))
		end
	end
end

function mod:ConductiveStrikeApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end
