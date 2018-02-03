-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Glazer", 1045, 1469)
if not mod then return end
mod:RegisterEnableMob(95887)
mod.engageId = 1817

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.radiation_level = "%s - %d%%" -- Radiation Level - 10%
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
	self:Bar(194323, 32) -- Focusing
	self:CDBar(194945, 15.4) -- Lingering Gaze
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LingeringGazeCast(args)
	self:Message(194945, "Important", "Alarm", CL.casting:format(args.spellName))
	if self:BarTimeLeft(self:SpellName(194323)) > 18 then -- Focusing (values lower than 18 sometimes failed)
		self:CDBar(194945, 15.7)
	end
end

function mod:LingeringGazeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
	end
end

function mod:Focusing(args)
	self:Message(args.spellId, "Urgent", "Info")
end

function mod:RadiationLevel(args)
	if args.amount >= 10 and args.amount % 5 == 0 then -- 10, 15, 20
		self:Message(194323, "Urgent", "Info", L.radiation_level:format(args.spellName, args.amount), args.spellId)
	end
end

do
	local prev = 0
	function mod:BeamDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Alert", CL.you:format(args.spellName))
		end
	end
end

function mod:Beamed(args)
	self:Message(args.spellId, "Positive", "Info")
	self:Bar(args.spellId, 15)
	self:Bar(194323, 60) -- Focusing
	self:CDBar(194945, 5.9) -- Lingering Gaze
end
