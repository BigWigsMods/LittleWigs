
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yazma", 1763, 2030)
if not mod then return end
mod:RegisterEnableMob(122968)
mod.engageId = 2087
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259187, -- Soulrend
		250096, -- Wracking Pain
		250050, -- Echoes of Shadra
		250036, -- Shadowy Remains
		{249919, "TANK"}, -- Skewer
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Soulrend", 259187)
	self:Log("SPELL_CAST_START", "WrackingPain", 250096)
	self:Log("SPELL_CAST_START", "EchoesofShadra", 250050)
	self:Log("SPELL_AURA_APPLIED", "ShadowyRemains", 250036)
	self:Log("SPELL_PERIODIC_DAMAGE", "ShadowyRemains", 250036)
	self:Log("SPELL_PERIODIC_MISSED", "ShadowyRemains", 250036)
	self:Log("SPELL_CAST_START", "Skewer", 249919)
end

function mod:OnEngage()
	self:Bar(250096, 3.7) -- Wracking Pain
	self:Bar(259187, 9.7) -- Soulrend
	self:Bar(250050, 15.8) -- Echoes of Shadra
	self:Bar(249919, 6.1) -- Skewer
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Soulrend(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "runaway")
	self:Bar(args.spellId, 41)
end

function mod:WrackingPain(args)
	self:Message(args.spellId, "orange")
	local _, ready = self:Interrupter()
	if ready then
		self:PlaySound(args.spellId, "alert", "interrupt")
	end
	self:CDBar(args.spellId, 17) -- 17-24
end

function mod:EchoesofShadra(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info", "watchstep")
	self:CDBar(args.spellId, 31.6) -- 31-35
end

do
	local prev = 0
	function mod:ShadowyRemains(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "alarm", "gtfo")
			end
		end
	end
end

function mod:Skewer(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "defensive")
	self:CDBar(args.spellId, 12) -- 12-17
end
