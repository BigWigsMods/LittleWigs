--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mechano-Lord Capacitus", 554, 563)
if not mod then return end
mod:RegisterEnableMob(19219)
--mod:SetEncounterID(1932) -- no boss frames, only fires ENCOUNTER_* events once per instance reset (if you wipe - tough luck)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local playerCollector = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		35158, -- Reflective Magic Shield
		35159, -- Reflective Damage Shield
		{39096, "CASTBAR"}, -- Polarity Shift
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
	self:MessageOld(args.spellId, "orange")
	self:Bar(args.spellId, 10)
end

function mod:ReflectiveShieldRemoved(args)
	self:MessageOld(args.spellId, "green", nil, CL.removed:format(args.spellName))
end

function mod:PolarityShift(args)
	self:MessageOld(args.spellId, "orange", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
end

do
	local function fillTheTable(self, unit, spellId)
		local guid = self:UnitGUID(unit)
		if not playerCollector[guid] then
			playerCollector[guid] = true
			if self:Me(guid) then
				-- Cyan for Positive, Red for Negative
				self:MessageOld(39096, spellId == 39088 and "cyan" or "red", "info", CL.you:format(self:SpellName(spellId)), spellId)
			end
		end
	end

	-- no SPELL_AURA_APPLIED events
	function mod:UNIT_AURA(_, unit)
		if self:UnitDebuff(unit, 39088) then -- Positive Charge
			fillTheTable(self, unit, 39088)
		elseif self:UnitDebuff(unit, 39091) then -- Negative Charge
			fillTheTable(self, unit, 39091)
		end
	end

	function mod:PolarityShiftSuccess()
		playerCollector = {}
		self:RegisterUnitEvent("UNIT_AURA", nil, "player", "party1", "party2", "party3", "party4")
		self:ScheduleTimer("UnregisterUnitEvent", 3, "UNIT_AURA", "player", "party1", "party2", "party3", "party4")
	end
end
