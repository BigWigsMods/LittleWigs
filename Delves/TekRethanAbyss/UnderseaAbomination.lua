if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Undersea Abomination", 2689)
if not mod then return end
mod:RegisterEnableMob(214348) -- Undersea Abomination
mod:SetEncounterID(2895)
-- mod:SetRespawnTime(15) resets, doesn't respawn
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
	--self:RegisterEvent("ENCOUNTER_START") only happens once
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage") -- XXX because ENCOUNTER_START is not reliable
	self:Log("SPELL_CAST_SUCCESS", "FungalInfection", 446405)
	self:Log("SPELL_CAST_START", "DeepseaPolyps", 446300)
	self:Log("SPELL_CAST_START", "RepellingBlast", 446230)
	self:Death("Win", 214348) -- XXX no ENCOUNTER_END
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe") -- XXX no ENCOUNTER_END on wipes
	self:CDBar(446405, 4.7) -- Fungal Infection
	self:CDBar(446300, 14.2) -- Deepsea Polyps
	self:CDBar(446230, 27.0) -- RepellingBlast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:FungalInfection(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 34.0)
end

function mod:DeepseaPolyps(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 16.2)
end

function mod:RepellingBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 33.2)
end
