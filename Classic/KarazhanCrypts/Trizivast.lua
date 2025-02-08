--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trizivast", 2875)
if not mod then return end
mod:RegisterEnableMob(238428) -- Trizivast
mod:SetEncounterID(3144) -- Opera of Malediction
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.trizivast = "Trizivast"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.trizivast
end

function mod:GetOptions()
	return {
		1222563, -- Fear
		1223459, -- War Stomp
		1223462, -- Flamethrower
		{1222564, "DISPEL"}, -- Bloodlust
		1223460, -- Furious Fists
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Fear", 1222563)
	self:Log("SPELL_CAST_SUCCESS", "WarStomp", 1223459)
	self:Log("SPELL_CAST_SUCCESS", "Flamethrower", 1223462)
	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 1222564)
	self:Log("SPELL_AURA_APPLIED", "BloodlustApplied", 1222564)
	self:Log("SPELL_CAST_START", "FuriousFists", 1223460)
end

function mod:OnEngage()
	self:CDBar(1223459, 17.6) -- War Stomp
	self:CDBar(1222564, 17.8) -- Bloodlust
	self:CDBar(1222563, 17.8) -- Fear
	self:CDBar(1223462, 21.3) -- Flamethrower
	self:CDBar(1223460, 32.3) -- Furious Fists
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Fear(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 31.9)
	self:PlaySound(args.spellId, "alert")
end

function mod:WarStomp(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 14.6)
	self:PlaySound(args.spellId, "alert")
end

function mod:Flamethrower(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 21.0)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Bloodlust(args)
	self:CDBar(args.spellId, 32.8)
end

function mod:BloodlustApplied(args)
	if self:Me(args.destGUID) or (self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags)) then
		self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:FuriousFists(args)
	self:Message(args.spellId, "purple")
	self:StopBar(args.spellId)
	--self:CDBar(args.spellId, 100) TODO unknown
	self:PlaySound(args.spellId, "alert")
end
