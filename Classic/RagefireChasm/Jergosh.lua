--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jergosh the Invoker", 1583)
if not mod then return end
mod:RegisterEnableMob(11518)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		18267, -- Curse of Weakness
		20800, -- Immolate
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CurseCast", self:SpellName(18267))
	self:Log("SPELL_CAST_SUCCESS", "ImmolateCast", self:SpellName(20800))
	self:Log("SPELL_AURA_APPLIED", "CurseApplied", self:SpellName(18267))
	self:Log("SPELL_AURA_APPLIED", "Immolate", self:SpellName(20800))

	self:Death("Win", 11518)
end

function mod:OnEngage()
	self:CDBar(18267, 180) -- Curse of Weakness
	self:CDBar(20800, 180) -- Immolate
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CurseCast(args)
	if self:Hostile(args.sourceGUID) then
		self:CDBar(18267, 180)
	end
end

function mod:CurseApplied(args)
	if self:Friendly(args.destGUID) then
		self:Message(18267, "yellow")
	end
end

function mod:ImmolateCast(args)
	if self:Hostile(args.sourceFlags) then
		self:CDBar(20800, 180)
	end
end

function mod:ImmolateApplied(args)
	if self:Friendly(args.destGUID) then
		self:Message(20800, "yellow")
	end
end
