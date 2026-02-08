--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shroomsprew", 2683)
if not mod then return end
mod:RegisterEnableMob(237481) -- Shroomsprew
mod:SetEncounterID(3139)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.shroomsprew = "Shroomsprew"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.shroomsprew
	self:SetSpellRename(415499, CL.weakened) -- Dizzy (Weakened)
	self:SetSpellRename(415492, CL.charge) -- Fungal Charge (Charge)
end

function mod:GetOptions()
	return {
		415406, -- Fungalstorm
		415499, -- Dizzy
		415495, -- Gloopy Fungus
		415492, -- Fungal Charge
		363194, -- Slime Trail
		425315, -- Fungsplosion
	}, nil, {
		[415499] = CL.weakened, -- Dizzy (Weakened)
		[415492] = CL.charge, -- Fungal Charge (Charge)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Fungalstorm", 415406)
	self:Log("SPELL_AURA_APPLIED", "Dizzy", 415499)
	self:Log("SPELL_CAST_START", "FungalCharge", 415492)
	self:Log("SPELL_PERIODIC_DAMAGE", "GloopyFungusDamage", 415495, 363194) -- Gloopy Fungus, Slime Trail
	self:Log("SPELL_PERIODIC_MISSED", "GloopyFungusDamage", 415495, 363194) -- Gloopy Fungus, Slime Trail
	self:Log("SPELL_CAST_START", "Fungsplosion", 425315)
end

function mod:OnEngage()
	self:CDBar(415406, 6.0) -- Fungalstorm
	self:CDBar(425315, 21.7) -- Fungsplosion
	self:CDBar(415492, 31.5, CL.charge) -- Fungal Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fungalstorm(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 30.8)
	self:PlaySound(args.spellId, "long")
end

function mod:Dizzy(args)
	self:Message(args.spellId, "green", CL.weakened)
	self:Bar(args.spellId, 8, CL.weakened)
	self:PlaySound(args.spellId, "info")
end

function mod:FungalCharge(args)
	self:Message(args.spellId, "red", CL.charge)
	self:CDBar(args.spellId, 30.8, CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:GloopyFungusDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:Fungsplosion(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 31.3)
	self:PlaySound(args.spellId, "alarm")
end
