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
-- Locals
--

local nextImpale = 0
local nextStingingSwarm = 0

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
	self:SetSpellRename(448634, CL.frontal_cone) -- Impale (Frontal Cone)
end

function mod:GetOptions()
	return {
		448634, -- Impale
		448644, -- Burrowing Tremors
		448663, -- Stinging Swarm
	},nil,{
		[448634] = CL.frontal_cone, -- Impale (Frontal Cone)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Impale", 448634)
	self:Log("SPELL_CAST_START", "BurrowingTremors", 448644)
	self:Log("SPELL_CAST_START", "StingingSwarm", 448663)
end

function mod:OnEngage()
	local t = GetTime()
	nextImpale = t + 6.0
	nextStingingSwarm = t + 26.6
	self:CDBar(448634, 6.0, CL.frontal_cone) -- Impale
	self:CDBar(448644, 12.0) -- Burrowing Tremors
	self:CDBar(448663, 23.1) -- Stinging Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Impale(args)
	self:Message(args.spellId, "orange", CL.frontal_cone)
	nextImpale = GetTime() + 14.5
	self:CDBar(args.spellId, 14.5, CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BurrowingTremors(args)
	local t = GetTime()
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 31.5)
	-- 10.91 minimum to Impale or Stinging Swarm
	if nextImpale - t < 10.91 then
		nextImpale = t + 10.91
		self:CDBar(448634, {10.91, 14.5}, CL.frontal_cone) -- Impale
	end
	if nextStingingSwarm - t < 10.91 then
		nextStingingSwarm = t + 10.91
		self:CDBar(448663, {10.91, 32.8}) -- Stinging Swarm
	end
	self:PlaySound(args.spellId, "long")
end

function mod:StingingSwarm(args)
	local t = GetTime()
	self:Message(args.spellId, "yellow")
	nextStingingSwarm = t + 32.8
	self:CDBar(args.spellId, 32.8)
	-- 8.51 minimum to Impale
	if nextImpale - t < 8.51 then
		nextImpale = t + 8.51
		self:CDBar(448634, {8.51, 14.5}, CL.frontal_cone) -- Impale
	end
	self:PlaySound(args.spellId, "alert")
end
