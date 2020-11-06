--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("K.U.-J.0.", 2097, 2339)
if not mod then return end
mod:RegisterEnableMob(144246)
mod.engageId = 2258

--------------------------------------------------------------------------------
-- Locals
--

local airDropCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		291918, -- Air Drop
		291946, -- Venting Flames
		{291973, "PROXIMITY", "SAY"}, -- Explosive Leap
		{294929, "TANK_HEALER"}, -- Blazing Chomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AirDrop", 291918)
	self:Log("SPELL_CAST_START", "VentingFlames", 291946)
	self:Log("SPELL_CAST_START", "ExplosiveLeap", 291973)
	self:Log("SPELL_AURA_APPLIED", "ExplosiveLeapApplied", 291972)
	self:Log("SPELL_AURA_REMOVED", "ExplosiveLeapRemoved", 291972)
	self:Log("SPELL_AURA_APPLIED", "BlazingChompApplied", 294929)
end

function mod:OnEngage()
	airDropCount = 0
	self:Bar(291918, 7.1) -- Air Drop
	self:Bar(294929, 10.9) -- Blazing Chomp
	self:Bar(291946, 15.6) -- Venting Flames
	self:Bar(291973, 38) -- Explosive Leap
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AirDrop(args)
	airDropCount = airDropCount + 1
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, (airDropCount == 1) and 26.7 or 34) -- Second air drop is a shorter timer
end

function mod:VentingFlames(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 6)
	self:Bar(args.spellId, 32)
end

function mod:ExplosiveLeap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 30)
end

do
	local isOnMe = false
	local proxList = {}
	function mod:ExplosiveLeapApplied(args)
		if self:Me(args.destGUID) then
			isOnMe = true
			self:Say(291973)
		end
		proxList[#proxList+1] = args.destName
		self:OpenProximity(291973, 10, not isOnMe and proxList)
	end

	function mod:ExplosiveLeapRemoved(args)
		tDeleteItem(proxList, args.destName)
		if self:Me(args.destGUID) then
			isOnMe = false
		end
		if #proxList == 0 then
			self:CloseProximity(291973)
		end
	end
end

function mod:BlazingChompApplied(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 16) -- Varies, one of these numbers: 15.8, 17, 18.2, 19.4
end
