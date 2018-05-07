if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yazma", 1763, 2030)
if not mod then return end
mod:RegisterEnableMob(122968)
mod.engageId = 2087

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{249923, "SAY"}, -- Soulrend
		250096, -- Wracking Pain
		250050, -- Echoes of Shadra
		250036, -- Shadowy Remains
		{249919, "TANK"}, -- Skewer
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Soulrend
	--self:Log("SPELL_CAST_START", "Soulrend", 249923)
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("249924") then -- Soulrend
		self:TargetMessage(249923, destName, "red")
		local guid = UnitGUID(destName)
		if self:Me(guid) then
			self:PlaySound(249923, "warning", "runaway")
			self:Say(249923)
			self:SayCountdown(249923, 5)
		end
		self:Bar(249923, 26.5)
	end
end

-- XXX Remove if not needed
-- function mod:Soulrend(args)
--	self:TargetMessage(args.spellId, args.destName, "red", "Warning")
--	self:Bar(args.spellId, 26.5)
-- end

function mod:WrackingPain(args)
	self:Message(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert", "interrupt")
	end
	self:Bar(args.spellId, 11)
end

function mod:EchoesofShadra(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info", "watchstep")
	self:Bar(args.spellId, 26.5)
end

do
	local prev = 0
	function mod:ShadowyRemains(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "blue", nil, CL.underyou:format(args.spellName))
				self:PlaySound(args.spellId, "alarm", "gtfo")
			end
		end
	end
end

function mod:Skewer(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:PlaySound(args.spellId, "alert", "defensive")
	self:Bar(args.spellId, 25.5)
end
