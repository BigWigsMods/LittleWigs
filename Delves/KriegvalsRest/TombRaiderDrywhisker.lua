--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tomb-Raider Drywhisker", 2681)
if not mod then return end
mod:RegisterEnableMob(204188) -- Tomb-Raider Drywhisker
mod:SetEncounterID(2878)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tomb_raider_drywhisker = "Tomb-Raider Drywhisker"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.tomb_raider_drywhisker
end

function mod:GetOptions()
	return {
		449242, -- Flamestorm
		449295, -- Ground Slam
		449339, -- Raging Tantrum
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Flamestorm", 449242)
	self:Log("SPELL_CAST_START", "GroundSlam", 449295)
	self:Log("SPELL_CAST_START", "RagingTantrum", 449339)
end

function mod:OnEngage()
	self:CDBar(449242, 6.1) -- Flamestorm
	self:CDBar(449295, 18.2) -- Ground Slam
	self:CDBar(449339, 30.1) -- Raging Tantrum
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Flamestorm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 17.8)
end

function mod:GroundSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 27.9)
end

function mod:RagingTantrum(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31.6)
end
