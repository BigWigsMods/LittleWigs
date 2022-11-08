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
		{376660, "SAY"}, -- Iron Spear
		376683, -- Iron Stampede
		375943, -- Upheaval
		{375937, "TANK_HEALER"}, -- Rending Strike
		-- Intermission: Stormwinds
		376727, -- Siphon Power
		-- Stage Two: The Storm Unleashed
		{376864, "SAY"}, -- Static Spear
		376892, -- Crackling Upheaval
		-- TODO Crackling Cloud (Mythic only)
		{376827, "DISPEL"}, -- Conductive Strike
	}, {
		[376660] = -25185, -- Stage One: Balakar's Might
		[376727] = -25192, -- Intermission: Stormwinds
		[376864] = -25187, -- Stage Two: The Storm Unleashed
	}
end

function mod:OnBossEnable()
	-- Stage One: Balakar's Might
	self:Log("SPELL_CAST_START", "IronSpear", 376644)
	self:Log("SPELL_CAST_START", "IronStampede", 376683)
	self:Log("SPELL_CAST_START", "Upheaval", 375943)
	self:Log("SPELL_CAST_START", "RendingStrike", 375937)

	-- Intermission: Stormwinds
	self:Log("SPELL_CAST_START", "SiphonPower", 376727)
	self:Log("SPELL_AURA_APPLIED", "CracklingShieldApplied", 376724)
	self:Log("SPELL_AURA_REMOVED", "CracklingShieldRemoved", 376724)

	-- Stage Two: The Storm Unleashed
	self:Log("SPELL_CAST_START", "StaticSpear", 376865)
	self:Log("SPELL_CAST_START", "CracklingUpheaval", 376892)
	self:Log("SPELL_CAST_START", "ConductiveStrike", 376827)
	self:Log("SPELL_AURA_APPLIED", "ConductiveStrikeApplied", 376827)
end

function mod:OnEngage()
	tankComboCount = 0
	self:SetStage(1)
	self:Bar(375937, 8) -- Rending Strike
	self:Bar(376660, 21.5) -- Iron Spear
	self:Bar(375943, 37) -- Upheaval TODO confirm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Balakar's Might

do
	local function printTarget(self, name, guid)
		self:TargetMessage(376660, "yellow", name)
		self:PlaySound(376660, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(376660)
		end
	end

	function mod:IronSpear(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		-- TODO unknown CD
	end
end

function mod:IronStampede(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Upheaval(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO unknown CD
end

function mod:RendingStrike(args)
	tankComboCount = tankComboCount + 1
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, tankComboCount == 1 and 22 or 17) -- TODO confirm exact pattern
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
	local function printTarget(self, name, guid)
		self:TargetMessage(376864, "yellow", name)
		self:PlaySound(376864, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(376864)
		end
	end

	function mod:StaticSpear(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		-- TODO unknown CD
	end
end

function mod:CracklingUpheaval(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO unknown CD
end

function mod:ConductiveStrike(args)
	if self:Tank() or self:Healer() or self:Dispeller("magic", false, args.spellId) then
		tankComboCount = tankComboCount + 1
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:Bar(args.spellId, tankComboCount == 1 and 22 or 17) -- TODO confirm exact pattern
	end
end

function mod:ConductiveStrikeApplied(args)
	if self:Dispeller("magic", false, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end
