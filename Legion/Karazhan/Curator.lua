--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Curator", 1651, 1836)
if not mod then return end
mod:RegisterEnableMob(114247)
mod:SetEncounterID(1964)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227267, -- Summon Volatile Energy
		227279, -- Power Discharge
		{227254, "CASTBAR"}, -- Evocation
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
	self:SetStage(1)
	self:Bar(227267, 5) -- Summon Volatile Energy
	self:CDBar(227279, 12) -- Power Discharge
	-- Mythic Plus:   900 energy, loses 18/second => 50.0 seconds
	-- Heroic/Mythic: 575 energy, loses 10/second => 57.5 seconds
	self:Bar(227254, self:MythicPlus() and 50 or 57.3) -- Evocation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonVolatileEnergy(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 9.7)
end

function mod:PowerDischarge(_, _, _, spellId)
	if spellId == 227278 then
		self:Message(227279, "orange")
		self:PlaySound(227279, "alert")
		self:CDBar(227279, 12)
	end
end

do
	local prev = 0
	function mod:PowerDischargeDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(227279, "underyou")
				self:PlaySound(227279, "underyou")
			end
		end
	end
end

do
	local prev = 0
	function mod:Evocation(args)
		-- sometimes this ability is double-applied, this restarts the channel to the full 20 seconds
		-- but we don't need to alert again
		local t = args.time
		if t - prev > 3 then
			prev = t
			self:SetStage(2)
			self:Message(args.spellId, "green")
			self:PlaySound(args.spellId, "long")
			self:StopBar(227267) -- Summon Volatile Energy
			self:StopBar(227279) -- Power Discharges
		end
		self:CastBar(args.spellId, 20)
	end

	function mod:EvocationOver(args)
		if args.time - prev > 3 then
			self:SetStage(1)
			self:StopBar(CL.cast:format(args.spellName))
			self:Message(args.spellId, "cyan", CL.over:format(args.spellName))
			self:PlaySound(args.spellId, "info")
			-- Mythic Plus:   900 energy, loses 18/second => 50.0 seconds
			-- Heroic/Mythic: 575 energy, loses 10/second => 57.5 seconds
			self:Bar(args.spellId, self:MythicPlus() and 49.25 or 56.5)
		end
	end
end
