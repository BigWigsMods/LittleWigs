--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'kaal", 1763, 2036)
if not mod then return end
mod:RegisterEnableMob(122965)
mod:SetEncounterID(2085)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local toxicLeapCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		250258, -- Toxic Leap
		259572, -- Noxious Stench
		259531, -- Reanimate
		250241, -- Rapid Decay
		250585, -- Toxic Pool
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ToxicLeap", 250258)
	self:Log("SPELL_CAST_SUCCESS", "NoxiousStench", 259572)
	self:Log("SPELL_CAST_START", "Reanimate", 259531)
	self:Log("SPELL_CAST_SUCCESS", "RapidDecay", 250241) -- Stage 2 start
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 250585)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 250585)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 250585)
end

function mod:OnEngage()
	toxicLeapCount = 1
	self:CDBar(250258, 2.2) -- Toxic Leap
	self:CDBar(259572, 5.8) -- Noxious Stench
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ToxicLeap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm", "watchstep")
	toxicLeapCount = toxicLeapCount + 1
	-- every third leap has a longer timer, starting with the second
	self:CDBar(args.spellId, toxicLeapCount % 3 == 2 and 8.5 or 6.0)
end

function mod:NoxiousStench(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "interrupt")
	-- TODO delayed slightly by toxic leap in stage 1?
	self:CDBar(args.spellId, 18.2)
end

function mod:Reanimate(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	-- TODO 7s castbar for 2 concurrent reanimates? both cleared when rapid decay happens
end

function mod:RapidDecay(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long", "stage2")
	self:StopBar(250258) -- Toxic Leap
end

do
	local prev = 0
	function mod:ToxicPool(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", "gtfo")
			end
		end
	end
end
