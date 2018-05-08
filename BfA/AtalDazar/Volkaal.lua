if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'kaal", 1763, 2036)
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
	self:Log("SPELL_CAST_SUCCESS", "NoxiousStench", 259572, 250368) -- Stage 1, Stage 2
	self:Log("SPELL_CAST_SUCCESS", "RapidDecay", 250241) -- Stage 2 start
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
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:Bar(args.spellId, 6)
end

function mod:NoxiousStench(args)
	self:Message(259572, "red")
	if args.spellId == 250368 then -- Stage 2 cast not interruptable
		self:PlaySound(259572, "alert")
	elseif self:Interrupter() then
		self:PlaySound(259572, "warning", "interrupt")
	end
	self:Bar(259572, args.spellId == 250368 and 18.2 or 24.3)
end

function mod:RapidDecay(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info", "stage2")
	self:Bar(259572, 4.5) -- Noxious Stench
end

do
	local prev = 0
	function mod:ToxicPool(args)
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
