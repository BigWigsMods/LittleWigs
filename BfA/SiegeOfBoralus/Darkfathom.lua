--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hadal Darkfathom", 1822, 2134)
if not mod then return end
mod:RegisterEnableMob(128651) -- Hadal Darkfathom
mod:SetEncounterID(2099)
mod:SetRespawnTime(32)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		261563, -- Crashing Tide
		{257882, "CASTBAR"}, -- Break Water
		276068, -- Tidal Surge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrashingTide", 257862)
	self:Log("SPELL_CAST_START", "BreakWater", 257882)
	self:Log("SPELL_CAST_START", "TidalSurge", 276068)
end

function mod:OnEngage()
	self:CDBar(257882, 7.5) -- Break Water
	self:CDBar(261563, 12.4) -- Crashing Tide
	self:CDBar(276068, 23.3) -- Tidal Surge
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Siege of Boralus Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:DarkfathomDefeated()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrashingTide()
	self:Message(261563, "purple")
	self:CDBar(261563, 23.1)
	self:PlaySound(261563, "alert")
end

function mod:BreakWater(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 20.7)
	self:CastBar(args.spellId, 4.6) -- time until the group takes damage
	self:PlaySound(args.spellId, "alarm")
end

function mod:TidalSurge(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 48.5)
	self:PlaySound(args.spellId, "warning")
end
