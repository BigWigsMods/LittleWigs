--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Undersea Abomination", 2689)
if not mod then return end
mod:RegisterEnableMob(214348) -- Undersea Abomination
mod:SetEncounterID(2895)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.undersea_abomination = "Undersea Abomination"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.undersea_abomination
	self:SetSpellRename(446300, CL.dodge) -- Deepsea Polyps (Dodge)
	self:SetSpellRename(446405, CL.frontal_cone) -- Fungal Infection (Frontal Cone)
	self:SetSpellRename(446230, CL.explosion) -- Repelling Blast (Explosion)
end

function mod:GetOptions()
	return {
		446300, -- Deepsea Polyps
		446405, -- Fungal Infection
		446230, -- Repelling Blast
	},nil,{
		[446300] = CL.dodge, -- Deepsea Polyps (Dodge)
		[446405] = CL.frontal_cone, -- Fungal Infection (Frontal Cone)
		[446230] = CL.explosion, -- Repelling Blast (Explosion)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FungalInfection", 446405)
	self:Log("SPELL_CAST_START", "DeepseaPolyps", 446300)
	self:Log("SPELL_CAST_START", "RepellingBlast", 446230)
end

function mod:OnEngage()
	self:CDBar(446405, 4.0, CL.frontal_cone) -- Fungal Infection
	self:CDBar(446300, 11.3, CL.dodge) -- Deepsea Polyps
	self:CDBar(446230, 21.0, CL.explosion) -- Repelling Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FungalInfection(args)
	self:Message(args.spellId, "red", CL.frontal_cone)
	self:CDBar(args.spellId, 21.8, CL.frontal_cone)
	self:PlaySound(args.spellId, "alert")
end

function mod:DeepseaPolyps(args)
	self:Message(args.spellId, "yellow", CL.extra:format(args.spellName, CL.dodge))
	self:CDBar(args.spellId, 17.0, CL.dodge)
	self:PlaySound(args.spellId, "long")
end

function mod:RepellingBlast(args)
	self:Message(args.spellId, "orange", CL.explosion)
	self:CDBar(args.spellId, 21.9, CL.explosion)
	self:PlaySound(args.spellId, "alarm")
end
