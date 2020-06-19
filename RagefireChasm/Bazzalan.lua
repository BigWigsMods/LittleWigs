--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bazzalan", 2437)
if not mod then return end
mod:RegisterEnableMob(11519)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		744, -- Poison
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "PoisonCast", self:SpellName(744))
	self:Log("SPELL_AURA_APPLIED", "PosionApplied", self:SpellName(744))

	self:Death("Win", 11519)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PoisonCast(args)
	if self:Hostile(args.sourceFlags) then
		self:Message(744, "yellow")
	end
end

function mod:PosionApplied(args)
	if self:Friendly(args.destFlags) then
		self:CDBar(744, 180)
	end
end
