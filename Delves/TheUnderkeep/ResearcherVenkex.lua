--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Researcher Ven'kex", 2690)
if not mod then return end
mod:RegisterEnableMob(219856) -- Researcher Ven'kex
mod:SetEncounterID(2991)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.researcher_venkex = "Researcher Ven'kex"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.researcher_venkex
	self:SetSpellRename(446832, CL.beams) -- Infusion of Poison (Beams)
end

function mod:GetOptions()
	return {
		446832, -- Infusion of Poison
		447187, -- Rend Void
		447143, -- Encasing Webs
	},nil,{
		[446832] = CL.beams, -- Infusion of Poison (Beams)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "InfusionOfPoison", 446832)
	self:Log("SPELL_AURA_APPLIED", "InfusionOfPoisonApplied", 446832)
	self:Log("SPELL_CAST_START", "RendVoid", 447187)
	self:Log("SPELL_CAST_SUCCESS", "EncasingWebs", 447143)
end

function mod:OnEngage()
	self:CDBar(447187, 6.1) -- Rend Void
	self:CDBar(447143, 12.2) -- Encasing Webs
	self:CDBar(446832, 18.3, CL.beams) -- Infusion of Poison
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
