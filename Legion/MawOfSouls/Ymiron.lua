
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ymiron", 1042, 1502)
if not mod then return end
mod:RegisterEnableMob(96756)
--mod.engageId = 1822
--------------------------------------------------------------------------------

-- Initialization
--
function mod:GetOptions()
	return {
		193977, -- Winds of the Northrend
		193211, -- Dark Slash
		193364, -- Screams of the dead
		193460, -- Bane
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "Winds", 193977)
	self:Log("SPELL_CAST_START", "DarkSlash", 193211)
	self:Log("SPELL_CAST_START", "Screams", 193364)
	self:Log("SPELL_CAST_START", "Bane", 193460)
	self:Log("SPELL_CAST_START", "Arise", 193566)
	self:Death("Win", 96756)
end

function mod:OnEngage()
	self:Bar(193211, 3.5) -- Dark Slash
	self:CDBar(193364, 5.9) -- Screams
	self:CDBar(193977, 15.1) -- Winds
	self:CDBar(193460, 22.1) -- Bane
	self:CDBar(193566, 41.2) -- Arise
end
--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:Winds(args)
	self:Bar(args.spellId, 29)
	self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
end

function mod:DarkSlash(args)
	self:Bar(args.spellId, 15.5)
	self:Message(args.spellId, "Alert", "Info", CL.incoming:format(args.spellName))
end

function mod:Screams(args)
	self:Bar(args.spellId, 31)
	self:Message(args.spellId, "Alert", "Warning", CL.incoming:format(args.spellName))
end

function mod:Bane(args)
	self:Bar(args.spellId, 59)
end

function mod:Arise(args)
	self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
end