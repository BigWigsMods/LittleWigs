-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Glazer", 1493, 1469)
if not mod then return end
mod:RegisterEnableMob(95887)
mod.engageId = 1817

--------------------------------------------------------------------------------
-- Locals
--

local nextFocusing = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.radiation_level = "%s: %d%%" -- Radiation Level: 10%
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		194945, -- Lingering Gaze
		194323, -- Focusing
		202046, -- Beam
		194333, -- Beamed
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LingeringGazeCast", 194942)
	self:Log("SPELL_AURA_APPLIED", "LingeringGazeApplied", 194945)
	self:Log("SPELL_AURA_APPLIED", "Focusing", 194323)
	self:Log("SPELL_AURA_APPLIED_DOSE", "RadiationLevel", 195034)
	self:Log("SPELL_AURA_APPLIED", "BeamDamage", 202046)
	self:Log("SPELL_PERIODIC_DAMAGE", "BeamDamage", 202046)
	self:Log("SPELL_PERIODIC_MISSED", "BeamDamage", 202046)
	self:Log("SPELL_AURA_APPLIED", "Beamed", 194333)
end

function mod:OnEngage()
	nextFocusing = GetTime() + 32
	self:Bar(194323, 32) -- Focusing
	self:CDBar(194945, 15.4) -- Lingering Gaze
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LingeringGazeCast(args)
	self:MessageOld(194945, "red", "alarm", CL.casting:format(args.spellName))
	if nextFocusing - GetTime() > 18 then -- values lower than 18 sometimes failed
		self:CDBar(194945, 15.7)
	end
end

function mod:LingeringGazeApplied(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
	end
end

function mod:Focusing(args)
	self:MessageOld(args.spellId, "orange", "info")
end

function mod:RadiationLevel(args)
	if args.amount >= 10 and args.amount % 5 == 0 then -- 10, 15, 20
		self:MessageOld(194323, "orange", "info", L.radiation_level:format(args.spellName, args.amount), args.spellId)
	end
end

do
	local prev = 0
	function mod:BeamDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:Beamed(args)
	self:MessageOld(args.spellId, "green", "info")
	self:Bar(args.spellId, 15)
	self:Bar(194323, 60) -- Focusing
	nextFocusing = GetTime() + 60
	self:CDBar(194945, 5.9) -- Lingering Gaze
end
