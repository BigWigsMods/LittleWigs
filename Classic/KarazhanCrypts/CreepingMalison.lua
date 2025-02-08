--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Creeping Malison", 2875)
if not mod then return end
mod:RegisterEnableMob(238024) -- Creeping Malison
mod:SetEncounterID(3146)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.creeping_malison = "Creeping Malison"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.creeping_malison
end

function mod:GetOptions()
	return {
		1220843, -- Cursed Webbing
		{1220836, "DISPEL"}, -- Spectral Fangs
		1221325, -- Burning
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CursedWebbing", 1220843)
	self:Log("SPELL_CAST_SUCCESS", "SpectralFangs", 1220836)
	self:Log("SPELL_AURA_APPLIED", "SpectralFangsApplied", 1220836)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SpectralFangsApplied", 1220836)
	self:Log("SPELL_CAST_SUCCESS", "Burning", 1221325)
end

function mod:OnEngage()
	self:CDBar(1220836, 6.5) -- Spectral Fangs
	self:CDBar(1220843, 6.5) -- Cursed Webbing
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CursedWebbing(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 16.2)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SpectralFangs(args)
	self:CDBar(args.spellId, 20.6)
end

function mod:SpectralFangsApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("poison", nil, args.spellId) then
		self:StackMessage(args.spellId, "purple", args.destName, args.amount, 1)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:Burning(args)
	self:Message(args.spellId, "green", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end
