--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'kaal", 1204, 2036)
if not mod then return end
mod:RegisterEnableMob(122965)
mod.engageId = 2085

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		250258, -- Toxic Leap
		259572, -- Noxious Stench
		250241, -- Rapid Decay
		250585, -- Toxic Pool
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ToxicLeap", 250258)
	self:Log("SPELL_CAST_SUCCESS", "NoxiousStench", 259572, 250368) -- stage 1, stage 2 XXX Can you interupt the stage 2 version?
	self:Log("SPELL_CAST_SUCCESS", "RapidDecay", 250241) -- Stage 2
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 250585)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 250585)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 250585)
end

function mod:OnEngage()
	self:Bar(250258, 2) -- Toxic Leap
	self:Bar(259572, 6) -- Noxious Stench
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ToxicLeap(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:Bar(args.spellId, 6)
end

function mod:NoxiousStench(args)
	self:Message(args.spellId, "red", self:Interrupter() and "Warning")
	self:Bar(args.spellId, 19.5)
end

function mod:RapidDecay(args)
	self:Message(args.spellId, "green", "Info")
	self:Bar(259572, 4.5) -- Noxious Stench
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
