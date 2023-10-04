--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mana Devourer", 1651, 1818)
if not mod then return end
mod:RegisterEnableMob(114252)
mod:SetEncounterID(1959)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Locals
--

local unstableManaOnMe = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227457, -- Energy Discharge
		227618, -- Arcane Bomb
		227523, -- Energy Void
		227502, -- Unstable Mana
		227297, -- Coalesce Power
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus") -- XXX Is this still needed or would the default CheckForEncounterEngage work?
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "ArcaneBomb", 227618)
	self:Log("SPELL_CAST_SUCCESS", "EnergyVoid", 227523)
	self:Log("SPELL_AURA_APPLIED", "UnstableMana", 227502)
	self:Log("SPELL_AURA_APPLIED_DOSE", "UnstableMana", 227502)
	self:Log("SPELL_AURA_REMOVED", "UnstableManaRemoved", 227502)
	self:Log("SPELL_AURA_APPLIED", "CoalescePower", 227297)
	self:Log("SPELL_PERIODIC_DAMAGE", "EnergyVoidDamage", 227524)
	self:Log("SPELL_PERIODIC_MISSED", "EnergyVoidDamage", 227524)
end

function mod:OnEngage()
	unstableManaOnMe = false
	self:CDBar(227618, 7) -- Arcane Bomb
	self:CDBar(227523, 14.5) -- Energy Void
	self:CDBar(227457, 21) -- Energy Discharge
	self:Bar(227297, 30.6) -- Coalesce Power
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 227457 then -- Energy Discharge
		self:Message(227457, "orange")
		self:PlaySound(227457, "alarm")
		self:CDBar(227457, 27.9)
	end
end

function mod:ArcaneBomb(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 13.7)
end

function mod:EnergyVoid(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 20.6)
end

function mod:UnstableMana(args)
	if self:Me(args.destGUID) then
		unstableManaOnMe = true
		-- each stack gives the player a 10% damage increase, but starts getting dangerous at ~5 stacks
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, self:Tank() and 7 or 5)
	end
end

function mod:UnstableManaRemoved(args)
	if self:Me(args.destGUID) then
		unstableManaOnMe = false
	end
end

function mod:CoalescePower(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 30.3)
end

do
	local prev = 0
	function mod:EnergyVoidDamage(args)
		if self:Me(args.destGUID) and not unstableManaOnMe then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(227523, "underyou")
				self:PlaySound(227523, "underyou")
			end
		end
	end
end
