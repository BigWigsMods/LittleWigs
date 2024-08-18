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

local vociferousIndoctrinationCount = 1
local nextSubjugate = 0
local nextTerrorize = 0

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
	local t = GetTime()
	vociferousIndoctrinationCount = 1
	nextSubjugate = t + 4.5
	self:CDBar(434722, 4.5) -- Subjugate
	nextTerrorize = t + 8.1
	self:CDBar(434779, 8.1) -- Terrorize
	if self:Mythic() then
		self:CDBar(448561, 15.3) -- Shadows of Doubt
	end
	self:CDBar(434829, 25.1, CL.count:format(self:SpellName(434829), vociferousIndoctrinationCount)) -- Vociferous Indoctrination
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Subjugate(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	nextSubjugate = GetTime() + 12.8
	self:CDBar(args.spellId, 12.8)
end

function mod:Terrorize(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	nextTerrorize = GetTime() + 8.1
	self:CDBar(args.spellId, 8.1)
end

function mod:VociferousIndoctrination(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, vociferousIndoctrinationCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, vociferousIndoctrinationCount))
	self:PlaySound(args.spellId, "long")
	vociferousIndoctrinationCount = vociferousIndoctrinationCount + 1
	self:CDBar(args.spellId, 30.3, CL.count:format(args.spellName, vociferousIndoctrinationCount))
	-- 10.91 minimum to Subjugate
	if nextSubjugate - t < 10.91 then
		nextSubjugate = t + 10.91
		self:CDBar(434722, {10.91, 12.8}) -- Subjugate
	end
	-- 15.38 minimum to Terrorize
	if nextTerrorize - t < 15.38 then
		nextTerrorize = t + 15.38
		self:CDBar(434779, 15.38) -- Terrorize
	end
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
		playerList = {}
		self:CDBar(448561, 30.3)
	end

	function mod:ShadowsOfDoubtApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Shadows of Doubt")
			self:SayCountdown(args.spellId, 6)
		end
	end

	function mod:ShadowsOfDoubtRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end
