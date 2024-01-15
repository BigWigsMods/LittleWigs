--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dealer Xy'exa", 2291, 2398)
if not mod then return end
mod:RegisterEnableMob(164450) -- Dealer Xy'exa
mod:SetEncounterID(2400)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{321948, "SAY", "SAY_COUNTDOWN"}, -- Localized Explosive Contrivance
		320230, -- Explosive Contrivance
		323687, -- Arcane Lightning
	}, nil, {
		[321948] = CL.bomb, -- Localized Explosive Contrivance (Bomb)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "LocalizedExplosiveContrivance", 321948)
	self:Log("SPELL_CAST_START", "ExplosiveContrivance", 320230)
	self:Log("SPELL_CAST_SUCCESS", "ExplosiveContrivanceSuccess", 320230)
	self:Log("SPELL_AURA_APPLIED", "ArcaneLightning", 323687)
end

function mod:OnEngage()
	self:CDBar(321948, 14, CL.bomb) -- Localized Explosive Contrivance
	self:CDBar(320230, 36.8) -- Explosive Contrivance (~31.8s cd + 5s cast)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LocalizedExplosiveContrivance(args)
	self:TargetBar(args.spellId, 5, args.destName, CL.bomb)
	self:Bar(args.spellId, 35) -- pull:14.4, 36.8
	self:TargetMessage(args.spellId, "red", args.destName, CL.bomb)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId, CL.bomb, nil, "Bomb")
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:ExplosiveContrivance(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 5) -- restart with the exact time
end

function mod:ExplosiveContrivanceSuccess(args)
	self:Bar(args.spellId, 35) -- pull:31.8, 35.2
end

function mod:ArcaneLightning(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end
