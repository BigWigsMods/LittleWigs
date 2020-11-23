--------------------------------------------------------------------------------
-- TODO:
-- - Mythic Abilties
-- - Improve timers
-- - Respawn
-- - Stage 2

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Devos, Paragon of Doubt", 2285, 2412)
if not mod then return end
mod:RegisterEnableMob(162061) -- Devos
mod.engageId = 2359
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		334625, -- Abyssal Detonation
		{322818, "SAY", "SAY_COUNTDOWN"}, -- Lost Confidence
		323943, -- Run Through
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AbyssalDetonation", 334625)
	self:Log("SPELL_CAST_SUCCESS", "LostConfidence", 322818)
	self:Log("SPELL_AURA_APPLIED", "LostConfidenceApplied", 322818)
	self:Log("SPELL_AURA_REMOVED", "LostConfidenceRemoved", 322818)
	self:Log("SPELL_CAST_START", "RunThrough", 323943)

end

function mod:OnEngage()
	self:Bar(334625, 23.3) -- Abyssal Detonation
	self:Bar(322818, 16.3) -- Lost Confidence
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AbyssalDetonation(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	--self:Bar(args.spellId, 0)
end

function mod:LostConfidence(args)
	self:Bar(args.spellId, 20)
end

do
	local playerList = mod:NewTargetList()
	function mod:LostConfidenceApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 15)
			self:PlaySound(args.spellId, "alarm")
		end
		self:TargetsMessage(args.spellId, "yellow", playerList)
	end

	function mod:LostConfidenceRemoved(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:RunThrough(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 20)
end
