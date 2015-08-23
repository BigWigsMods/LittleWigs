
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ragewing the Untamed", 995, 1229)
if not mod then return end
mod:RegisterEnableMob(76585)

--------------------------------------------------------------------------------
-- Locals
--

local percent = 70

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
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "BurningRage", 155620)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurningRage", 155620)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "EngulfingFire", "boss1")

	self:Log("SPELL_AURA_APPLIED", "SwirlingWinds", 167203)
	self:Log("SPELL_AURA_REMOVED", "SwirlingWindsOver", 167203)

	self:Log("SPELL_AURA_APPLIED", "MagmaPool", 155057)

	self:Death("Win", 76585)
end

function mod:OnEngage()
	percent = 70
	self:CDBar(154996, 15.7) -- Engulfing Fire
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurningRage(args)
	self:Message(args.spellId, "Urgent", self:Dispeller("enrage", true) and "Info", CL.onboss:format(args.spellName))
	if self:Dispeller("enrage", true) then
		self:Flash(args.spellId)
	end
end

function mod:EngulfingFire(_, _, _, _, spellId)
	if spellId == 154996 then -- Engulfing Fire
		self:Message(spellId, "Attention", "Warning")
		self:Flash(spellId)
		self:CDBar(spellId, 24) -- 24-28
	end
end

function mod:SwirlingWinds()
	self:Message(-10740, "Important", "Long", ("%d%% - %s"):format(percent, self:SpellName(93679)), 93679) -- 93679 = Summon Whelps
	self:Bar(-10740, 20, CL.intermission, 93679) -- Whelp icon
	self:StopBar(155025) -- Engulfing Fire
end

function mod:SwirlingWindsOver()
	if percent == 70 then
		self:CDBar(154996, self:Normal() and 9.3 or 12.8) -- Engulfing Fire
		percent = 40
	end
end

function mod:MagmaPool(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

