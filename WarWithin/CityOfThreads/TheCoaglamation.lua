--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Coaglamation", 2669, 2600)
if not mod then return end
mod:RegisterEnableMob(216320) -- The Coaglamation
mod:SetEncounterID(2905)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_cityofthreads"
end

--------------------------------------------------------------------------------
-- Locals
--

local viscousDarknessCount = 1
local oozingSmashCount = 1
local darkPulseCount = 1
local bloodSurgeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		441289, -- Viscous Darkness
		{461842, "TANK_HEALER"}, -- Oozing Smash
		441395, -- Dark Pulse
		461880, -- Blood Surge
		461825, -- Black Blood
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ViscousDarkness", 441289, 447146) -- odd casts, even casts
	self:Log("SPELL_CAST_START", "OozingSmash", 461842)
	self:Log("SPELL_CAST_START", "DarkPulse", 441395)
	self:Log("SPELL_CAST_START", "BloodSurge", 438658, 461880) -- Normal/Heroic, Mythic
	-- 443311 arena (sides), 462439 arena (stairs), 461825 Mythic pools, 445435 non-Mythic pools
	self:Log("SPELL_PERIODIC_DAMAGE", "BlackBloodDamage", 443311, 462439, 461825, 445435)
	self:Log("SPELL_PERIODIC_MISSED", "BlackBloodDamage", 443311, 462439, 461825, 445435)
end

function mod:OnEngage()
	viscousDarknessCount = 1
	oozingSmashCount = 1
	darkPulseCount = 1
	bloodSurgeCount = 1
	self:StopBar(CL.active)
	if self:Mythic() then
		self:CDBar(461842, 3.6, CL.count:format(self:SpellName(461842), oozingSmashCount)) -- Oozing Smash
		self:CDBar(441289, 10.8, CL.count:format(self:SpellName(441289), viscousDarknessCount)) -- Viscous Darkness
		self:CDBar(461880, 47.3, CL.count:format(self:SpellName(461880), bloodSurgeCount)) -- Blood Surge
		self:CDBar(441395, 67.1, CL.count:format(self:SpellName(441395), darkPulseCount)) -- Dark Pulse
	else -- Heroic, Normal
		self:CDBar(441289, 8.2, CL.count:format(self:SpellName(441289), viscousDarknessCount)) -- Viscous Darkness
		self:CDBar(461880, 20.3, CL.count:format(self:SpellName(461880), bloodSurgeCount)) -- Blood Surge
		self:CDBar(461842, 31.3, CL.count:format(self:SpellName(461842), oozingSmashCount)) -- Oozing Smash
		self:CDBar(441395, 67.4, CL.count:format(self:SpellName(441395), darkPulseCount)) -- Dark Pulse
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup() -- called from trash module
	-- 15.55 [CLEU] UNIT_DIED##nil#Creature-0-2085-2669-9069-216329#Congealed Droplet
	-- 25.15 [NAME_PLATE_UNIT_ADDED] The Coaglamation
	self:Bar("warmup", 9.6, CL.active, L.warmup_icon)
end

function mod:OozingSmash(args)
	self:StopBar(CL.count:format(args.spellName, oozingSmashCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, oozingSmashCount))
	oozingSmashCount = oozingSmashCount + 1
	if self:Mythic() then
		if oozingSmashCount % 2 == 0 then
			self:CDBar(args.spellId, 15.4, CL.count:format(args.spellName, oozingSmashCount))
		else
			self:CDBar(args.spellId, 58.3, CL.count:format(args.spellName, oozingSmashCount))
		end
	else
		self:CDBar(args.spellId, 77.5, CL.count:format(args.spellName, oozingSmashCount))
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:ViscousDarkness(args)
	self:StopBar(CL.count:format(args.spellName, viscousDarknessCount))
	self:Message(441289, "red", CL.count:format(args.spellName, viscousDarknessCount))
	viscousDarknessCount = viscousDarknessCount + 1
	self:CDBar(441289, 37.2, CL.count:format(args.spellName, viscousDarknessCount))
	self:PlaySound(441289, "long")
end

function mod:DarkPulse(args)
	self:StopBar(CL.count:format(args.spellName, darkPulseCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, darkPulseCount))
	darkPulseCount = darkPulseCount + 1
	self:CDBar(args.spellId, 77.2, CL.count:format(args.spellName, darkPulseCount))
	self:PlaySound(args.spellId, "alert")
end

function mod:BloodSurge(args)
	self:StopBar(CL.count:format(args.spellName, bloodSurgeCount))
	self:Message(461880, "orange", CL.count:format(args.spellName, bloodSurgeCount))
	bloodSurgeCount = bloodSurgeCount + 1
	self:CDBar(461880, 77.2, CL.count:format(args.spellName, bloodSurgeCount))
	self:PlaySound(461880, "alarm")
end

do
	local prev = 0
	function mod:BlackBloodDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(461825, "underyou", nil, args.spellId) -- arena damage has a different icon than pool damage
			self:PlaySound(461825, "underyou")
		end
	end
end
