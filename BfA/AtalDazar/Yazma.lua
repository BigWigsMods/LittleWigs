--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yazma", 1204, 2030)
if not mod then return end
mod:RegisterEnableMob(122968)
mod.engageId = 2087

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		249923, -- Soulrend
		250096, -- Wracking Pain
		250050, -- Echoes of Shadra
		250036, -- Shadowy Remains
		{249919, "TANK"}, -- Skewer
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Soulrend", 249923)
	self:Log("SPELL_CAST_START", "WrackingPain", 250096)
	self:Log("SPELL_CAST_START", "EchoesofShadra", 250050)
	self:Log("SPELL_AURA_APPLIED", "ShadowyRemains", 250036)
	self:Log("SPELL_PERIODIC_DAMAGE", "ShadowyRemains", 250036)
	self:Log("SPELL_PERIODIC_MISSED", "ShadowyRemains", 250036)
	self:Log("SPELL_CAST_START", "Skewer", 249919)
end

function mod:OnEngage()
	self:Bar(250096, 4) -- Wracking Pain
	self:Bar(249923, 6.4) -- Soulrend
	self:Bar(250050, 23.4) -- Echoes of Shadra
	self:Bar(249919, 29) -- Skewer
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Soulrend(args)
	self:TargetMessage(args.spellId, args.destName, "red", "Warning")
	self:Bar(args.spellId, 26.5)
end

function mod:WrackingPain(args)
	self:Message(args.spellId, "orange", self:Interrupter() and "Alert")
	self:Bar(args.spellId, 11)
end

function mod:EchoesofShadra(args)
	self:Message(args.spellId, "yellow", "Info")
	self:Bar(args.spellId, 26.5)
end

do
	local prev = 0
	function mod:ToxicPool(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then
			prev = GetTime()
			self:Message(args.spellId, "blue", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:Skewer(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:Bar(args.spellId, 25.5)
end
