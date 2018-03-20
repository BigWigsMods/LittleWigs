-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halazzi", 568, 189)
if not mod then return end
mod:RegisterEnableMob(23577)
mod.engageId = 1192
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
--  Locals
--

local spiritPhasesLeft = 2
local nextPhaseWarning = 65

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.spirit_message = "Spirit Phase"
	L.normal_message = "Normal Phase"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		43303, -- Flame Shock
		43139, -- Enrage
		43302, -- Lightning Totem
		97499, -- Water Totem
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")

	self:Log("SPELL_AURA_APPLIED", "FlameShock", 43303)
	self:Log("SPELL_AURA_REMOVED", "FlameShockRemoved", 43303)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 43139)
	self:Log("SPELL_CAST_START", "Totems", 43302, 97499) -- Lightning Totem, Water Totem
end

function mod:OnEngage()
	spiritPhasesLeft = 2
	nextPhaseWarning = 65 -- 60% and 30%
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:FlameShock(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	self:TargetBar(args.spellId, 12, args.destName)
end

function mod:FlameShockRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Enrage(args)
	self:Message(args.spellId, "Important")
end

function mod:Totems(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	-- All spells used are called "Halazzi Transform"
	if spellId == 43143 then -- Spirit Phase
		self:Message("stages", "Positive", nil, CL.percent:format(30 * spiritPhasesLeft, L.spirit_message), "ability_hunter_pet_cat")
		spiritPhasesLeft = spiritPhasesLeft - 1
	elseif spellId == 43145 or spellId == 43271 then -- Normal Phase
		self:Message("stages", "Positive", nil, L.normal_message, "achievement_character_troll_male")
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextPhaseWarning then
		nextPhaseWarning = nextPhaseWarning - 30
		self:Message("stages", "Attention", nil, CL.soon:format(L.spirit_message), false)

		if nextPhaseWarning < 35 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end
