
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naltira", 1079, 1500)
if not mod then return end
mod:RegisterEnableMob(98207)
mod.engageId = 1826

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.vicious_manafang = -13765
	L.vicious_manafang_desc = -13766 -- Devour
	L.vicious_manafang_icon = "inv_misc_monsterspidercarapace_01"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-12687, -- Blink Strikes
		{200040, "FLASH"}, -- Nether Venom
		{200227, "PROXIMITY"}, -- Tangled Web
		"vicious_manafang", -- Vicious Manafang
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "NetherVenom", 200040)
	self:Log("SPELL_PERIODIC_DAMAGE", "NetherVenomDamage", 200040)
	self:Log("SPELL_AURA_APPLIED", "TangledWebApplied", 200227)
	self:Log("SPELL_AURA_REMOVED", "TangledWebRemoved", 200227)
end

function mod:OnEngage()
	self:Bar(-12687, 16) -- Blink Strikes
	-- self:Bar("vicious_manafang", 20, L.vicious_manafang, L.vicious_manafang_icon) -- Vicious Manafang
	-- self:ScheduleTimer("ViciousManafang", 20)
	self:Bar(200040, 26) -- Nether Venom
	self:Bar(200227, 37) -- Tangled Web

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "boss1") -- no CLEU event for Blink Strikes
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(spellName, _, _, spellId)
	if spellId == 199809 then -- Blink Strikes
		self:Message(-12687, "Urgent")
		self:Bar(-12687, 30)
	end
end

function mod:ViciousManafang()
	self:Message("vicious_manafang", "Attention", self:Tank() and "Info", L.spawned:format(L.vicious_manafang), false)
	self:Bar("vicious_manafang", 20, L.vicious_manafang, L.vicious_manafang_icon)
	self:ScheduleTimer("ViciousManafang", 20)
end

do
	local targets, isOnMe = {}
	local function printTarget(self, spellId)
		if isOnMe then
			self:OpenProximity(spellId, 30, targets)
		end
		self:TargetMessage(spellId, self:ColorName(targets), "Attention", "Warning")
		wipe(targets)
		isOnMe = nil
	end

	function mod:TangledWebApplied(args)
		targets[#targets+1] = args.destName
		if #targets == 1 then
			self:ScheduleTimer(printTarget, 0.1, self, args.spellId)
			self:CDBar(args.spellId, 26)
		end
		if self:Me(args.destGUID) then
			isOnMe = true
		end
	end

	function mod:TangledWebRemoved(args)
		if self:Me(args.destName) then
			self:Message(args.spellId, "Personal", nil, CL.removed:format(args.spellName))
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
			self:Message(args.spellId, "Attention")
			self:Bar(args.spellId, 30)
		end
	end
end

do
  local prev = 0
  function mod:NetherVenomDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 2 then
			prev = t
			self:Flash(args.spellId)
			self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
  end
end
