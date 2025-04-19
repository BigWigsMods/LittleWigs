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

local airDropCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		291930, -- Air Drop
		{291946, "EMPHASIZE", "CASTBAR"}, -- Venting Flames
		{291973, "SAY"}, -- Explosive Leap
		294929, -- Blazing Chomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AirDrop", 291918)
	self:Log("SPELL_CAST_START", "VentingFlames", 291946)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 291973)
	self:Log("SPELL_AURA_APPLIED", "ExplosiveLeapApplied", 291972)
	self:Log("SPELL_CAST_SUCCESS", "BlazingChomp", 294929)
	self:Log("SPELL_AURA_APPLIED", "BlazingChompApplied", 294929)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlazingChompApplied", 294929)
end

function mod:OnEngage()
	airDropCount = 1
	self:CDBar(291930, 5.1) -- Air Drop
	self:CDBar(294929, 10.8) -- Blazing Chomp
	self:CDBar(291946, 15.7) -- Venting Flames
	self:CDBar(291973, 37.9) -- Explosive Leap
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AirDrop(args)
	self:Message(291930, "yellow")
	airDropCount = airDropCount + 1
	if airDropCount == 2 then
		self:CDBar(291930, 26.7)
	else
		self:CDBar(291930, 34.0)
	end
	self:PlaySound(291930, "info")
end

function mod:VentingFlames(args)
	self:Message(args.spellId, "red")
	self:CastBar(args.spellId, 6)
	self:CDBar(args.spellId, 32.8)
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:ExplosiveLeap(args)
		playerList = {}
		self:CDBar(294929, {8.3, 15.4}) -- Blazing Chomp
		self:CDBar(args.spellId, 33.6)
	end

	function mod:ExplosiveLeapApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(291973, "orange", playerList, 3)
		if self:Me(args.destGUID) then
			self:Say(291973, nil, nil, "Explosive Leap")
		end
		self:PlaySound(291973, "alert", nil, playerList)
	end
end

function mod:BlazingChomp(args)
	self:CDBar(args.spellId, 15.4)
end

function mod:BlazingChompApplied(args)
	self:StackMessage(args.spellId, "purple", args.destName, args.amount, 1)
	if self:Dispeller("magic") then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
