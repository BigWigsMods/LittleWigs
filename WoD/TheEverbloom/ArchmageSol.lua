
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archmage Sol", 1279, 1208)
if not mod then return end
mod:RegisterEnableMob(82682)
mod.engageId = 1751
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		168885, -- Parasitic Growth
		{166492, "FLASH"}, -- Firebloom
		166726, -- Frozen Rain
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ParasiticGrowth", 168885)
	self:Log("SPELL_AURA_APPLIED", "MagicSchools", 166475, 166476, 166477) -- Fire, Frost, Arcane
	self:Log("SPELL_AURA_APPLIED", "FrozenRain", 166726)
	self:Log("SPELL_CAST_SUCCESS", "Firebloom", 166492)
end

function mod:OnEngage()
	self:MessageOld("stages", "cyan", nil, 166475) -- Fire
	self:CDBar(168885, 33) -- Parasitic Growth
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ParasiticGrowth(args)
	self:MessageOld(args.spellId, "orange", "warning")
	self:Bar(args.spellId, 34)
end

function mod:MagicSchools(args)
	self:MessageOld("stages", "cyan", nil, args.spellId)
end

do
	local prev = 0
	function mod:Firebloom(args)
		local t = GetTime()
		if t-prev > 7 then
			prev = t
			self:MessageOld(args.spellId, "red", "alert")
			self:Flash(args.spellId)
		end
	end
end

function mod:FrozenRain(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.you:format(args.spellName))
	end
end
