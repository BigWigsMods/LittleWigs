if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taloc the Corrupted", 1841, 2158)
if not mod then return end
mod:RegisterEnableMob(137119)
mod.engageId = 2123

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		269692, -- Fatal Link
		269301, -- Putrid Blood
		269843, -- Vile Expulsion
		269310, -- Cleansing Light
		269406, -- Purge Corruption
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FatalLink", 269692)
	self:Log("SPELL_CAST_SUCCESS", "PutridBlood", 259830)
	self:Log("SPELL_CAST_START", "VileExpulsion", 259830)
	self:Log("SPELL_CAST_START", "CleansingLight", 259830)
	self:Log("SPELL_CAST_SUCCESS", "PurgeCorruption", 259830)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FatalLink(args) -- No sound
	self:Message(args.spellId, "green", nil, CL.killed:format(args.sourceName))
end

function mod:PutridBlood(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:VileExpulsion(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "watchwave")
end

function mod:CleansingLight(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long", "runin")
end

function mod:PurgeCorruption(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "killmob")
end
