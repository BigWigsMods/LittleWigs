--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taragaman the Hungerer", 2437)
if not mod then return end
mod:RegisterEnableMob(11520)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{18072, "TANK"}, -- Uppercut
		11970, -- Fire Nova
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Uppercut", self:SpellName(18072))
	self:Log("SPELL_CAST_SUCCESS", "FireNova", self:SpellName(11970))

	self:Death("Win", 11520)
end

function mod:OnEngage()
	self:Bar(18072, 180) -- Curse of Weakness
	self:Bar(11970, 180) -- Immolate
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Uppercut(args)
	self:Message(18072, "orange")
	self:CDBar(18072, 180)
end

function mod:FireNova(args)
	self:CDBar(11970, 180)
end
