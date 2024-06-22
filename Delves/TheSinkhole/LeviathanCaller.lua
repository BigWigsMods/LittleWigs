if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Leviathan Caller", 2687)
if not mod then return end
mod:RegisterEnableMob(220738) -- Leviathan Caller
mod:SetEncounterID(3002)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.leviathan_caller = "Leviathan Caller"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.leviathan_caller
end

function mod:GetOptions()
	return {
		446079, -- Call of the Abyss
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallOfTheAbyss", 446079)
	-- TODO this boss summons a Leviathan Tentacle which channels something on the boss, and then the boss
	-- goes immune until you kill the tentacle. there are no casts/auras/etc logged when this happens.
end

function mod:OnEngage()
	self:CDBar(446079, 10.5) -- Call of the Abyss
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallOfTheAbyss(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 22.7)
end
