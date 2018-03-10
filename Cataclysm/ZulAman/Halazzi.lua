-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Halazzi", 781, 189)
if not mod then return end
mod:RegisterEnableMob(23577)

--------------------------------------------------------------------------------
--  Locals

local spirit = false
local count = true

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.phase = "Phases"
	L.phase_desc = "Warn for phase changes."
	L.spirit_soon = "Spirit Phase soon!"
	L.spirit_message = "%d%% - Spirit Phase!"
	L.normal_message = "Normal Phase!"
	L.spirit_trigger = "I fight wit' untamed spirit...."
	L.normal_trigger = "Spirit, come back to me!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"phase",
		43303, -- Flame Shock
		43139, -- Enrage
		43302, -- Lightning Totem
		97499, -- Water Totem
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Phases")

	self:Log("SPELL_AURA_APPLIED", "FlameShock", 43303)
	self:Log("SPELL_AURA_REMOVED", "FlameShockRemoved", 43303)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 43139)
	self:Log("SPELL_CAST_START", "Totems", 43302, 97499) -- Lightning Totem, Water Totem

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 23577)
end

function mod:OnEngage()
	spirit = false
	count = true
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Phases(_, msg)
	if msg == L.spirit_trigger then
		if count then
			self:Message("phase", "Positive", nil, L.spirit_message:format(66), 24183)
			count = false
		else
			self:Message("phase", "Positive", nil, L.spirit_message:format(33), 24183)
		end
	elseif msg == L.normal_trigger then
		self:Message("phase", "Positive", nil, L.normal_message, 89259)
	end
end

function mod:FlameShock(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	self:TargetBar(args.spellId, 12, args.destName)
end

function mod:FlameShockRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:Enrage(args)
	self:Message(args.spellId, "Important")
end

function mod:Totems(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 69 and hp <= 71 and not spirit then
		self:Message("phase", "Attention", nil, L.spirit_soon)
		spirit = true
	elseif hp > 36 and hp <= 38 and spirit then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message("phase", "Attention", nil, L.spirit_soon)
	end
end
