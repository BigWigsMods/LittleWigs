--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Slad'ran", 604, 592)
if not mod then return end
mod:RegisterEnableMob(29304) -- Slad'ran
mod:SetEncounterID(mod:Classic() and 383 or 1978)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{59842, "CASTBAR"}, -- Poison Nova
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PoisonNova", 55081, 59842) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "PoisonNovaApplied", 55081, 59842)
	self:Log("SPELL_AURA_REMOVED", "PoisonNovaRemoved", 55081, 59842)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PoisonNova(args)
	self:Message(59842, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(59842, "info")
	self:CastBar(59842, 3.5)
end

function mod:PoisonNovaApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(59842)
		self:PlaySound(59842, "alarm", nil, args.destName)
		self:TargetBar(59842, args.spellId == 59842 and 10 or 16, args.destName)
	end
end

function mod:PoisonNovaRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
