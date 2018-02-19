-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Zanzil", 859, 184)
if not mod then return end
mod:RegisterEnableMob(52053)

--------------------------------------------------------------------------------
--  Locals

local gaze = GetSpellInfo(96342) -- Pursuit

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		96914, -- Zanzili Fire
		96316, -- Zanzil's Resurrection Elixir
		96338, -- Zanzil's Graveyard Gas
		96342, -- Pursuit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Fire", 96914)
	self:Log("SPELL_AURA_APPLIED", "Elixir", 96316)
	self:Log("SPELL_CAST_START", "Gas", 96338)
	self:Log("SPELL_CAST_START", "Gaze", 96342)
	self:Log("SPELL_AURA_APPLIED", "Pursuit", 96506)
	self:Log("SPELL_AURA_REMOVED", "PursuitRemoved", 96506)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 52053)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Fire(args)
	if UnitIsPlayer(args.sourceName) then return end
	self:Message(args.spellId, spellName, "Attention", spellId, "Info")
end

function mod:Elixir(args)
	self:Message(args.spellId, spellName, "Attention", spellId, "Alert")
end

function mod:Gas(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 7)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Flash(96342)
		end
		self:TargetMessage(96342, player, "Important", "Alert")
		self:PrimaryIcon(96342, player)
	end

	function mod:Gaze(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:Pursuit(args)
	self:TargetMessage(96342, args.destName, "Important", "Alert")
	self:PrimaryIcon(96342, args.destName)
end

function mod:PursuitRemoved()
	self:PrimaryIcon(args.destName)
end
