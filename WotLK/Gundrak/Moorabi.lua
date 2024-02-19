--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Moorabi", 604, 594)
if not mod then return end
mod:RegisterEnableMob(29305) -- Moorabi
mod:SetEncounterID(mod:Classic() and 387 or 1980)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{55098, "CASTBAR"}, -- Transformation
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
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	local boss = self:GetUnitIdByGUID(args.sourceGUID) -- No UnitTokenFromGUID on wrath classic
	if boss then
		local _, _, _, _, endTime = UnitCastingInfo(boss) -- cast time is different on each cast, at least on heroic/tw
		local remaining = endTime / 1000 - GetTime()
		self:CastBar(args.spellId, remaining)
	end
end

function mod:Interrupt(args)
	if args.extraSpellId == 55098 then -- Transformation
		self:Message(55098, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:StopBar(CL.cast:format(args.extraSpellName)) -- Name of interrupted spell
	end
end
