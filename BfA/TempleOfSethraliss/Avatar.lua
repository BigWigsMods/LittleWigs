if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Avatar of Sethraliss", 1877, 2145)
if not mod then return end
mod:RegisterEnableMob(136250, 133392) -- Hoodoo Hexxer, Avatar of Sethraliss
mod.engageId = 2127

--------------------------------------------------------------------------------
-- Locals
--

local activatedCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		268061, -- Chain Lightning
		268012, -- Earthquake
		268013, -- Flame Shock
		266232, -- Activated
		267931, -- Defensive Wards
		267979, -- Intertwined Essence
		268024, -- Pulse
		268007, -- Intertwine
		268020, -- Electrocution
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_START", "ChainLightning", 268061)
	self:Log("SPELL_CAST_SUCCESS", "Earthquake", 268012)
	self:Log("SPELL_CAST_SUCCESS", "FlameShock", 268013)
	self:Log("SPELL_CAST_SUCCESS", "Activated", 266232)
	self:Log("SPELL_AURA_APPLIED", "DefensiveWards", 267931)
	self:Log("SPELL_PERIODIC_DAMAGE", "DefensiveWards", 267931)
	self:Log("SPELL_PERIODIC_MISSED", "DefensiveWards", 267931)
	-- Stage 2
	self:Log("SPELL_AURA_APPLIED", "IntertwinedEssence", 267979)
	self:Log("SPELL_CAST_SUCCESS", "Pulse", 268024)
	self:Log("SPELL_CAST_START", "Intertwine", 268007)
	self:Log("SPELL_CAST_START", "Electrocution", 268020)
end

function mod:OnEngage()
	activatedCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChainLightning(args)
	self:Message(args.spellId, "yellow", "Alert")
end

function mod:Earthquake(args)
	self:Message(args.spellId, "orange", "Alarm")
end

function mod:FlameShock(args)
	self:TargetMessage(args.spellId, destName, "red", "Alert", nil, nil, self:Dispeller("magic"))
end

function mod:Activated(args)
	activatedCount = activatedCount + 1
	self:Message(args.spellId, "cyan", "Info", CL.count:format(args.spellName, activatedCount))
end

do
	local prev = 0
	function mod:DefensiveWards(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then
			prev = GetTime()
			self:Message(args.spellId, "blue", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:IntertwinedEssence(args)
	self:TargetMessage(args.spellId, destName, "yellow", "Alert", nil, nil, self:Healer())
end

function mod:Pulse(args)
	self:Message(args.spellId, "red", "Warning")
end

function mod:Intertwine(args)
	self:Message(args.spellId, "orange", "Alarm")
end

function mod:Electrocution(args)
	self:Message(args.spellId, "yellow", "Alert")
end
