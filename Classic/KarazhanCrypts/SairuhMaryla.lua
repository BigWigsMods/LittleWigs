--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sairuh Maryla", 2875)
if not mod then return end
mod:RegisterEnableMob(238213) -- Sairuh Maryla
mod:SetEncounterID(3171) -- Apprentice
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sairuh_maryla = "Sairuh Maryla"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.sairuh_maryla
end

function mod:GetOptions()
	return {
		1220853, -- Frostbolt Volley
		1220855, -- Frost Nova
		1220862, -- Blizzard
		1220882, -- Freezing Field
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FrostboltVolley", 1220853)
	self:Log("SPELL_CAST_SUCCESS", "FrostNova", 1220855)
	self:Log("SPELL_CAST_SUCCESS", "Blizzard", 1220862)
	self:Log("SPELL_CAST_START", "FreezingField", 1220882)
end

function mod:OnEngage()
	self:CDBar(1220853, 6.4) -- Frostbolt Volley
	self:CDBar(1220855, 9.7) -- Frost Nova
	self:CDBar(1220862, 10.3) -- Blizzard
	self:CDBar(1220882, 22.6) -- Freezing Field
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FrostboltVolley(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 12.9)
	self:PlaySound(args.spellId, "alert")
end

function mod:FrostNova(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 30.7)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Blizzard(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 25.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:FreezingField(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 51.8)
	self:PlaySound(args.spellId, "long")
end
