
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Curator", 1115, 1836)
if not mod then return end
mod:RegisterEnableMob(114247)
mod.engageId = 1964

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227267, -- Summon Volatile Energy
		227279, -- Power Discharge
		227254, -- Evocation
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_SUCCESS", "SummonVolatileEnergy", 227267)
	self:Log("SPELL_CAST_SUCCESS", "PowerDischarge", 227279)
	self:Log("SPELL_AURA_APPLIED", "PowerDischargeDamage", 227465)
	self:Log("SPELL_PERIODIC_DAMAGE", "PowerDischargeDamage", 227465)
	self:Log("SPELL_PERIODIC_MISSED", "PowerDischargeDamage", 227465)
	self:Log("SPELL_AURA_APPLIED", "Evocation", 227254)
end

function mod:OnEngage()
	self:Bar(227267, 5) -- Summon Volatile Energy
	self:CDBar(227279, 12) -- Power Discharge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonVolatileEnergy(args)
	self:Message(args.spellId, "Attention", "Info")
	self:Bar(args.spellId, 9.7)
end

do
	local prev = 0
	function mod:PowerDischarge(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alert")
			self:CDBar(args.spellId, 12)
		end
	end
end

do
	local prev = 0
	function mod:PowerDischargeDamage(args)
		local t = GetTime()
		if t-prev > 2 and self:Me(args.destGUID) then
			prev = t
			self:Message(227279, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:Evocation(args)
	self:Message(args.spellId, "Positive", "Long")
	self:Bar(args.spellId, 20, CL.cast:format(args.spellName))
	self:StopBar(227267) -- Summon Volatile Energy
	self:StopBar(227279) -- Power Discharges
end
