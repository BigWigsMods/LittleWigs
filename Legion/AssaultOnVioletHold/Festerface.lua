
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Festerface", 1544, 1693)
if not mod then return end
mod:RegisterEnableMob(101995)
mod.engageId = 1848

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		201598, -- Congealing Vomit
		201729, -- Uh Oh... (warning for high energy)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CongealingVomit", 201598)
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	self:Bar(201598, 11) -- Congealing Vomit
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CongealingVomit(args)
	self:MessageOld(args.spellId, "red", "alarm")
	self:Bar(args.spellId, 51)
end

do
	local prev = 0
	function mod:UNIT_POWER_FREQUENT(_, unit)
		local power = UnitPower(unit)
		if power > 70 then
			local t = GetTime()
			if t-prev > 5 then
				prev = t
				self:MessageOld(201729, "orange", "alert", CL.soon:format(self:SpellName(201729))) -- Uh Oh... soon!
			end
		end
	end
end
