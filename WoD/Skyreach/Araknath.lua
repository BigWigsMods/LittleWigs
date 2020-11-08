
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Araknath", 1209, 966)
if not mod then return end
mod:RegisterEnableMob(76141)
mod.engageId = 1699
mod.respawnTime = 23 -- respawns 11s after, unattackable for a while

--------------------------------------------------------------------------------
-- Locals
--

local smashCount, burstCount = 0, 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		154159, -- Energize
		{154110, "TANK"}, -- Smash
		154135, -- Burst
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Energize", 154159)
	self:Log("SPELL_CAST_START", "Smash", 154110, 154113)
	self:Log("SPELL_CAST_START", "Burst", 154135)
end

function mod:OnEngage()
	smashCount, burstCount = 0, 0
	self:CDBar(154159, 17) -- Energize
	self:CDBar(154135, 20) -- Burst
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:Energize(args)
		local t = GetTime()
		if t-prev > 5 then -- More than 1 in Challenge Mode
			prev = t
			self:MessageOld(args.spellId, "yellow", "long", CL.incoming:format(args.spellName))
			self:Bar(args.spellId, 23)
		end
	end
end

function mod:Smash()
	self:MessageOld(154110, "orange", "warning")
	smashCount = smashCount + 1
	self:CDBar(154110, smashCount % 2 == 0 and 14.6 or 8.5)
end

function mod:Burst(args)
	burstCount = burstCount + 1
	self:MessageOld(args.spellId, "red", "info", CL.count:format(args.spellName, burstCount))
	self:CDBar(args.spellId, 23)
end
