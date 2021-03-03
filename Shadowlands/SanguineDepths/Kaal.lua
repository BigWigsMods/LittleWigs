
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Kaal", 2284, 2407)
if not mod then return end
mod:RegisterEnableMob(162099)
mod.engageId = 2363
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local piercingBlurCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{323845, "SAY", "FLASH"}, -- Wicked Rush
		323821, -- Piercing Blur
		322903, -- Gloom Squall
		{324086, "SAY"}, -- Shining Radiance
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "WickedRush", 323845)
	self:Log("SPELL_AURA_APPLIED", "WickedRushApplied", 323845)
	self:Log("SPELL_CAST_SUCCESS", "PiercingBlurStart", 323821)
	self:Log("SPELL_CAST_SUCCESS", "PiercingBlur", 323810)
	self:Log("SPELL_CAST_START", "GloomSquall", 322903)
	self:Log("SPELL_CAST_SUCCESS", "ShiningRadiance", 324086)
end

function mod:OnEngage()
	piercingBlurCount = 0
	self:Bar(323845, 5.2) -- Wicked Rush
	self:Bar(323821, 16.7) -- Piercing Blur
	self:Bar(322903, 35.3) -- Gloom Squall
end

--------------------------------------------------------------------------------
-- Event Handlers
--


local function getGloomSquallDelayedTimer(time, duration)
	-- Some casts are delayed if the cast or the subsequent effects would overlap with gloom squall
	local gloomSquallCastTime = 5.5 -- 4 sec cast time, then he waits 1.5 sec before doing anything else
	local gloomSquallTimeLeft = mod:BarTimeLeft(322903)
	if gloomSquallTimeLeft < time + duration then
		return math.max(gloomSquallTimeLeft + gloomSquallCastTime, time)
	end
	return time
end

function mod:WickedRush(args)
	self:Bar(args.spellId, getGloomSquallDelayedTimer(15.8, 5))
end

do
	local playerList = mod:NewTargetList()
	function mod:WickedRushApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
			self:Flash(args.spellId)
		end
	end
end

function mod:PiercingBlurStart(args)
	piercingBlurCount = 0
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, getGloomSquallDelayedTimer(17, 6.6))
	self:Bar(args.spellId, 4.2, CL.count:format(args.spellName, piercingBlurCount+1))
end

function mod:PiercingBlur(args)
	piercingBlurCount = piercingBlurCount + 1
	if piercingBlurCount < 3 then
		self:Bar(323821, 1.2, CL.count:format(args.spellName, piercingBlurCount+1))
	end
end

function mod:GloomSquall(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 38.9)
	self:CastBar(args.spellId, 4)
end

function mod:ShiningRadiance(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end
