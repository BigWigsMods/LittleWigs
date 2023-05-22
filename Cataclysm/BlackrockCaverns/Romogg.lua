-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rom'ogg Bonecrusher", 645, 105)
if not mod then return end
mod:RegisterEnableMob(39665)
mod.engageId = 1040
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextChainsWarning = 71

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{75543, "CASTBAR"}, -- The Skullcracker
		75272, -- Quake
		75539, -- Chains of Woe
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Quake", 75272)
	self:Log("SPELL_AURA_APPLIED", "QuakeDamage", 75272)
	self:Log("SPELL_MISSED", "QuakeDamage", 75272) -- the application of the debuff can miss but it might apply on the next tick
	self:Log("SPELL_PERIODIC_DAMAGE", "QuakeDamage", 75272)
	self:Log("SPELL_PERIODIC_MISSED", "QuakeDamage", 75272)

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_CAST_START", "ChainsOfWoe", 75539)
	self:Log("SPELL_CAST_START", "TheSkullcracker", 75543)
end

function mod:OnEngage()
	nextChainsWarning = 71 -- 66% and 33%
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Quake(args)
	self:MessageOld(args.spellId, "yellow", nil, CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:QuakeDamage(args)
		if not self:Me(args.destGUID) then return end
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < nextChainsWarning then
		self:MessageOld(75539, "yellow", nil, CL.soon:format(self:SpellName(75539))) -- Chains of Woe
		nextChainsWarning = nextChainsWarning - 33

		while nextChainsWarning >= 33 and hp < nextChainsWarning do
			-- account for high-level characters hitting multiple thresholds
			nextChainsWarning = nextChainsWarning - 33
		end

		if nextChainsWarning < 33 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:ChainsOfWoe(args)
	self:MessageOld(args.spellId, "red", "alarm", CL.casting:format(args.spellName))
end

function mod:TheSkullcracker(args)
	local time = self:Normal() and 12 or 8 -- 12 sec on normal, 8 on heroic
	self:CastBar(args.spellId, time)
	self:MessageOld(args.spellId, "orange", nil, CL.casting:format(args.spellName))
end
