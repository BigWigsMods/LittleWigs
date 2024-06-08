if not BigWigsLoader.isBeta then return end
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
end

function mod:GetOptions()
	return {
		446832, -- Infusion of Poison
		447187, -- Rend Void
		447143, -- Encasing Webs
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:Log("SPELL_CAST_START", "InfusionOfPoison", 446832)
	self:Log("SPELL_CAST_START", "RendVoid", 447187)
	self:Log("SPELL_CAST_SUCCESS", "EncasingWebs", 447143)
	-- TODO Poison Glob, no event
end

function mod:OnEngage()
	self:CDBar(447187, 6.9) -- Rend Void
	self:CDBar(447143, 13.0) -- Encasing Webs
	self:CDBar(446832, 21.5) -- Infusion of Poison
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

function mod:InfusionOfPoison(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26.7)
end

function mod:RendVoid(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.1)
end

function mod:EncasingWebs(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 32.8)
end
