--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yazma", 1763, 2030)
if not mod then return end
mod:RegisterEnableMob(122968)
mod:SetEncounterID(2087)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259187, -- Soulrend
		250096, -- Wracking Pain
		250050, -- Echoes of Shadra
		250036, -- Shadowy Remains
		{249919, "TANK_HEALER"}, -- Skewer
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Soulrend", 259187)
	self:Log("SPELL_CAST_START", "WrackingPain", 250096)
	self:Log("SPELL_CAST_START", "EchoesofShadra", 250050)
	self:Log("SPELL_PERIODIC_DAMAGE", "ShadowyRemains", 250036) -- don't track APPLIED - doesn't damage on application
	self:Log("SPELL_PERIODIC_MISSED", "ShadowyRemains", 250036)
	self:Log("SPELL_CAST_START", "Skewer", 249919)
end

function mod:OnEngage()
	self:CDBar(250096, 3.3) -- Wracking Pain
	self:CDBar(249919, 5.7) -- Skewer
	self:CDBar(259187, 9.7) -- Soulrend
	self:CDBar(250050, 15.4) -- Echoes of Shadra
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Soulrend(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "runaway")
	self:CDBar(args.spellId, 41.2)
end

function mod:WrackingPain(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	local _, ready = self:Interrupter()
	if ready then
		self:PlaySound(args.spellId, "alert", "interrupt")
	end
	self:CDBar(args.spellId, 17.0) -- 17-24
end

function mod:EchoesofShadra(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "watchstep")
	self:CDBar(args.spellId, 31.6) -- 31-35
end

do
	local prev = 0
	function mod:ShadowyRemains(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", "gtfo", args.destName)
			end
		end
	end
end

function mod:Skewer(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert", "defensive")
	self:CDBar(args.spellId, 12.1) -- 12-17
end
