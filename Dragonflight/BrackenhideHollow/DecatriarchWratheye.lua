--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Decatriarch Wratheye", 2520, 2474)
if not mod then return end
mod:RegisterEnableMob(186121) -- Decatriarch Wratheye
mod:SetEncounterID(2569)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373960, -- Decaying Strength
		373944, -- Rotburst Totem
		376170, -- Choking Rotcloud
		{373917, "TANK_HEALER"}, -- Decaystrike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DecayingStrength", 373960)
	self:Log("SPELL_AURA_REMOVED", "DecayingStrengthRemoved", 374186)
	self:Log("SPELL_CAST_START", "RotburstTotem", 373942)
	self:Log("SPELL_CAST_START", "ChokingRotcloud", 376170)
	self:Log("SPELL_CAST_START", "Decaystrike", 373912)
end

function mod:OnEngage()
	self:Bar(376170, 5.8) -- Choking Rotcloud
	self:CDBar(373917, 10.6) -- Decaystrike
	self:CDBar(373944, 15.5) -- Rotburst Totem
	-- 40s energy gain, ~.1s delay
	self:CDBar(373960, 40.1) -- Decaying Strength
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DecayingStrength(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:DecayingStrengthRemoved(args)
	self:Message(373960, "green", CL.removed:format(args.spellName))
	self:PlaySound(373960, "info")
	-- energy gain only turns back on once the buff falls off the boss
	-- 40s energy gain, ~.3s delay
	self:CDBar(373960, 40.3) -- Decaying Strength
end

function mod:RotburstTotem(args)
	self:Message(373944, "yellow")
	self:PlaySound(373944, "alert")
	self:CDBar(373944, 17.0)
end

function mod:ChokingRotcloud(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 42.5)
end

function mod:Decaystrike(args)
	self:Message(373917, "purple")
	self:PlaySound(373917, "alert")
	self:CDBar(373917, 19.4)
end
