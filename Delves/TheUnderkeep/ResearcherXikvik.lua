--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Researcher Xik'vik", 2690)
if not mod then return end
mod:RegisterEnableMob(220078) -- Researcher Xik'vik
mod:SetEncounterID(2992)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.researcher_xikvik = "Researcher Xik'vik"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.researcher_xikvik
	self:SetSpellRename(446832, CL.beams) -- Infusion of Poison (Beams)
	self:SetSpellRename(463408, CL.beams) -- Infusion of Frost (Beams)
end

function mod:GetOptions()
	return {
		446832, -- Infusion of Poison
		463408, -- Infusion of Frost
		447187, -- Rend Void
		447143, -- Encasing Webs
	},nil,{
		[446832] = CL.beams, -- Infusion of Poison (Beams)
		[463408] = CL.beams, -- Infusion of Frost (Beams)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "InfusionOfPoison", 446832)
	self:Log("SPELL_AURA_APPLIED", "InfusionOfPoisonApplied", 446832)
	self:Log("SPELL_CAST_START", "InfusionOfFrost", 463408)
	self:Log("SPELL_AURA_APPLIED", "InfusionOfFrostApplied", 463408)
	self:Log("SPELL_CAST_START", "RendVoid", 447187)
	self:Log("SPELL_CAST_SUCCESS", "EncasingWebs", 447143)
end

function mod:OnEngage()
	self:CDBar(447187, 6.1) -- Rend Void
	self:CDBar(447143, 12.0) -- Encasing Webs
	-- this boss has a variant that doesn't cast either Infusion ability
	-- TODO do the variants that do cast the Infusion abilities still exist?
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfusionOfPoison(args)
	self:Message(args.spellId, "cyan", CL.beams)
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 26.7, CL.beams)
end

function mod:InfusionOfPoisonApplied(args)
	self:Bar(args.spellId, 12, CL.onboss:format(CL.beams))
end

function mod:InfusionOfFrost(args)
	self:Message(args.spellId, "cyan", CL.beams)
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 26.7, CL.beams)
end

function mod:InfusionOfFrostApplied(args)
	self:Bar(args.spellId, 12, CL.onboss:format(CL.beams))
end

function mod:RendVoid(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.1)
end

function mod:EncasingWebs(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31.6)
end
