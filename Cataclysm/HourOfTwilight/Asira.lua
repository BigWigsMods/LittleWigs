--------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Asira Dawnslayer", 940, 342)
if not mod then return end
mod:RegisterEnableMob(54968) -- Asira Dawnslayer
mod:SetEncounterID(1340)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		102726, -- Mark of Silence
		103558, -- Choking Smoke Bomb
		103419, -- Blade Barrier
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "MarkOfSilence", 102726)
	self:Log("SPELL_AURA_APPLIED", "MarkOfSilenceApplied", 102726)
	self:Log("SPELL_CAST_SUCCESS", "ChokingSmokeBomb", 103558)
	self:Log("SPELL_CAST_SUCCESS", "BladeBarrier", 103419)
end

function mod:OnEngage()
	self:CDBar(103558, 10.9) -- Choking Smoke Bomb
end

--------------------------------------------------------------------------------
--  Event Handlers
--

do
	local playerList = {}

	function mod:MarkOfSilence(args)
		playerList = {}
		self:CDBar(args.spellId, 8.5)
	end

	function mod:MarkOfSilenceApplied(args)
		playerList[#playerList + 1] = args.destName
		if self:Me(args.destGUID) then
			-- only play a sound if on you
			self:PlaySound(args.spellId, "alarm", nil, args.destName)
		end
		self:TargetsMessage(args.spellId, "yellow", playerList, 2)
	end
end

function mod:ChokingSmokeBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23.0)
end

function mod:BladeBarrier(args)
	self:Message(args.spellId, "red", CL.percent:format(30, args.spellName))
	self:PlaySound(args.spellId, "long")
end
