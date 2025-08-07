--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vindle Snapcrank", {2689, 2826}) -- Tak-Rethan Abyss, Sidestreet Sluice
if not mod then return end
mod:RegisterEnableMob(234931, 240376) -- Vindle Snapcrank (Tak-Rethan Abyss, Sidestreet Sluice)
mod:SetEncounterID({3124, 3173}) -- Tak-Rethan Abyss, Sidestreet Sluice
--mod:SetRespawnTime(15) resets, doesn't respawn
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vindle_snapcrank = "Vindle Snapcrank"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.vindle_snapcrank
end

function mod:GetOptions()
	return {
		1215870, -- Sprocket Smash
		1215337, -- Clanker Bomb
		1215374, -- Shock Maintenance
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SprocketSmash", 1215870)
	self:Log("SPELL_CAST_START", "ClankerBomb", 1215337)
	self:Log("SPELL_CAST_START", "ShockMaintenance", 1215374)
end

function mod:OnEngage()
	self:CDBar(1215870, 4.8) -- Sprocket Smash
	self:CDBar(1215337, 9.7) -- Clanker Bomb
	self:CDBar(1215374, 25.5) -- Shock Maintenance
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SprocketSmash(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ClankerBomb(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "info")
end

function mod:ShockMaintenance(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 28.7)
	self:PlaySound(args.spellId, "long")
end
