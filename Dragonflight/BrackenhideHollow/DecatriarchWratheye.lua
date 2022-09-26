if not IsTestBuild() then return end
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
		-- TODO also 373939 Rotting Burst?
		376170, -- Choking Rotcloud
		{373917, "TANK_HEALER"}, -- Decaystrike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DecayingStrength", 373960)
	self:Log("SPELL_CAST_START", "RotburstTotem", 373942)
	self:Log("SPELL_CAST_START", "ChokingRotcloud", 376170)
	self:Log("SPELL_CAST_START", "Decaystrike", 373912)
end

function mod:OnEngage()
	self:CDBar(376170, 5.8) -- Choking Rotcloud
	self:CDBar(373917, 10.6) -- Decaystrike
	self:CDBar(373944, 15.5) -- Rotburst Totem
	self:Bar(373960, 41) -- Decaying Strength
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DecayingStrength(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	-- TODO unknown CD, possibly bugged (energy gain stops after 1 cast)
	-- probably something like 45s (~1s delay, 4s cast, 40s energy gain)
end

function mod:RotburstTotem(args)
	self:Message(373944, "yellow")
	self:PlaySound(373944, "alert")
	self:CDBar(373944, 18.2)
end

function mod:ChokingRotcloud(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 42.9)
end

function mod:Decaystrike(args)
	self:Message(373917, "purple")
	self:PlaySound(373917, "alert")
	self:CDBar(373917, 19.4)
end
