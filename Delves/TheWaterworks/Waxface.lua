--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Waxface", 2683)
if not mod then return end
mod:RegisterEnableMob(214263) -- Waxface
mod:SetEncounterID(2894)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local nextThrowWax = 0
local nextBurnAway = 0
local nextNoxiousGas = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.waxface = "Waxface"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.waxface
end

function mod:GetOptions()
	return {
		450330, -- Throw Wax
		450142, -- Burn Away
		450128, -- Noxious Gas
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ThrowWax", 450330)
	self:Log("SPELL_CAST_START", "NoxiousGas", 450128)
	self:Log("SPELL_CAST_START", "BurnAway", 450142)
end

function mod:OnEngage()
	local t = GetTime()
	nextNoxiousGas = t + 3.4
	self:CDBar(450128, 3.4) -- Noxious Gas
	nextThrowWax = t + 10.7
	self:CDBar(450330, 10.7) -- Throw Wax
	nextBurnAway = t + 18.1
	self:CDBar(450142, 18.1) -- Burn Away
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name)
		self:TargetMessage(450330, "yellow", name)
		self:PlaySound(450330, "alert", nil, name)
	end

	function mod:ThrowWax(args)
		local t = GetTime()
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		nextThrowWax = t + 17.0
		self:CDBar(args.spellId, 17.0)
		-- 7.26 minimum to next ability
		if nextNoxiousGas - t < 7.26 then
			nextNoxiousGas = t + 7.26
			self:CDBar(450128, {7.26, 14.6}) -- Noxious Gas
		end
		if nextBurnAway - t < 7.26 then
			nextBurnAway = t + 7.26
			self:CDBar(450142, {7.26, 24.2}) -- Burn Away
		end
	end
end

function mod:NoxiousGas(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	nextNoxiousGas = t + 14.6
	self:CDBar(args.spellId, 14.6)
	-- 6.47 minimum to next ability
	if nextThrowWax - t < 6.47 then
		nextThrowWax = t + 6.47
		self:CDBar(450330, {6.47, 17.0}) -- Throw Wax
	end
	if nextBurnAway - t < 6.47 then
		nextBurnAway = t + 6.47
		self:CDBar(450142, {6.47, 24.2}) -- Burn Away
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:BurnAway(args)
	local t = GetTime()
	self:Message(args.spellId, "red")
	nextBurnAway = t + 24.2
	self:CDBar(args.spellId, 24.2)
	-- 9.68 minimum to next ability
	if nextThrowWax - t < 9.68 then
		nextThrowWax = t + 9.68
		self:CDBar(450330, {9.68, 17.0}) -- Throw Wax
	end
	if nextNoxiousGas - t < 9.68 then
		nextNoxiousGas = t + 9.68
		self:CDBar(450128, {9.68, 14.6}) -- Noxious Gas
	end
	self:PlaySound(args.spellId, "alert")
end
