--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Stormguard Gorren", 2648, 2567)
if not mod then return end
mod:RegisterEnableMob(207205) -- Stormguard Gorren
mod:SetEncounterID(2861)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local chaoticCorruptionCount = 1
local darkGravityCount = 1
local crushRealityCount = 1
local nextChaoticCorruption = 0
local nextCrushReality = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{424737, "SAY", "SAY_COUNTDOWN"}, -- Chaotic Corruption
		425048, -- Dark Gravity
		424958, -- Crush Reality
		424966, -- Lingering Void
		-- Mythic
		424797, -- Chaotic Vulnerability
	}, {
		[424797] = CL.mythic, -- Chaotic Vulnerability
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChaoticCorruption", 424737)
	self:Log("SPELL_AURA_APPLIED", "ChaoticCorruptionApplied", 424739)
	self:Log("SPELL_CAST_START", "DarkGravity", 425048)
	self:Log("SPELL_CAST_START", "CrushReality", 424958)
	self:Log("SPELL_PERIODIC_DAMAGE", "LingeringVoidDamage", 424966)
	self:Log("SPELL_PERIODIC_MISSED", "LingeringVoidDamage", 424966)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "ChaoticVulnerabilityApplied", 424797)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ChaoticVulnerabilityApplied", 424797)
end

function mod:OnEngage()
	local t = GetTime()
	chaoticCorruptionCount = 1
	darkGravityCount = 1
	crushRealityCount = 1
	nextChaoticCorruption = t + 5.1
	self:CDBar(424737, 5.1, CL.count:format(self:SpellName(424737), chaoticCorruptionCount)) -- Chaotic Corruption
	nextCrushReality = t + 10.0
	self:CDBar(424958, 10.0, CL.count:format(self:SpellName(424958), crushRealityCount)) -- Crush Reality
	self:CDBar(425048, 17.1, CL.count:format(self:SpellName(425048), darkGravityCount)) -- Dark Gravity
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local debuffCount = 0

	function mod:ChaoticCorruption(args)
		local t = GetTime()
		debuffCount = 0
		self:StopBar(CL.count:format(args.spellName, chaoticCorruptionCount))
		self:Message(args.spellId, "red", CL.count:format(args.spellName, chaoticCorruptionCount))
		chaoticCorruptionCount = chaoticCorruptionCount + 1
		nextChaoticCorruption = t + 32.7
		self:CDBar(args.spellId, 32.7, CL.count:format(args.spellName, chaoticCorruptionCount))
	end

	function mod:ChaoticCorruptionApplied(args)
		debuffCount = debuffCount + 1
		self:TargetMessage(424737, "red", args.destName, CL.count_amount:format(args.spellName, debuffCount, 4))
		if self:Me(args.destGUID) then
			self:Say(424737, nil, nil, "Chaotic Corruption")
			if debuffCount < 4 then -- last person doesn't need a countdown because it won't jump
				self:SayCountdown(424737, 5)
			end
		end
		self:PlaySound(424737, "alert", nil, args.destName)
	end
end

function mod:DarkGravity(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, darkGravityCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, darkGravityCount))
	darkGravityCount = darkGravityCount + 1
	self:CDBar(args.spellId, 42.4, CL.count:format(args.spellName, darkGravityCount))
	-- minimum 6.07s until Chaotic Corruption or Crush Reality
	if nextChaoticCorruption - t < 6.07 then
		nextChaoticCorruption = t + 6.07
		self:CDBar(424737, {6.07, 32.7}, CL.count:format(self:SpellName(424737), chaoticCorruptionCount)) -- Chaotic Corruption
	end
	if nextCrushReality - t < 6.07 then
		nextCrushReality = t + 6.07
		self:CDBar(424958, {6.07, 20.6}, CL.count:format(self:SpellName(424958), crushRealityCount)) -- Crush Reality
	end
	self:PlaySound(args.spellId, "long")
end

function mod:CrushReality(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, crushRealityCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, crushRealityCount))
	crushRealityCount = crushRealityCount + 1
	nextCrushReality = t + 20.6
	self:CDBar(args.spellId, 20.6, CL.count:format(args.spellName, crushRealityCount))
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:LingeringVoidDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Mythic

function mod:ChaoticVulnerabilityApplied(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 1)
	end
end
