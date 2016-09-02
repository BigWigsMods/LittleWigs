
--------------------------------------------------------------------------------
-- TODO List:
-- - Check timers

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Inquisitor Tormentorum", 1045, 1695)
if not mod then return end
mod:RegisterEnableMob(96015)
mod.engageId = 1850

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200898, -- Teleport
		202455, -- Void Shield
		212564, -- Inquisitive Stare
		{200904, "FLASH"}, -- Sapped Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Teleport", 200898)
	self:Log("SPELL_AURA_APPLIED", "VoidShieldApplied", 202455)
	self:Log("SPELL_AURA_REMOVED", "VoidShieldRemoved", 202455)
	self:Log("SPELL_AURA_APPLIED", "InquisitiveStare", 212564)
	self:Log("SPELL_AURA_REFRESH", "InquisitiveStare", 212564)
	self:Log("SPELL_AURA_APPLIED", "SapSoul", 206303)
	self:Log("SPELL_AURA_APPLIED", "SappedSoul", 200904)
	self:Log("SPELL_AURA_REFRESH", "SappedSoul", 200904)
end

function mod:OnEngage()
	self:Bar(200898, 28.7) -- Teleport
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Teleport(args)
	self:Message(args.spellId, "Attention", "Info", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 69)
end

function mod:VoidShieldApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Neutral", "Info", nil, nil, true)
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:VoidShieldRemoved(args)
	self:Message(args.spellId, "Positive", "Info", CL.removed(args.spellName))
end

do
	local prev = 0
	function mod:InquisitiveStare(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 0.5 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm")
		end
	end
end

function mod:SapSoul(args)
	if self:Me(args.destGUID) then
		self:Message(200904, "Attention", "Info", CL.incoming:format(self:SpellName(200904)))
	end
end

do
	local prev = 0
	function mod:SappedSoul(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 0.5 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "Important", "Long")
			self:Flash(args.spellId)
		end
	end
end
