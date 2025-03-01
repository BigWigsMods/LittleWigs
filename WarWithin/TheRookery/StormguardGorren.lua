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
		424737, -- Chaotic Corruption
		425048, -- Dark Gravity
		424958, -- Crush Reality
		424966, -- Lingering Void
		-- Mythic
		{424797, "ME_ONLY"}, -- Chaotic Vulnerability
	}, {
		[424797] = CL.mythic, -- Chaotic Vulnerability
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChaoticCorruption", 424737)
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
	nextChaoticCorruption = t + 5.8
	self:CDBar(424737, 5.8, CL.count:format(self:SpellName(424737), chaoticCorruptionCount)) -- Chaotic Corruption
	nextCrushReality = t + 9.5
	self:CDBar(424958, 9.5, CL.count:format(self:SpellName(424958), crushRealityCount)) -- Crush Reality
	self:CDBar(425048, 30.1, CL.count:format(self:SpellName(425048), darkGravityCount)) -- Dark Gravity
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChaoticCorruption(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, chaoticCorruptionCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, chaoticCorruptionCount))
	chaoticCorruptionCount = chaoticCorruptionCount + 1
	nextChaoticCorruption = t + 32.7
	self:CDBar(args.spellId, 32.7, CL.count:format(args.spellName, chaoticCorruptionCount))
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkGravity(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, darkGravityCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, darkGravityCount))
	darkGravityCount = darkGravityCount + 1
	self:CDBar(args.spellId, 32.4, CL.count:format(args.spellName, darkGravityCount))
	-- minimum 8.5s until Chaotic Corruption or Crush Reality
	if nextChaoticCorruption - t < 8.5 then
		nextChaoticCorruption = t + 8.5
		self:CDBar(424737, {8.5, 32.7}, CL.count:format(self:SpellName(424737), chaoticCorruptionCount)) -- Chaotic Corruption
	end
	if nextCrushReality - t < 8.5 then
		nextCrushReality = t + 8.5
		self:CDBar(424958, {8.5, 20.6}, CL.count:format(self:SpellName(424958), crushRealityCount)) -- Crush Reality
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
	self:StackMessage(args.spellId, "cyan", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "info")
end
