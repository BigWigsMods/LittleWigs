--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Orator Krix'vizk", 2669, 2594)
if not mod then return end
mod:RegisterEnableMob(216619) -- Orator Krix'vizk
mod:SetEncounterID(2907)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local subjugateCount = 1
local terrorizeCount = 1
local vociferousIndoctrinationCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		434722, -- Subjugate
		434779, -- Terrorize
		434829, -- Vociferous Indoctrination
		434926, -- Lingering Influence
		{448561, "SAY", "SAY_COUNTDOWN"}, -- Shadows of Doubt (Mythic)
	}, {
		[448561] = CL.mythic, -- Shadows of Doubt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Subjugate", 434722)
	self:Log("SPELL_CAST_START", "Terrorize", 434779)
	self:Log("SPELL_CAST_START", "VociferousIndoctrination", 434829)
	self:Log("SPELL_AURA_REMOVED", "VociferousIndoctrinationOver", 434829)
	self:Log("SPELL_PERIODIC_DAMAGE", "LingeringInfluenceDamage", 434926)

	-- Mythic
	self:Log("SPELL_CAST_SUCCESS", "ShadowsOfDoubt", 448560)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfDoubtApplied", 448561)
	self:Log("SPELL_AURA_REMOVED", "ShadowsOfDoubtRemoved", 448561)
end

function mod:OnEngage()
	subjugateCount = 1
	terrorizeCount = 1
	vociferousIndoctrinationCount = 1
	self:CDBar(434722, 4.5) -- Subjugate
	self:CDBar(434779, 9.4) -- Terrorize
	if self:Mythic() then
		self:CDBar(448561, 15.2) -- Shadows of Doubt
	end
	self:CDBar(434829, 25.1, CL.count:format(self:SpellName(434829), vociferousIndoctrinationCount)) -- Vociferous Indoctrination
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Subjugate(args)
	-- cast at ~16 and ~88 energy
	self:Message(args.spellId, "purple")
	subjugateCount = subjugateCount + 1
	if subjugateCount % 2 == 0 then
		self:CDBar(args.spellId, 17.1)
	else
		self:CDBar(args.spellId, 12.0)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:Terrorize(args)
	-- cast at ~36 and ~68 energy
	self:Message(args.spellId, "orange")
	terrorizeCount = terrorizeCount + 1
	if terrorizeCount % 2 == 0 then
		self:CDBar(args.spellId, 8.1)
	else
		self:CDBar(args.spellId, 21.1)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:VociferousIndoctrination(args)
	-- cast at 100 energy
	self:StopBar(CL.count:format(args.spellName, vociferousIndoctrinationCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, vociferousIndoctrinationCount))
	vociferousIndoctrinationCount = vociferousIndoctrinationCount + 1
	-- 1s cast + 4s channel + 25s energy gain + ~0.3s delay
	self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, vociferousIndoctrinationCount))
	self:PlaySound(args.spellId, "long")
end

function mod:VociferousIndoctrinationOver(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:LingeringInfluenceDamage(args)
		local t = args.time
		if t - prev > 1.5 and self:Me(args.destGUID) then
			prev = t
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Mythic

do
	local playerList = {}

	function mod:ShadowsOfDoubt()
		-- begins cast at ~50 energy
		playerList = {}
		self:CDBar(448561, 30.3)
	end

	function mod:ShadowsOfDoubtApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Shadows of Doubt")
			self:SayCountdown(args.spellId, 6)
		end
		self:PlaySound(args.spellId, "alarm", nil, playerList)
	end

	function mod:ShadowsOfDoubtRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end
