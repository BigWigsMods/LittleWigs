--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Void Speaker Eirich", 2652, 2582)
if not mod then return end
mod:RegisterEnableMob(213119) -- Void Speaker Eirich
mod:SetEncounterID(2883)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local voidCorruptionCount = 1
local nextVoidCorruption = 0
local entropicReckoningCount = 1
local nextEntropicReckoning = 0
local nextUnbridledVoid = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427461, -- Void Corruption
		427852, -- Entropic Reckoning
		457465, -- Entropy
		427869, -- Unbridled Void
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoidCorruption", 427461)
	self:Log("SPELL_AURA_APPLIED", "VoidCorruptionApplied", 427329)
	self:Log("SPELL_AURA_REMOVED", "VoidCorruptionRemoved", 427329)
	self:Log("SPELL_CAST_START", "EntropicReckoning", 427852)
	self:Log("SPELL_PERIODIC_DAMAGE", "EntropyDamage", 457465)
	self:Log("SPELL_PERIODIC_MISSED", "EntropyDamage", 457465)
	self:Log("SPELL_CAST_START", "UnbridledVoid", 427869)
end

function mod:OnEngage()
	local t = GetTime()
	voidCorruptionCount = 1
	entropicReckoningCount = 1
	nextUnbridledVoid = t + 7.3
	self:CDBar(427869, 7.3) -- Unbridled Void
	nextVoidCorruption = t + 15.7
	self:CDBar(427461, 15.7, CL.count:format(self:SpellName(427461), voidCorruptionCount)) -- Void Corruption
	nextEntropicReckoning = t + 21.7
	self:CDBar(427852, 21.7, CL.count:format(self:SpellName(427852), entropicReckoningCount)) -- Entropic Reckoning
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VoidCorruption(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, voidCorruptionCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, voidCorruptionCount))
	voidCorruptionCount = voidCorruptionCount + 1
	nextVoidCorruption = t + 29.1
	self:CDBar(args.spellId, 29.1, CL.count:format(args.spellName, voidCorruptionCount))
	-- 3.63 minimum to next ability
	if nextEntropicReckoning - t < 3.63 then
		nextEntropicReckoning = t + 3.63
		self:CDBar(427852, {3.63, 24.3}, CL.count:format(self:SpellName(427852), entropicReckoningCount)) -- Entropic Reckoning
	end
	if nextUnbridledVoid - t < 3.63 then
		nextUnbridledVoid = t + 3.63
		self:CDBar(427869, {3.63, 20.6}) -- Unbridled Void
	end
	-- in Mythic this always applies to everyone so play the warning sound here, this gives time to pre-position
	if self:Mythic() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:VoidCorruptionApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(427461)
		-- in non-Mythic this doesn't apply to everyone so play the sound only if on you
		if not self:Mythic() then
			self:PlaySound(427461, "warning")
		end
	end
end

function mod:VoidCorruptionRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(427461, "green", CL.removed:format(args.spellName))
		self:PlaySound(427461, "info", nil, args.destName)
	end
end

function mod:EntropicReckoning(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, entropicReckoningCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, entropicReckoningCount))
	entropicReckoningCount = entropicReckoningCount + 1
	nextEntropicReckoning = t + 24.3
	self:CDBar(args.spellId, 24.3, CL.count:format(args.spellName, entropicReckoningCount))
	-- 6.05 minimum to next ability
	if nextVoidCorruption - t < 6.05 then
		nextVoidCorruption = t + 6.05
		self:CDBar(427461, {6.05, 29.1}, CL.count:format(self:SpellName(427461), voidCorruptionCount)) -- Void Corruption
	end
	if nextUnbridledVoid - t < 6.05 then
		nextUnbridledVoid = t + 6.05
		self:CDBar(427869, {6.05, 20.6}) -- Unbridled Void
	end
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:EntropyDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:UnbridledVoid(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	nextUnbridledVoid = t + 20.6
	self:CDBar(args.spellId, 20.6)
	-- 6.05 minimum to next ability
	if nextVoidCorruption - t < 6.05 then
		nextVoidCorruption = t + 6.05
		self:CDBar(427461, {6.05, 29.1}, CL.count:format(self:SpellName(427461), voidCorruptionCount)) -- Void Corruption
	end
	if nextEntropicReckoning - t < 6.05 then
		nextEntropicReckoning = t + 6.05
		self:CDBar(427852, {6.05, 24.3}, CL.count:format(self:SpellName(427852), entropicReckoningCount)) -- Entropic Reckoning
	end
	self:PlaySound(args.spellId, "alarm")
end
