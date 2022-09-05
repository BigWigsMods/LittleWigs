
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naltira", 1516, 1500)
if not mod then return end
mod:RegisterEnableMob(98207, 98759) -- Naltira, Vicious Manafang
mod.engageId = 1826

--------------------------------------------------------------------------------
-- Locals
--

local webCount = 1
local blinkCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vicious_manafang = -13765
	L.vicious_manafang_desc = -13766 -- Devour
	L.vicious_manafang_icon = "inv_misc_monsterspidercarapace_01"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-12687, -- Blink Strikes
		{200040, "FLASH"}, -- Nether Venom
		{200284, "PROXIMITY"}, -- Tangled Web
		-- "vicious_manafang", -- Vicious Manafang
		211543, -- Devour
	}, {
		[211543] = L.vicious_manafang,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "NetherVenom", 200040)
	self:Log("SPELL_PERIODIC_DAMAGE", "NetherVenomDamage", 200040)
	self:Log("SPELL_AURA_APPLIED", "TangledWebApplied", 200284)
	self:Log("SPELL_AURA_REMOVED", "TangledWebRemoved", 200284)
	self:Log("SPELL_AURA_APPLIED", "Devour", 211543)
end

function mod:OnEngage()
	webCount = 1
	blinkCount = 1

	self:CDBar(-12687, 16) -- Blink Strikes
	-- self:CDBar("vicious_manafang", 26, L.vicious_manafang, L.vicious_manafang_icon) -- Vicious Manafang
	-- self:ScheduleTimer("ViciousManafang", 26)
	self:CDBar(200040, 26) -- Nether Venom
	self:CDBar(200284, 35) -- Tangled Web

	-- no CLEU event for Blink Strikes
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "BlinkStrikes", "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "BlinkStrikes", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlinkStrikes(_, _, _, spellId)
	if spellId == 199809 then -- UNIT_SPELLCAST_SUCCEEDED
		blinkCount = 1
		self:Bar(-12687, 30)
	elseif spellId == 199811 then -- UNIT_SPELLCAST_CHANNEL_START
		local target = self:UnitName("boss1target")
		self:TargetMessageOld(-12687, target, "orange", "alarm", CL.count:format(self:SpellName(spellId), blinkCount))
		blinkCount = blinkCount + 1
	end
end

-- function mod:ViciousManafang()
-- 	self:MessageOld("vicious_manafang", "yellow", self:Tank() and "info", L.spawned:format(L.vicious_manafang), false)
-- 	self:Bar("vicious_manafang", 20, L.vicious_manafang, L.vicious_manafang_icon)
-- 	self:ScheduleTimer("ViciousManafang", 20)
-- end

function mod:Devour(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "info", nil, nil, true)
end

do
	local targets, isOnMe = {}, nil
	local function printTarget(self, spellId)
		if isOnMe then
			self:OpenProximity(spellId, 30, targets)
		end
		self:TargetMessageOld(spellId, self:ColorName(targets), "yellow", "warning")
		isOnMe = nil
	end

	function mod:TangledWebApplied(args)
		targets[#targets+1] = args.destName
		if #targets == 1 then
			self:ScheduleTimer(printTarget, 0.1, self, args.spellId)
			self:CDBar(args.spellId, webCount == 1 and 26 or 21)
			webCount = webCount + 1
		end
		if self:Me(args.destGUID) then
			isOnMe = true
		end
	end

	function mod:TangledWebRemoved(args)
		if self:Me(args.destName) then
			self:MessageOld(args.spellId, "green", nil, CL.removed:format(args.spellName))
			self:CloseProximity(args.spellId)
		end
	end
end

do
	local prev = 0
	function mod:NetherVenom(args)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			self:MessageOld(args.spellId, "orange")
			self:CDBar(args.spellId, 30)
		end
	end
end

do
	local prev = 0
	function mod:NetherVenomDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Flash(args.spellId)
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
