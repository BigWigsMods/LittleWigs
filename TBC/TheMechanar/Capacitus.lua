
-- GLOBALS: tContains, tDeleteItem

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mechano-Lord Capacitus", 730, 563)
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
		224604, -- Enrage
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
		self:Berserk(180, false, nil, 224604) -- 224604 = Enrage
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
	-- no SPELL_AURA_APPLIED events
	function mod:UNIT_AURA(_, unit)
		local function fillTheTableAndOpenProximity(unit, sameChargeList, oppositeChargeList, spellId, color)
			local name = self:UnitName(unit)
			local guid = UnitGUID(unit)
			if not playerCollector[guid] then
				playerCollector[guid] = true
				if not tContains(sameChargeList, name) then
					positiveList[#sameChargeList+1] = name
				end
				tDeleteItem(oppositeChargeList, name)
				if UnitIsUnit(unit, "player") then
					self:OpenProximity(39096, 10, sameChargeList, true)
					self:Message(39096, color, "Info", CL.you:format(self:SpellName(spellId)), spellId)
				end
			end
		end

		if UnitDebuff(unit, self:SpellName(39088)) then -- Positive Charge
			fillTheTableAndOpenProximity(unit, positiveList, negativeList, 39088, "Neutral") -- cyan
		elseif UnitDebuff(unit, self:SpellName(39091)) then -- Negative Charge
			fillTheTableAndOpenProximity(unit, negativeList, positiveList, 39091, "Important") -- red
		end
	end

	function mod:PolarityShiftSuccess()
		wipe(playerCollector)
		self:RegisterEvent("UNIT_AURA")
		self:ScheduleTimer("UnregisterEvent", 3, "UNIT_AURA")
	end
end
