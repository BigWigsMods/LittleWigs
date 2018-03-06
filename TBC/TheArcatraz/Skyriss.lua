
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger Skyriss", 731, 551)
if not mod then return end
mod:RegisterEnableMob(20912, 20904) -- Harbinger Skyriss, Warden Mellichar

local splitPhase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.split_trigger = "We span the universe, as countless as the stars!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		37162, -- Domination
		36924, -- Mind Rend
		143024, -- Slit, XXX FAKE ID
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Domination", 37162, 39019)
	self:Log("SPELL_AURA_APPLIED", "MindRend", 36924, 36929, 39017, 39021)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Death("Win", 20912)
end

function mod:OnEngage()
	splitPhase = 1
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Domination(args)
	self:TargetMessage(37162, args.destName, "Urgent")
	self:TargetBar(37162, 6, args.destName)
end

function mod:MindRend(args)
	self:TargetMessage(36924, args.destName, "Important")
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.split_trigger then
		self:Message(143024, "Attention")
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 20912 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if (hp < 71 and splitPhase == 1) or (hp < 36 and splitPhase == 2) then
			splitPhase = splitPhase + 1
			self:Message(143024, "Positive", nil, CL.soon:format(self:SpellName(143024)), false)
			if splitPhase > 2 then
				self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			end
		end
	end
end
