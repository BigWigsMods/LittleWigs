--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Portalmaster Halsan", 2803)
if not mod then return end
mod:RegisterEnableMob(244393) -- Portalmaster Halsan
mod:SetEncounterID(3329)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.portalmaster_halsan = "Portalmaster Halsan"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.portalmaster_halsan
end

function mod:GetOptions()
	return {
		1241753, -- Portal Infusion
		1241991, -- Kareshi Timebomb
		1242142, -- Implosion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PortalInfusion", 1241753, 1241777) -- odd casts, even casts
	self:Log("SPELL_CAST_START", "KareshiTimebomb", 1241991)
	self:Log("SPELL_CAST_START", "Implosion", 1242142)
end

function mod:OnEngage()
	self:CDBar(1241753, 3.5) -- Portal Infusion
	self:CDBar(1241991, 18.1) -- Kareshi Timebomb
	self:CDBar(1242142, 30.2) -- Implosion
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PortalInfusion(args)
	self:Message(1241753, "cyan")
	-- these have independent 34.0s cooldowns, but they are offset by 8.5s
	if args.spellId == 1241753 then
		self:CDBar(1241753, 8.5)
	else -- 1241777
		self:CDBar(1241753, 25.3)
	end
	self:PlaySound(1241753, "info")
end

function mod:KareshiTimebomb(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 34.1)
	self:PlaySound(args.spellId, "long")
end

function mod:Implosion(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 35.1)
	self:PlaySound(args.spellId, "alarm")
end
