--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hellscream's Phantom", 2784)
if not mod then return end
mod:RegisterEnableMob(227028) -- Hellscream's Phantom
mod:SetEncounterID(3031)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hellscreams_phantom = "Hellscream's Phantom"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.hellscreams_phantom
end

function mod:GetOptions()
	return {
		460254, -- Spiritstorm
		460084, -- Spectral Shout
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Spiritstorm", 460254)
	self:Log("SPELL_CAST_SUCCESS", "SpectralShout", 460084)
end

function mod:OnEngage()
	self:CDBar(460254, 21.3) -- Spiritstorm
	self:CDBar(460084, 27.5) -- Spectral Shout
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Spiritstorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.0)
end

function mod:SpectralShout(args)
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 25.9)
end
