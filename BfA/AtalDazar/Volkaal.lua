--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vol'kaal", 1763, 2036)
if not mod then return end
mod:RegisterEnableMob(
	122965, -- Vol'kaal
	125977  -- Reanimation Totem
)
mod:SetEncounterID(2085)
mod:SetRespawnTime(30)
mod:SetStage(1)

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
		{259531, "CASTBAR"}, -- Reanimate
		250241, -- Rapid Decay
		250585, -- Toxic Pool
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ToxicLeap", 250258)
	self:Log("SPELL_CAST_SUCCESS", "NoxiousStench", 259572)
	self:Log("SPELL_CAST_START", "Reanimate", 259531)
	self:Log("SPELL_CAST_SUCCESS", "RapidDecay", 250241) -- Stage 2 start
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPoolDamage", 250585) -- no alert on APPLIED, doesn't damage right away
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPoolDamage", 250585)
end

function mod:OnEngage()
	toxicLeapCount = 1
	self:SetStage(1)
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
	-- every third leap will be delayed by Noxious Stench, starting with the second
	if toxicLeapCount % 3 == 2 then
		self:CDBar(args.spellId, 8.5)
	else
		self:CDBar(args.spellId, 6.0)
	end
end

function mod:NoxiousStench(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning", "interrupt")
	else
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 19.4)
end

do
	local prev = 0
	local reanimateCount = 1
	function mod:Reanimate(args)
		local castTime = self:Mythic() and 7 or 10
		-- show a cast bar only for the first cast
		local t = args.time
		if t - prev > castTime then
			prev = t
			reanimateCount = 1
			self:CastBar(args.spellId, castTime)
		end
		self:Message(args.spellId, "cyan", CL.casting:format(CL.count_amount:format(args.spellName, reanimateCount, 3)))
		self:PlaySound(args.spellId, "info")
		reanimateCount = reanimateCount + 1
	end
end

function mod:RapidDecay(args)
	self:StopBar(CL.cast:format(self:SpellName(259531))) -- Reanimate
	self:StopBar(250258) -- Toxic Leap
	self:SetStage(2)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long", "stage2")
end

do
	local prev = 0
	function mod:ToxicPoolDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", "gtfo", args.destName)
			end
		end
	end
end
