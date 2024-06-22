if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Faceless One", 2685)
if not mod then return end
mod:RegisterEnableMob(220577) -- Nerl'athekk the Skulking (Faceless One version)
mod:SetEncounterID(2949)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.faceless_one = "Faceless One"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.faceless_one
end

function mod:GetOptions()
	return {
		458849, -- Darkrift Smash
		458853, -- Shadow Drain
		458867, -- Lurking Call
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkriftSmash", 458849)
	self:Log("SPELL_CAST_START", "ShadowDrain", 458853)
	self:Log("SPELL_CAST_START", "LurkingCall", 458867)
end

function mod:OnEngage()
	self:CDBar(458849, 3.6) -- Darkrift Smash
	self:CDBar(458853, 13.3) -- Shadow Drain
	self:CDBar(458867, 20.2) -- Lurking Call
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkriftSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.8)
end

function mod:ShadowDrain(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31.6)
end

function mod:LurkingCall(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 33.1)
end
