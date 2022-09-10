
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ymiron", 1492, 1502)
if not mod then return end
mod:RegisterEnableMob(96756)
--mod.engageId = 1822

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193977, -- Winds of Northrend
		193211, -- Dark Slash
		193364, -- Screams of the Dead
		193460, -- Bane
		193566, -- Arise, Fallen
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "WindsOfNorthrend", 193977)
	self:Log("SPELL_CAST_START", "DarkSlash", 193211)
	self:Log("SPELL_CAST_START", "ScreamsOfTheDead", 193364)
	self:Log("SPELL_CAST_START", "Bane", 193460)
	self:Log("SPELL_CAST_START", "AriseFallen", 193566)
	self:Death("Win", 96756)
end

function mod:OnEngage()
	self:Bar(193211, 3.5) -- Dark Slash
	self:CDBar(193364, 5.9) -- Screams of the Dead
	self:CDBar(193977, 15.1) -- Winds of Northrend
	self:CDBar(193460, 22.1) -- Bane
	if not self:Normal() then
		self:CDBar(193566, 41.2) -- Arise, Fallen
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WindsOfNorthrend(args)
	self:Bar(args.spellId, 29)
	self:MessageOld(args.spellId, "yellow", "alarm", CL.incoming:format(args.spellName))
end

function mod:DarkSlash(args)
	self:Bar(args.spellId, 15.5)
	self:MessageOld(args.spellId, "orange", "alert", CL.incoming:format(args.spellName))
end

function mod:ScreamsOfTheDead(args)
	self:Bar(args.spellId, 31)
	self:MessageOld(args.spellId, "red", "long", CL.incoming:format(args.spellName))
end

function mod:Bane(args)
	self:Bar(args.spellId, 59)
end

function mod:AriseFallen(args)
	self:MessageOld(args.spellId, "yellow", "warning", CL.incoming:format(args.spellName))
end
