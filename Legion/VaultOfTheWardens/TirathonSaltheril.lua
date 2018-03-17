--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tirathon Saltheril", 1493, 1467)
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
		190830, -- Hatred
		192504, -- Metamorphosis (Havoc)
		202740, -- Metamorphosis (Vengeance)
	}, {
		[192504] = 192504 -- Metamorphosis
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
	self:CDBar(191941, 5.2) -- Darkstrikes
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
	self:CDBar(191941, 24) -- Darkstrikes
	self:CDBar(190830, 14.5) -- Hatred
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName, _, _, spellId)
	if spellId == 190830 then -- Hatred
		self:Message(spellId, "Attention", "Warning")
		self:Bar(spellId, 10, CL.cast:format(spellName))
		self:CDBar(spellId, 30)
	end
end

function mod:Vengeance(args)
	self:Message(args.spellId, "Neutral", "Info")
	self:StopBar(191941) -- Darkstrikes
end

function mod:FuriousFlamesApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
	end
end

function mod:FuriousBlast(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
end
