--------------------------------------------------------------------------------
-- To Do
-- Enveloping Winds timers are not 100% accurate

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Melandrus", 1087, 1720)
if not mod then return end
mod:RegisterEnableMob(104218)
mod.engageId = 1870

--------------------------------------------------------------------------------
-- Locals
--

local bladeSurgeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		209602, -- Blade Surge
		224333, -- Enveloping Winds
		209628, -- Piercing Gale
		209676, -- Slicing Maelstrom
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "BladeSurge", 209602)
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)
end

function mod:OnEngage()
	bladeSurgeCount = 1
	self:CDBar(209628, 11) -- Piercing Gale
	self:CDBar(224333, 8.4) -- Enveloping Winds
	self:CDBar(209602, 5.2, CL.count:format(args.spellName, bladeSurgeCount)) -- Blade Surge
	self:CDBar(209676, 23) -- Slicing Maelstrom
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BladeSurge(args)
	self:Message(args.spellId, "Important", "Info", CL.count:format(args.spellName, bladeSurgeCount))
	bladeSurgeCount = bladeSurgeCount + 1
	self:CDBar(args.spellId, 12, CL.count:format(args.spellName, bladeSurgeCount))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 224327 then -- Enveloping Winds
		self:Message(224333, "Attention", "Info", spellName)
		self:CDBar(224333, 9.4) -- actual spellid has no icon/tooltip
	end
end

do
	local prev = 0
	function mod:PiercingGale(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm")
			self:CDBar(args.spellId, 24)
		end
	end
end

function mod:SlicingMaelstrom(args)
	self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 24)
end
