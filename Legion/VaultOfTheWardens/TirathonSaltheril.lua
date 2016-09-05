
--------------------------------------------------------------------------------
-- TODO List:
-- - Might be missing some spells, dunno

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tirathon Saltheril", 1045, 1467)
if not mod then return end
mod:RegisterEnableMob(95885)
mod.engageId = 1815

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		191941, -- Darkstrikes
		191853, -- Furious Flames
		192504, -- Metamorphosis
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkstrikesCast", 191941, 204151)
	self:Log("SPELL_AURA_APPLIED", "DarkstrikesApplied", 191941)
	self:Log("SPELL_AURA_APPLIED", "Metamorphosis", 192504, 202740)
	self:Log("SPELL_AURA_APPLIED", "FuriousFlamesApplied", 191853)
end

function mod:OnEngage()
	self:CDBar(191941, 22)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkstrikesCast(args)
	self:Message(191941, "Important", self:Tank() and "Alarm", CL.casting:format(args.spellName))
	self:Bar(191941, 7, CL.cast:format(args.spellName))
	self:CDBar(191941, 29)
end

function mod:DarkstrikesApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:Metamorphosis(args)
	self:Message(192504, "Neutral", "Info")
end

function mod:FuriousFlamesApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
	end
end
