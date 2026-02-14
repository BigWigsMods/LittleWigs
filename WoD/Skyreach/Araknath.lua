--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Araknath", 1209, 966)
if not mod then return end
mod:RegisterEnableMob(76141)
mod:SetEncounterID(1699)
mod:SetRespawnTime(23) -- respawns 11s after, unattackable for a while
mod:SetPrivateAuraSounds({
	{154150, sound = "alert"}, -- Light Ray
})

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
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{154150, "PRIVATE"}, -- Light Ray
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:Energize(args)
		if args.time - prev > 5 then -- More than 1 in Challenge Mode
			prev = args.time
			self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
			self:Bar(args.spellId, 23)
			self:PlaySound(args.spellId, "long")
		end
	end
end

function mod:Smash()
	self:Message(154110, "orange")
	smashCount = smashCount + 1
	self:CDBar(154110, smashCount % 2 == 0 and 14.6 or 8.5)
	self:PlaySound(154110, "warning")
end

function mod:Burst(args)
	burstCount = burstCount + 1
	self:Message(args.spellId, "red", CL.count:format(args.spellName, burstCount))
	self:CDBar(args.spellId, 23)
	self:PlaySound(args.spellId, "info")
end
