
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Curator", 1651, 1836)
if not mod then return end
mod:RegisterEnableMob(114247)
mod.engageId = 1964
mod.respawnTime = 30

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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "PowerDischarge", "boss1")
	self:Log("SPELL_CAST_SUCCESS", "SummonVolatileEnergy", 227267)
	self:Log("SPELL_PERIODIC_DAMAGE", "PowerDischargeDamage", 227465)
	self:Log("SPELL_PERIODIC_MISSED", "PowerDischargeDamage", 227465)
	self:Log("SPELL_AURA_APPLIED", "Evocation", 227254)
	self:Log("SPELL_AURA_REMOVED", "EvocationOver", 227254)
end

function mod:OnEngage()
	self:Bar(227267, 5) -- Summon Volatile Energy
	self:CDBar(227279, 12) -- Power Discharge
	self:CDBar(227254, 68) -- Evocation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonVolatileEnergy(args)
	self:Message(args.spellId, "yellow", "Info")
	self:Bar(args.spellId, 9.7)
end

function mod:PowerDischarge(_, _, _, spellId)
	if spellId == 227278 then
		self:Message(227279, "orange", "Alert")
		self:CDBar(227279, 12)
	end
end

do
	local prev = 0
	function mod:PowerDischargeDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(227279, "blue", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:Evocation(args)
	self:Message(args.spellId, "green", "Long")
	self:CastBar(args.spellId, 20)
	self:StopBar(227267) -- Summon Volatile Energy
	self:StopBar(227279) -- Power Discharges
end

function mod:EvocationOver(args)
	self:Message(args.spellId, "cyan", "Info", CL.over:format(args.spellName))
	self:CDBar(args.spellId, 69)
end
