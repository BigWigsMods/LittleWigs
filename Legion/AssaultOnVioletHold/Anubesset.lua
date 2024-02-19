
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'esset", 1544, 1696)
if not mod then return end
mod:RegisterEnableMob(102246)
mod.engageId = 1852

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		202217, -- Mandible Strikes
		{202341, "SAY", "FLASH", "ICON"}, -- Impale
		201863, -- Call of the Swarm
		202480, -- Fixated
		202485, -- Blistering Ooze
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MandibleStrikesCast", 202217)
	self:Log("SPELL_AURA_APPLIED", "MandibleStrikesApplied", 202217)
	self:Log("SPELL_CAST_START", "Impale", 202341)
	self:Log("SPELL_CAST_SUCCESS", "ImpaleEnd", 202341)
	self:Log("SPELL_CAST_START", "CallOfTheSwarm", 201863)
	self:Log("SPELL_AURA_APPLIED", "Fixated", 202480)
	self:Log("SPELL_AURA_APPLIED", "BlisteringOozeDamage", 202485)
	self:Log("SPELL_AURA_REFRESH", "BlisteringOozeDamage", 202485)
end

function mod:OnEngage()
	self:Bar(202217, 9)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MandibleStrikesCast(args)
	self:MessageOld(args.spellId, "yellow", nil, CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 22)
end

function mod:MandibleStrikesApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, self:Healer())
	self:TargetBar(args.spellId, 10, args.destName)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(202341, nil, nil, "Impale")
			self:Flash(202341)
		end
		self:TargetMessageOld(202341, player, "red", "long")
		self:PrimaryIcon(202341, player)
	end

	function mod:Impale(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 22)
	end

	function mod:ImpaleEnd(args)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:CallOfTheSwarm(args)
	self:MessageOld(args.spellId, "orange", "info")
end

function mod:Fixated(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "warning")
	end
end

do
	local prev = 0
	function mod:BlisteringOozeDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
