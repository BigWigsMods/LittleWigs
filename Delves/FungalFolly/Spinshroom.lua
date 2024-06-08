if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Spinshroom", 2664)
if not mod then return end
mod:RegisterEnableMob(207481) -- Spinshroom
mod:SetEncounterID(2831)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.spinshroom = "Spinshroom"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.spinshroom
end

function mod:GetOptions()
	return {
		415406, -- Fungalstorm
		415499, -- Dizzy
		415492, -- Fungal Charge
		425315, -- Fungsplosion
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:Log("SPELL_CAST_START", "Fungalstorm", 415406)
	self:Log("SPELL_AURA_APPLIED", "Dizzy", 415499)
	self:Log("SPELL_CAST_START", "FungalCharge", 415492)
	self:Log("SPELL_CAST_START", "Fungsplosion", 425315)
end

function mod:OnEngage()
	self:CDBar(415406, 5.7) -- Fungalstorm
	self:CDBar(415492, 20.0) -- Fungal Charge
	self:CDBar(425315, 26.4) -- Fungsplosion
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

function mod:Fungalstorm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 30.2)
end

function mod:Dizzy(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

function mod:FungalCharge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.2)
end

function mod:Fungsplosion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.2)
end
