
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Helya", 1042, 1663)
if not mod then return end
mod:RegisterEnableMob(96759)
--mod.engageId = 1824

--------------------------------------------------------------------------------
-- Locals
--
local firstTorrent = 0
local afterCorrupted = 1
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		197517, -- Taint of the sea
		{197262, "SAY"}, -- TaintApplied
		198495, -- Torrent
		227233, -- Corrupted Below
		196947, -- Submerged
		202088, -- BrackwaterBarrage
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_AURA_APPLIED", "TaintApplied", 197262) -- aura apply id
	self:Log("SPELL_CAST_START", "CorruptedBelow", 227233)
	self:Log("SPELL_CAST_START", "Submerged", 196947)
	self:Log("SPELL_CAST_START", "BrackwaterBarrage", 202088)
	self:Log("SPELL_CAST_START", "Torrent", 198495)
	self:Death("Win", 96759)
end

function mod:OnEngage()
	afterCorrupted = 0
	firstTorrent = 0
 	self:CDBar(202088, 40.5) -- Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:TaintApplied(args)
	self:TargetMessage(args.spellId, args.destGUID, "Attention", "Alert", nil, nil, self:Dispeller())
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:Submerged(args)
	self:StopBar(198495)
	firstTorrent = 0
end

function mod:Torrent(args)
	if afterCorrupted == 0 then
		self:CDBar(198495, 11)
	else
		self:CDBar(198495, 13.5)
	end

	if firstTorrent == 0 then
		self:CDBar(INTERMISSION, 59) -- Needs a intermission phase icon
	end

	firstTorrent = 1
	afterCorrupted = 0
	self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
end

function mod:CorruptedBelow(args)
	afterCorrupted = 1
end
