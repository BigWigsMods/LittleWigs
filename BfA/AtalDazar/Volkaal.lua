
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'kaal", 1763, 2036)
if not mod then return end
mod:RegisterEnableMob(122965)
mod.engageId = 2085
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local toxicLeapCount = 0

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
	self:Log("SPELL_CAST_SUCCESS", "NoxiousStench", 259572)
	self:Log("SPELL_CAST_SUCCESS", "RapidDecay", 250241) -- Stage 2 start
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 250585)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 250585)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 250585)
end

function mod:OnEngage()
	toxicLeapCount = 0
	self:Bar(250258, 2) -- Toxic Leap
	self:Bar(259572, 6) -- Noxious Stench
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ToxicLeap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	-- Every third leap has a longer timer, starting with the first
	self:Bar(args.spellId, toxicLeapCount % 3 == 0 and 9 or 6)
	toxicLeapCount = toxicLeapCount + 1
end

function mod:NoxiousStench(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "interrupt")
	self:CDBar(args.spellId, 18.2)
end

function mod:RapidDecay(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info", "stage2")
	self:StopBar(250258) -- Toxic Leap
end

do
	local prev = 0
	function mod:ToxicPool(args)
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
