if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Watcher Irideus", 2527, 2504)
if not mod then return end
mod:RegisterEnableMob(189719) -- Watcher Irideus
mod:SetEncounterID(2615)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.stacks_left = "%s (%d/%d)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stage 1
		389179, -- Power Overload
		384351, -- Spark Volley
		384014, -- Static Surge
		384524, -- Titanic Fist
		-- Stage 2
		389446, -- Nullifying Pulse
		383840, -- Ablative Barrier
	}, {
		[389179] = -25745, -- Stage One: A Chance at Redemption
		[389446] = -25744, -- Stage Two: Watcher's Last Stand
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_START", "PowerOverload", 389179)
	self:Log("SPELL_CAST_START", "SparkVolley", 384351)
	self:Log("SPELL_CAST_START", "StaticSurge", 384014)
	self:Log("SPELL_CAST_START", "TitanicFist", 384524)

	-- Stage 2
	self:Log("SPELL_CAST_START", "NullifyingPulse", 389446)
	self:Log("SPELL_AURA_APPLIED", "AblativeBarrierApplied", 383840)
	self:Log("SPELL_AURA_REMOVED_DOSE", "AblativeBarrierRemovedDose", 383840)
	self:Log("SPELL_AURA_REMOVED", "AblativeBarrierRemoved", 383840)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(384524, 5.7) -- Titanic Fist
	self:CDBar(384014, 10.5) -- Static Surge
	self:CDBar(389179, 21.4) -- Power Overload
	self:CDBar(383840, 27.5) -- Ablative Barrier
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1

function mod:PowerOverload(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 57.1) -- TODO maybe this is some time (16.84, 17.2?) after barrier removed instead
end

function mod:SparkVolley(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	-- TODO bar?
end

function mod:StaticSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
	self:CDBar(args.spellId, 17)
end

function mod:TitanicFist(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- TODO bar?
end

-- Stage 2

function mod:NullifyingPulse(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:AblativeBarrierApplied(args)
	self:SetStage(2)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	-- TODO more stopbars?
	self:StopBar(384014) -- Static Surge
	-- TODO add spawn bar?
end

function mod:AblativeBarrierRemovedDose(args)
	local stacksRemaining = 3 - args.amount
	self:Message(args.spellId, "yellow", L.stacks_left:format(CL.removed:format(args.spellName), stacksRemaining, 3))
	self:PlaySound(args.spellId, "info")
end

function mod:AblativeBarrierRemoved(args)
	self:SetStage(1)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	-- TODO restart bars?
end
