
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taran Zhu", 959, 686)
if not mod then return end
mod:RegisterEnableMob(56884)
mod.engageId = 1306
mod.respawnTime = 30

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
		115002, -- Summon Gripping Hatred
		{107087, "FLASH"}, -- Haze of Hate
		107356, -- Rising Hate
	}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "GrippingHatred", 115002)
	self:Log("SPELL_AURA_APPLIED", "HazeOfHate", 107087)
	self:Log("SPELL_AURA_APPLIED", "RisingHateStart", 107356)
	self:Log("SPELL_AURA_REMOVED", "RisingHateStop", 107356)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:GrippingHatred(args)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			self:MessageOld(args.spellId, "orange", "info")
		end
	end
end

function mod:HazeOfHate(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "long", CL.you:format(args.spellName))
		self:Flash(args.spellId)
	end
end

function mod:RisingHateStart(args)
	self:MessageOld(args.spellId, "red", "warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 5)
	self:CDBar(args.spellId, 16.5) -- 16-19
end

function mod:RisingHateStop(args)
	self:StopBar(CL.cast:format(args.spellName))
end
