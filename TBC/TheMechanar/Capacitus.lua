
-- GLOBALS: tContains, tDeleteItem

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mechano-Lord Capacitus", 554, 563)
if not mod then return end
mod:RegisterEnableMob(19219)
-- mod.engageId = 1932 -- no boss frames, only fires ENCOUNTER_* events once per instance reset (if you wipe - tough luck)
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local playerCollector = {}
local negativeList, positiveList = {}, {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		35158, -- Reflective Magic Shield
		35159, -- Reflective Damage Shield
		{39096, "PROXIMITY"}, -- Polarity Shift
		"berserk",
	}, {
		[35158] = "normal",
		[39096] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ReflectiveShield", 35158, 35159) -- Magic, Damage
	self:Log("SPELL_AURA_REMOVED", "ReflectiveShieldRemoved", 35158, 35159) -- Magic, Damage
	self:Log("SPELL_CAST_START", "PolarityShift", 39096)
	self:Log("SPELL_CAST_SUCCESS", "PolarityShiftSuccess", 39096)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 19219)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	if not self:Normal() then
		self:Berserk(180)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ReflectiveShield(args)
	self:Message(args.spellId, "Urgent")
	self:Bar(args.spellId, 10)
end

function mod:ReflectiveShieldRemoved(args)
	self:Message(args.spellId, "Positive", nil, CL.removed:format(args.spellName))
end

function mod:PolarityShift(args)
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
end

do
	local function fillTheTableAndOpenProximity(self, unit, sameChargeList, oppositeChargeList, spellId, color)
		local guid = UnitGUID(unit)
		if not playerCollector[guid] then
			playerCollector[guid] = true
			local name = self:UnitName(unit)
			if not tContains(sameChargeList, name) then
				sameChargeList[#sameChargeList+1] = name
			end
			tDeleteItem(oppositeChargeList, name)
			if self:Me(guid) then
				self:OpenProximity(39096, 10, sameChargeList, true)
				self:Message(39096, spellId == 39088 and "Neutral" or "Important", "Info", CL.you:format(self:SpellName(spellId)), spellId)
			end
		end
	end

	-- no SPELL_AURA_APPLIED events
	function mod:UNIT_AURA(unit)
		if UnitDebuff(unit, self:SpellName(39088)) then -- Positive Charge
			fillTheTableAndOpenProximity(self, unit, positiveList, negativeList, 39088) -- cyan
		elseif UnitDebuff(unit, self:SpellName(39091)) then -- Negative Charge
			fillTheTableAndOpenProximity(self, unit, negativeList, positiveList, 39091) -- red
		end
	end

	function mod:PolarityShiftSuccess()
		wipe(playerCollector)
		self:RegisterUnitEvent("UNIT_AURA", nil, "player", "party1", "party2", "party3", "party4")
		self:ScheduleTimer("UnregisterUnitEvent", 3, "UNIT_AURA", "player", "party1", "party2", "party3", "party4")
	end
end
