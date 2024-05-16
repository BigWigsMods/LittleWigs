--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taran Zhu", 959, 686)
if not mod then return end
mod:RegisterEnableMob(56884)
mod:SetEncounterID(1306)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engage_yell = "Hatred will consume and conquer all!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		107087, -- Haze of Hate
		107356, -- Rising Hate
		131521, -- Ring of Malice
		115002, -- Summon Gripping Hatred
	}
end

function mod:VerifyEnable(unit)
	return self:GetHealth(unit) > 15
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "HazeOfHate", 107087)
	self:Log("SPELL_AURA_APPLIED", "RisingHate", 107356)
	self:Log("SPELL_CAST_SUCCESS", "RingOfMalice", 131521)
	self:Log("SPELL_CAST_START", "SummonGrippingHatred", 115002)
end

function mod:OnEngage()
	self:CDBar(131521, 10.8) -- Ring of Malice
	self:CDBar(115002, 15.6) -- Summon Gripping Hatred
	self:CDBar(107356, 19.2) -- Rising Hate
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HazeOfHate(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "long", nil, args.destName)
	end
end

function mod:RisingHate(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 15.7)
end

function mod:RingOfMalice(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 40.0)
end

do
	local prev = 0
	function mod:SummonGrippingHatred(args)
		local t = args.time
		-- cast 3 times in a row, only alert on the first
		if t - prev > 5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
			self:CDBar(args.spellId, 43.7)
		end
	end
end
