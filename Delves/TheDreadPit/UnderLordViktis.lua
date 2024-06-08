if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Under-Lord Vik'tis", 2684)
if not mod then return end
mod:RegisterEnableMob(220158) -- Under-Lord Vik'tis
mod:SetEncounterID(2989)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.under_lord_viktis = "Under-Lord Vik'tis"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.under_lord_viktis
end

function mod:GetOptions()
	return {
		448634, -- Impale
		448644, -- Burrowing Tremors
		448663, -- Stinging Swarm
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:Log("SPELL_CAST_START", "Impale", 448634)
	self:Log("SPELL_CAST_START", "BurrowingTremors", 448644)
	self:Log("SPELL_CAST_START", "StingingSwarm", 448663)
end

function mod:OnEngage()
	self:CDBar(448634, 6.0) -- Impale
	self:CDBar(448644, 12.1) -- Burrowing Tremors
	self:CDBar(448663, 26.7) -- Stinging Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:Impale(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 14.6)
end

function mod:BurrowingTremors(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31.6)
end

function mod:StingingSwarm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 34.0)
end
