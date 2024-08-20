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

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427461, -- Void Corruption
		427852, -- Entropic Reckoning
		427869, -- Unbridled Void
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoidCorruption", 427461)
	self:Log("SPELL_AURA_APPLIED", "VoidCorruptionApplied", 427329)
	self:Log("SPELL_AURA_REMOVED", "VoidCorruptionRemoved", 427329)
	self:Log("SPELL_CAST_START", "EntropicReckoning", 427852)
	self:Log("SPELL_CAST_START", "UnbridledVoid", 427869)
end

function mod:OnEngage()
	local t = GetTime()
	voidCorruptionCount = 1
	entropicReckoningCount = 1
	self:CDBar(427869, 8.2) -- Unbridled Void
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
	-- 3.63 minimum to next Entropic Reckoning
	if nextEntropicReckoning - t < 3.63 then
		nextEntropicReckoning = t + 3.63
		self:CDBar(427852, {3.63, 17.0}, CL.count:format(self:SpellName(427852), entropicReckoningCount)) -- Entropic Reckoning
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
	nextEntropicReckoning = t + 17.0
	self:CDBar(args.spellId, 17.0, CL.count:format(args.spellName, entropicReckoningCount))
	self:PlaySound(args.spellId, "alert")
end

function mod:UnbridledVoid(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 20.6)
	-- 6.05 minimum to next ability
	if nextVoidCorruption - t < 6.05 then
		nextVoidCorruption = t + 6.05
		self:CDBar(427461, {6.05, 29.1}, CL.count:format(self:SpellName(427461), voidCorruptionCount)) -- Void Corruption
	end
	if nextEntropicReckoning - t < 6.05 then
		nextEntropicReckoning = t + 6.05
		self:CDBar(427852, {6.05, 17.0}, CL.count:format(self:SpellName(427852), entropicReckoningCount)) -- Entropic Reckoning
	end
	self:PlaySound(args.spellId, "alarm")
end
