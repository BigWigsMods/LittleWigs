
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Temporus", 269, 553)
if not mod then return end
mod:RegisterEnableMob(17880)
-- mod.engageId = 1921 -- TODO: check if wipes work fine

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		31458, -- Hasten
		38592, -- Spell Reflection
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Hasten", 31458)
	self:Log("SPELL_AURA_REMOVED", "HastenRemoved", 31458)
	self:Log("SPELL_AURA_APPLIED", "SpellReflection", 38592)

	self:Death("Win", 17880)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hasten(args)
	if self:MobId(args.destGUID) ~= 17880 then return end -- mages can spellsteal it
	self:MessageOld(args.spellId, "red", self:Dispeller("magic", true) and "warning")
	self:Bar(args.spellId, 10)
end

function mod:HastenRemoved(args)
	if self:MobId(args.destGUID) ~= 17880 then return end -- mages can spellsteal it
	self:StopBar(args.spellName)
end

function mod:SpellReflection(args)
	self:MessageOld(args.spellId, "orange")
	self:Bar(args.spellId, 6)
end
