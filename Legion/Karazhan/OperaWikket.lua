
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Wikket", 1651, 1820)
if not mod then return end
mod:RegisterEnableMob(114251, 114284) -- Galindre, Elfyra
--mod.engageId = 1957 -- Same for every opera event. So it's basically useless.

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227447, -- Defy Gravity
		227410, -- Wondrous Radiance
		227776, -- Magic Magnificent
		227477, -- Summon Assistants
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "DefyGravity", 227447)
	self:Log("SPELL_CAST_SUCCESS", "WondrousRadiance", 227410)
	self:Log("SPELL_CAST_START", "MagicMagnificent", 227776)
	self:Log("SPELL_CAST_SUCCESS", "SummonAssistants", 227477)

	self:RegisterEvent("BOSS_KILL")
end

function mod:OnEngage()
	self:Bar(227410, 8.5) -- Wondrous Radiance
	self:Bar(227447, 10.5) -- Defy Gravity
	self:Bar(227477, 32) -- Summon Assistants
	self:Bar(227776, 48.5) -- Magic Magnificent
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DefyGravity(args)
	self:MessageOld(args.spellId, "yellow", "info")
	self:CDBar(args.spellId, 17)
end

function mod:WondrousRadiance(args)
	self:MessageOld(args.spellId, "orange", self:Tank() and "warning")
	self:CDBar(args.spellId, 11)
end

function mod:MagicMagnificent(args)
	self:MessageOld(args.spellId, "red", "long")
	self:Bar(args.spellId, 5, CL.cast:format(args.spellName))
end

function mod:SummonAssistants(args)
	self:MessageOld(args.spellId, "orange", "alert")
	self:CDBar(args.spellId, 32.5)
end

function mod:BOSS_KILL(_, id)
	if id == 1957 then
		self:Win()
	end
end
