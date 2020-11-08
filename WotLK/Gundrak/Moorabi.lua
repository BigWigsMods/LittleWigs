
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Moorabi", 604, 594)
if not mod then return end
mod:RegisterEnableMob(29305)
mod.engageId = 1980
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		55098, -- Transformation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Transformation", 55098)
	self:Log("SPELL_INTERRUPT", "Interrupt", "*")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Transformation(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
	local _, _, _, _, endTime = UnitCastingInfo("boss1") -- cast time is different on each cast, at least on heroic/tw
	local remaining = endTime / 1000 - GetTime()
	self:Bar(args.spellId, remaining)
end

function mod:Interrupt(args)
	if args.extraSpellId == 55098 then -- Transformation
		self:MessageOld(55098, "green", nil, CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:StopBar(args.extraSpellName) -- Name of interrupted spell
	end
end
