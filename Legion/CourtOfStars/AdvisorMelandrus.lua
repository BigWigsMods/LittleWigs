--TO DO
--Fix timers
--Confirm Enveloping Winds spellId

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
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "BladeSurge", 209602)
	self:Log("SPELL_CAST_SUCCESS", "EnvelopingWinds", 224333)
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)

	self:Death("Win", 104218)
end

function mod:OnEngage()
	local bladeSurgeCount = 0
	--self:CDBar(??, ??)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BladeSurge(args)
	bladeSurgeCount = bladeSurgeCount + 1
	self:Message(args.spellId, "Important", "Info", CL.count:format(args.spellName, bladeSurgeCount))
	--self:CDBar(args.spellId, ??)
end

function mod:EnvelopingWinds(args)
	self:Message(args.spellId, "Important", "Info")
	--self:CDBar(args.spellId, ??)
end

function mod:PiercingGale(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	--self:CDBar(args.spellId, ??)
end

function mod:SlicingMaelstrom(args)
	self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	--self:CDBar(args.spellId, ??)
end
