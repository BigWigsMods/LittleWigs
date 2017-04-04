
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
	self:Log("SPELL_CAST_START", "BladeSurge", 209602)
	self:Log("SPELL_CAST_SUCCESS", "EnvelopingWinds", 224333)
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)
end

function mod:OnEngage()
	bladeSurgeCount = 0
	self:CDBar(209628, 7) -- Piercing Gale
	self:CDBar(224333, 10) -- Enveloping Winds
	self:CDBar(209602, 15) -- Blade Surge
	self:CDBar(209676, 10) -- Slicing Maelstrom
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BladeSurge(args)
	bladeSurgeCount = bladeSurgeCount + 1
	self:Message(args.spellId, "Important", "Info", CL.count:format(args.spellName, bladeSurgeCount))
	self:CDBar(args.spellId, 19)
end

function mod:EnvelopingWinds(args)
	self:Message(args.spellId, "Important", "Info")
	self:CDBar(args.spellId, 11)
end

do
	local prev = 0
	function mod:PiercingGale(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm")
			self:CDBar(args.spellId, 18)
		end
	end
end

function mod:SlicingMaelstrom(args)
	self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 18)
end
