--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("K.U.-J.0.", 2097, 2339)
if not mod then return end
mod:RegisterEnableMob(144246) -- K.U.-J.0.
mod:SetEncounterID(2258)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local airDropCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		291930, -- Air Drop
		{291946, "CASTBAR"}, -- Venting Flames
		{291973, "SAY"}, -- Explosive Leap
		{294929, "TANK_HEALER"}, -- Blazing Chomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AirDrop", 291918)
	self:Log("SPELL_CAST_START", "VentingFlames", 291946)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 291973)
	self:Log("SPELL_AURA_APPLIED", "ExplosiveLeapApplied", 291972)
	self:Log("SPELL_AURA_APPLIED", "BlazingChompApplied", 294929)
end

function mod:OnEngage()
	airDropCount = 0
	self:Bar(291930, 7.1) -- Air Drop
	self:Bar(294929, 10.9) -- Blazing Chomp
	self:Bar(291946, 15.6) -- Venting Flames
	self:Bar(291973, 38) -- Explosive Leap
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AirDrop(args)
	airDropCount = airDropCount + 1
	self:Message(291930, "yellow")
	self:PlaySound(291930, "info")
	self:Bar(291930, airDropCount == 1 and 26.7 or 34) -- Second air drop is a shorter timer
end

function mod:VentingFlames(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 6)
	self:Bar(args.spellId, 32)
end

do
	local playerList = {}

	function mod:ExplosiveLeap(args)
		playerList = {}
		self:CDBar(args.spellId, 30)
	end

	function mod:ExplosiveLeapApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(291973, "alert", nil, playerList)
		self:TargetsMessage(291973, "orange", playerList, 4)
		if self:Me(args.destGUID) then
			self:Say(291973, nil, nil, "Explosive Leap")
		end
	end
end

function mod:BlazingChompApplied(args)
	self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 16) -- Varies, one of these numbers: 15.8, 17, 18.2, 19.4
end
