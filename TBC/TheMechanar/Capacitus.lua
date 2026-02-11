--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mechano-Lord Capacitus", 554, 563)
if not mod then return end
mod:RegisterEnableMob(19219)
--mod:SetEncounterID(1932) -- no boss frames, only fires ENCOUNTER_* events once per instance reset (if you wipe - tough luck)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

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

	self:CheckForEngage()
	self:Death("Win", 19219)
end

function mod:OnEngage()
	self:CheckForWipe()
	if not self:Normal() then
		self:Berserk(180)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ReflectiveShield(args)
	self:Message(args.spellId, "orange")
	self:Bar(args.spellId, 10)
end

function mod:ReflectiveShieldRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
end

function mod:PolarityShift(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
end

do
	local playerCollector = {}
	do
		local function fillTheTable(self, unit, spellId)
			local guid = self:UnitGUID(unit)
			if not playerCollector[guid] then
				playerCollector[guid] = true
				if self:Me(guid) then
					self:PersonalMessage(39096, nil, self:SpellName(spellId), spellId)
					self:PlaySound(39096, "info")
				end
			end
		end

		-- no SPELL_AURA_APPLIED events
		function mod:UNIT_AURA(event, unit)
			if self:GetUnitAura(unit, 39088) then -- Positive Charge
				self:UnregisterUnitEvent(event, unit)
				fillTheTable(self, unit, 39088)
			elseif self:GetUnitAura(unit, 39091) then -- Negative Charge
				self:UnregisterUnitEvent(event, unit)
				fillTheTable(self, unit, 39091)
			end
		end
	end

	local function StopListening() mod:UnregisterUnitEvent("UNIT_AURA", "player", "party1", "party2", "party3", "party4") end
	function mod:PolarityShiftSuccess()
		playerCollector = {}
		self:RegisterUnitEvent("UNIT_AURA", nil, "player", "party1", "party2", "party3", "party4")
		self:SimpleTimer(StopListening, 3)
	end
end
