
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger Skyriss", 731, 551)
if not mod then return end
mod:RegisterEnableMob(20912, 20904) -- Harbinger Skyriss, Warden Mellichar
mod.engageId = 1913
mod.respawnTime = 64

--------------------------------------------------------------------------------
-- Locals
--

local nextSplitWarning = 71

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39415, -- Fear
		37162, -- Domination
		36924, -- Mind Rend
		-5335, -- Harbringer's Illusion
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "Fear", 39415)
	self:Log("SPELL_AURA_REMOVED", "FearRemoved", 39415)
	self:Log("SPELL_AURA_APPLIED", "Domination", 37162, 39019) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "MindRend", 36924, 36929, 39017, 39021) -- normal (real one, illusion), heroic (real one, illusion)
end

function mod:OnEngage()
	nextSplitWarning = 71 -- 66% and 33%
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fear(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 4, args.destName)
end

function mod:FearRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Domination(args)
	self:TargetMessage(37162, args.destName, "Urgent")
	self:TargetBar(37162, 6, args.destName)
end

function mod:MindRend(args)
	self:TargetMessage(36924, args.destName, "Important")
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextSplitWarning then
		nextSplitWarning = nextSplitWarning - 33
		self:Message(-5335, "Positive", nil, CL.soon:format(self:SpellName(143024)), false) -- 143024 = Split
		if nextSplitWarning < 33 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, _, _, _, spellId)
	if spellId == 36931 or spellId == 36932 then -- 66% / 33% illusions
		self:Message(-5335, "Neutral", nil, CL.spawned:format(self:SpellName(-5335)))
		if spellId == 36932 then
			self:UnregisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", unit)
		end
	end
end
