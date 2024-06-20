if not BigWigsLoader.isBeta then return end
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
end

function mod:GetOptions()
	return {
		446300, -- Deepsea Polyps
		446405, -- Fungal Infection
		446230, -- Repelling Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FungalInfection", 446405)
	self:Log("SPELL_CAST_START", "DeepseaPolyps", 446300)
	self:Log("SPELL_CAST_START", "RepellingBlast", 446230)
end

function mod:OnEngage()
	self:CDBar(446405, 4.0) -- Fungal Infection
	self:CDBar(446300, 11.3) -- Deepsea Polyps
	self:CDBar(446230, 21.0) -- Repelling Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FungalInfection(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 21.8)
end

function mod:DeepseaPolyps(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 17.0)
end

function mod:RepellingBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.9)
end
