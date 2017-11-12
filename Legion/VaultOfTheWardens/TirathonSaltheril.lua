
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
		191823, -- Furious Blast
		192504, -- Havoc Metamorphosis
		202740, -- Vengeance Metamorphosis
		190830, -- Hatred 
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "DarkstrikesCast", 191941, 204151)
	self:Log("SPELL_AURA_APPLIED", "DarkstrikesApplied", 191941)
	self:Log("SPELL_AURA_APPLIED", "Vengeance", 202740)
	self:Log("SPELL_AURA_APPLIED", "Havoc", 192504)
	self:Log("SPELL_AURA_APPLIED", "FuriousFlamesApplied", 191853)
	self:Log("SPELL_CAST_START", "FuriousBlast", 191823)
end

function mod:OnEngage()
	self:CDBar(191941, 5.2)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkstrikesCast(args)
	self:Message(191941, "Important", self:Tank() and "Alarm", CL.casting:format(args.spellName))
	self:CDBar(191941, 31)
end

function mod:DarkstrikesApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:Havoc(args)
	self:Message(args.spellId, "Neutral", "Info")
	self:StopBar(191941) --Vengeance Darkstrikes
	self:CDBar(191941, 24) -- Darkstrikes
	self:CDBar(190830, 14.5) -- Hatred
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 190830 then -- Hatred
		self:Message(190830, "Attention", "Warning", spellName)
		self:Bar(190830, 10, CL.cast:format(spellName))
		self:CDBar(190830, 30) 
	end
end

function mod:Vengeance(args)
	self:Message(args.spellId, "Neutral", "Info")
	self:StopBar(191941) --Vengeance Darkstrikes
end

function mod:FuriousFlamesApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
	end
end

function mod:FuriousBlast(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
end
