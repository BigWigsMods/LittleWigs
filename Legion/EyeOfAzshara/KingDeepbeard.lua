
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Deepbeard", 1456, 1491)
if not mod then return end
mod:RegisterEnableMob(91797)
mod.engageId = 1812

--------------------------------------------------------------------------------
-- Locals
--

local bubblesOnMe = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193051, -- Call the Seas
		{193018, "FLASH"}, -- Gaseous Bubbles
		193093, -- Ground Slam
		{193152, "PROXIMITY"}, -- Quake
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CallTheSeas", 193051)
	self:Log("SPELL_CAST_SUCCESS", "GaseousBubbles", 193018)
	self:Log("SPELL_AURA_APPLIED", "GaseousBubblesApplied", 193018)
	self:Log("SPELL_AURA_REMOVED", "GaseousBubblesRemoved", 193018)
	self:Log("SPELL_CAST_START", "GroundSlam", 193093)
	self:Log("SPELL_CAST_START", "Quake", 193152)
	self:Log("SPELL_DAMAGE", "Aftershock", 193171)
	self:Log("SPELL_MISSED", "Aftershock", 193171)
end

function mod:OnEngage()
	bubblesOnMe = false
	self:Bar(193051, 20) -- Call the Seas
	self:CDBar(193018, 12) -- Gaseous Bubbles
	self:CDBar(193093, 6) -- Ground Slam
	self:Bar(193152, 15) -- Quake
	self:OpenProximity(193152, 5) -- Quake
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallTheSeas(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:Bar(args.spellId, 30) -- pull:20.5, 30.4, 30.3
end

function mod:GaseousBubbles(args)
	self:CDBar(args.spellId, 32) -- pull:12.8, 35.3, 32.8 / m pull:12.9, 35.3, 32.8, 32.8
end

function mod:GaseousBubblesApplied(args)
	if self:Me(args.destGUID) then
		bubblesOnMe = true
		self:TargetMessageOld(args.spellId, args.destName, "blue", "warning")
		self:TargetBar(args.spellId, 20, args.destName)
		self:Flash(args.spellId)
	end
end

function mod:GaseousBubblesRemoved(args)
	if self:Me(args.destGUID) then
		bubblesOnMe = false
		self:MessageOld(args.spellId, "blue", "warning", CL.removed:format(args.spellName))
		self:StopBar(args.spellName, args.destName)
	end
end

function mod:GroundSlam(args)
	self:MessageOld(args.spellId, "orange", "info", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 18) -- pull:5.9, 18.2, 20.6, 19.4
end

function mod:Quake(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 21) -- pull:15.6, 21.9, 21.8, 21.8
end

do
	local prev = 0
	function mod:Aftershock(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			-- players with Gaseous Bubbles may (and should) be taking damage intentionally
			if t-prev > (bubblesOnMe and 6 or 1.5) then
				prev = t
				self:MessageOld(193152, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
