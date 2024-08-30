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
	self:SetSpellRename(415499, CL.weakened) -- Dizzy (Weakened)
	self:SetSpellRename(415492, CL.charge) -- Fungal Charge (Charge)
end

function mod:GetOptions()
	return {
		415406, -- Fungalstorm
		415499, -- Dizzy
		415492, -- Fungal Charge
		425315, -- Fungsplosion
	},nil,{
		[415499] = CL.weakened, -- Dizzy (Weakened)
		[415492] = CL.charge, -- Fungal Charge (Charge)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Fungalstorm", 415406)
	self:Log("SPELL_AURA_APPLIED", "Dizzy", 415499)
	self:Log("SPELL_CAST_START", "FungalCharge", 415492)
	self:Log("SPELL_CAST_START", "Fungsplosion", 425315)
end

function mod:OnEngage()
	self:CDBar(415406, 5.7) -- Fungalstorm
	self:CDBar(415492, 19.7, CL.charge) -- Fungal Charge
	self:CDBar(425315, 26.3) -- Fungsplosion
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fungalstorm(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 30.2)
	self:PlaySound(args.spellId, "long")
end

function mod:Dizzy(args)
	self:Message(args.spellId, "green", CL.weakened)
	self:Bar(args.spellId, 8, CL.weakened)
	self:PlaySound(args.spellId, "info")
end

function mod:FungalCharge(args)
	self:Message(args.spellId, "red", CL.charge)
	self:CDBar(args.spellId, 30.2, CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Fungsplosion(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.2)
	self:PlaySound(args.spellId, "alarm")
end
