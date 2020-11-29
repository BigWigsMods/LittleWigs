
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dealer Xy'exa", 2291, 2398)
if not mod then return end
mod:RegisterEnableMob(164450)
mod.engageId = 2400
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{321948, "SAY", "SAY_COUNTDOWN"}, -- Localized Explosive Contrivance
		320230, -- Explosive Contrivance
		323687, -- Arcane Lightning
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "LocalizedExplosiveContrivance", 321948)
	self:Log("SPELL_CAST_START", "ExplosiveContrivance", 320230)
	self:Log("SPELL_AURA_APPLIED", "ArcaneLightning", 323687)
end

function mod:OnEngage()
	self:CDBar(321948, 14, 174716, 321948) -- Localized Explosive Contrivance | 174716 = "Bomb"
	self:CDBar(320230, 31) -- Explosive Contrivance
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LocalizedExplosiveContrivance(args)
	local bomb = self:SpellName(174716) -- 174716 = "Bomb"
	self:TargetBar(args.spellId, 5, args.destName, bomb)
	self:Bar(args.spellId, 35) -- pull:14.4, 36.8
	self:TargetMessage(args.spellId, "red", args.destName, bomb)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId, bomb)
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:ExplosiveContrivance(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 35) -- pull:31.8, 35.2
end

function mod:ArcaneLightning(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end
