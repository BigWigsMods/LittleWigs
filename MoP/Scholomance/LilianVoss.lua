--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lilian Voss", 1007, 666)
if not mod then return end
mod:RegisterEnableMob(
	58722, -- Lilian Voss
	58791 -- Lilian's Soul
)
mod:SetEncounterID(1429)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locales
--

local L = mod:GetLocale()
if L then
	L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		111570, -- Death's Grasp
		111775, -- Shadow Shiv
		{115350, "ME_ONLY_EMPHASIZE"}, -- Fixate Anger
	}, nil, {
		[115350] = CL.fixate, -- Fixate Anger (Fixate)
	}
end

function mod:OnBossEnable()
	-- Stage One: Fetch Me Their Bones!
	self:Log("SPELL_CAST_START", "DeathsGrasp", 111570)
	self:Log("SPELL_CAST_START", "ShadowShiv", 111775)

	-- Stage Two: Your Soul is Mine!
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:Log("SPELL_CAST_SUCCESS", "UnleashAnger", 111649)
	self:Log("SPELL_AURA_APPLIED", "FixateAnger", 115350)

	-- Stage Three: A Perfectly Good Corpse
	self:Log("SPELL_CAST_START", "ReanimateCorpse", 114262)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(111775, 12.1) -- Shadow Shiv
	self:CDBar(111570, 30.4) -- Death's Grasp
end

function mod:VerifyEnable(unit)
	-- the boss starts as friendly at full HP, after a win the boss becomes friendly again at 1% HP
	return UnitCanAttack("player", unit) or self:GetHealth(unit) > 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Fetch Me Their Bones!

function mod:DeathsGrasp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 34.0)
end

function mod:ShadowShiv(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13.4)
end

-- Stage Two: Your Soul is Mine!

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.stage_2_trigger then
		-- can clean up bars a little bit early
		self:StopBar(111570) -- Death's Grasp
		self:StopBar(111775) -- Shadow Shiv
	end
end

function mod:UnleashAnger(args)
	self:StopBar(111570) -- Death's Grasp
	self:StopBar(111775) -- Shadow Shiv
	self:SetStage(2)
	self:Message("stages", "cyan", CL.percent:format(60, CL.stage:format(2)), args.spellId)
	self:PlaySound("stages", "long")
end

function mod:FixateAnger(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:CDBar(args.spellId, 12.1, CL.fixate)
end

-- Stage Three: A Perfectly Good Corpse

function mod:ReanimateCorpse(args)
	self:SetStage(3)
	self:Message("stages", "cyan", CL.stage:format(3), args.spellId)
	self:PlaySound("stages", "long")
	self:CDBar(111570, 6.1) -- Death's Grasp
	self:CDBar(111775, 18.2) -- Shadow Shiv
end
