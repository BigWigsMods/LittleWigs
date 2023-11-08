--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Manifested Timeways", 2579, 2528)
if not mod then return end
mod:RegisterEnableMob(198996) -- Manifested Timeways
mod:SetEncounterID(2667)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{405696, "SAY"}, -- Chrono-faded
		405431, -- Fragments of Time
		414303, -- Unwind
		414307, -- Radiant
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Chronofaded", 405696)
	self:Log("SPELL_AURA_APPLIED", "ChronofadedApplied", 404141)
	self:Log("SPELL_CAST_START", "FragmentsOfTime", 405431)
	self:Log("SPELL_CAST_START", "Unwind", 414303)
	self:Log("SPELL_CAST_START", "Radiant", 414307)
end

function mod:OnEngage()
	-- Unwind is not cast in M+, removed from dungeon journal in all difficulties
	-- TODO apparently still cast in hardmode in 10.2 - any way to detect hardmode?
	--self:CDBar(414303, 5.8) -- Unwind
	self:CDBar(405431, 15.5) -- Fragments of Time
	self:CDBar(405696, 30.1) -- Chrono-faded
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:Chronofaded(args)
		playerList = {}
		self:CDBar(args.spellId, 30.3)
	end

	function mod:ChronofadedApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(405696, "orange", playerList, 2)
		self:PlaySound(405696, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(405696)
			-- ticks 4x as fast when standing in Accelerating Time so can't really do a countdown
		end
	end
end

function mod:FragmentsOfTime(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 30.3)
end

function mod:Unwind(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.3)
end

function mod:Radiant(args)
	-- only cast when the tank is not in melee range
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end
