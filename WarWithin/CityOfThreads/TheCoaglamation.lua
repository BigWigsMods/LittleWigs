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
		461880, -- Blood Surge
		441395, -- Dark Pulse
		461825, -- Black Blood
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ViscousDarkness", 441289, 447146) -- odd casts, even casts
	self:Log("SPELL_CAST_START", "OozingSmash", 461842, 461989)
	self:Log("SPELL_CAST_START", "BloodSurge", 461880, 438658) -- all difficulties, non-Mythic
	self:Log("SPELL_CAST_START", "DarkPulse", 441395)
	-- 443311 arena (sides), 462439 arena (stairs), 461825 pools, 438601 non-Mythic pools
	self:Log("SPELL_PERIODIC_DAMAGE", "BlackBloodDamage", 443311, 462439)
	self:Log("SPELL_PERIODIC_MISSED", "BlackBloodDamage", 443311, 462439)
	self:Log("SPELL_DAMAGE", "BlackBloodDamage", 461825, 438601)
	self:Log("SPELL_MISSED", "BlackBloodDamage", 461825, 438601)
end

function mod:OnEngage()
	viscousDarknessCount = 1
	oozingSmashCount = 1
	darkPulseCount = 1
	bloodSurgeCount = 1
	self:StopBar(CL.active)
	if self:Mythic() then
		self:CDBar(461842, 3.2, CL.count:format(self:SpellName(461842), oozingSmashCount)) -- Oozing Smash
		self:CDBar(441289, 10.5, CL.count:format(self:SpellName(441289), viscousDarknessCount)) -- Viscous Darkness
		self:CDBar(461880, 19.0, CL.count:format(self:SpellName(461880), bloodSurgeCount)) -- Blood Surge
		self:CDBar(441395, 47.2, CL.count:format(self:SpellName(441395), darkPulseCount)) -- Dark Pulse
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

function mod:ViscousDarkness(args)
	self:StopBar(CL.count:format(args.spellName, viscousDarknessCount))
	self:Message(441289, "red", CL.count:format(args.spellName, viscousDarknessCount))
	viscousDarknessCount = viscousDarknessCount + 1
	if self:Mythic() then
		if viscousDarknessCount == 2 then
			self:CDBar(441289, 21.8, CL.count:format(args.spellName, viscousDarknessCount))
		elseif viscousDarknessCount == 3 then
			self:CDBar(441289, 32.8, CL.count:format(args.spellName, viscousDarknessCount))
		elseif viscousDarknessCount % 2 == 0 then -- 4, 6...
			self:CDBar(441289, 36.4, CL.count:format(args.spellName, viscousDarknessCount))
		else -- 5, 7...
			self:CDBar(441289, 38.8, CL.count:format(args.spellName, viscousDarknessCount))
		end
	else -- Heroic, Normal
		if viscousDarknessCount % 2 == 0 then -- 2, 4...
			self:CDBar(441289, 36.4, CL.count:format(args.spellName, viscousDarknessCount))
		else -- 3, 5...
			self:CDBar(441289, 38.8, CL.count:format(args.spellName, viscousDarknessCount))
		end
	end
	self:PlaySound(441289, "long")
end

function mod:OozingSmash(args)
	self:StopBar(CL.count:format(args.spellName, oozingSmashCount))
	self:Message(461842, "purple", CL.count:format(args.spellName, oozingSmashCount))
	oozingSmashCount = oozingSmashCount + 1
	if self:Mythic() then
		if oozingSmashCount == 2 then
			self:CDBar(461842, 54.2, CL.count:format(args.spellName, oozingSmashCount))
		elseif oozingSmashCount % 2 == 1 then -- 3, 5...
			self:CDBar(461842, 15.7, CL.count:format(args.spellName, oozingSmashCount))
		else -- 4, 6...
			self:CDBar(461842, 59.4, CL.count:format(args.spellName, oozingSmashCount))
		end
	else -- Heroic, Normal
		if oozingSmashCount == 2 then
			self:CDBar(461842, 47.3, CL.count:format(args.spellName, oozingSmashCount))
		elseif oozingSmashCount % 2 == 1 then -- 3, 5...
			self:CDBar(461842, 15.7, CL.count:format(args.spellName, oozingSmashCount))
		else -- 4, 6...
			self:CDBar(461842, 59.4, CL.count:format(args.spellName, oozingSmashCount))
		end
	end
	self:PlaySound(461842, "alert")
end

function mod:BloodSurge(args)
	self:StopBar(CL.count:format(args.spellName, bloodSurgeCount))
	self:Message(461880, "orange", CL.count:format(args.spellName, bloodSurgeCount))
	bloodSurgeCount = bloodSurgeCount + 1
	if self:Mythic() then
		if bloodSurgeCount == 2 then
			self:CDBar(461880, 68.0, CL.count:format(args.spellName, bloodSurgeCount))
		else -- 3+
			self:CDBar(461880, 75.2, CL.count:format(args.spellName, bloodSurgeCount))
		end
	else -- Heroic, Normal
		if bloodSurgeCount == 2 then
			self:CDBar(461880, 87.3, CL.count:format(args.spellName, bloodSurgeCount))
		else -- 3+
			self:CDBar(461880, 75.2, CL.count:format(args.spellName, bloodSurgeCount))
		end
	end
	self:PlaySound(461880, "alarm")
end

function mod:DarkPulse(args)
	self:StopBar(CL.count:format(args.spellName, darkPulseCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, darkPulseCount))
	darkPulseCount = darkPulseCount + 1
	self:CDBar(args.spellId, 75.2, CL.count:format(args.spellName, darkPulseCount))
	self:PlaySound(args.spellId, "alert")
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
