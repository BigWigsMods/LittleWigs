
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ragewing the Untamed", 1358, 1229)
if not mod then return end
mod:RegisterEnableMob(76585)
mod.engageId = 1760
mod.respawnTime = 11

--------------------------------------------------------------------------------
-- Locals
--

local nextAddsWarning = 75

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{155620, "FLASH"}, -- Burning Rage
		155057, -- Magma Pool
		{154996, "FLASH"}, -- Engulfing Fire
		-10740, -- Ragewing Whelp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BurningRage", 155620)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurningRage", 155620)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "EngulfingFire", "boss1")

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "SwirlingWinds", 167203)
	self:Log("SPELL_AURA_REMOVED", "SwirlingWindsOver", 167203)

	self:Log("SPELL_AURA_APPLIED", "MagmaPool", 155057)
end

function mod:OnEngage()
	nextAddsWarning = 75 -- 70% and 40%
	self:CDBar(154996, 15.7) -- Engulfing Fire
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurningRage(args)
	self:MessageOld(args.spellId, "orange", self:Dispeller("enrage", true) and "info", CL.onboss:format(args.spellName))
	if self:Dispeller("enrage", true) then
		self:Flash(args.spellId)
	end
end

function mod:EngulfingFire(_, _, _, spellId)
	if spellId == 154996 then -- Engulfing Fire
		self:MessageOld(spellId, "yellow", "warning")
		self:Flash(spellId)
		self:CDBar(spellId, 24) -- 24-28
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < nextAddsWarning then
		nextAddsWarning = nextAddsWarning - 30
		self:MessageOld(-10740, "green", nil, CL.soon:format(self:SpellName(93679)), false)
		if nextAddsWarning < 40 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:SwirlingWinds()
	self:MessageOld(-10740, "red", "long", CL.percent:format(nextAddsWarning + 25, self:SpellName(93679)), 93679) -- 93679 = Summon Whelps
	self:Bar(-10740, 20, CL.intermission, 93679) -- Whelp icon
	self:StopBar(155025) -- Engulfing Fire
end

function mod:SwirlingWindsOver()
	if nextAddsWarning > 40 then
		self:CDBar(154996, self:Normal() and 9.3 or 12.8) -- Engulfing Fire
	end
end

function mod:MagmaPool(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
	end
end
