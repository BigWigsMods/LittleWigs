--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overseer Kaskel", 2688)
if not mod then return end
mod:RegisterEnableMob(220437) -- Overseer Kaskel
mod:SetEncounterID(2990)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overseer_kaskel = "Overseer Kaskel"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.overseer_kaskel
end

function mod:GetOptions()
	return {
		449038, -- Impaling Spikes
		448644, -- Burrowing Terrors
		449072, -- Call Drones
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ImpalingSpikes", 449038)
	self:Log("SPELL_CAST_START", "BurrowingTremors", 448644)
	self:Log("SPELL_CAST_START", "CallDrones", 449072)
end

function mod:OnEngage()
	self:CDBar(449038, 6.0) -- Impaling Spikes
	self:CDBar(448644, 12.1) -- Burrowing Tremors
	self:CDBar(449072, 26.7) -- Call Drones
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ImpalingSpikes(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25.1)
end

function mod:BurrowingTremors(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 21.6)
end

function mod:CallDrones(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 30.4)
end
