
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dresaron", 1067, 1656)
if not mod then return end
mod:RegisterEnableMob(99200)
--mod.engageId = 1838 -- START fires prior to engaging the boss

local first = true

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		199345, -- Down Draft
		199460, -- Falling Rocks
		191325, -- Breath of Corruption
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DownDraft", 199345)

	self:Log("SPELL_AURA_APPLIED", "FallingRocksDamage", 199460)
	self:Log("SPELL_PERIODIC_DAMAGE", "FallingRocksDamage", 199460)
	self:Log("SPELL_PERIODIC_MISSED", "FallingRocksDamage", 199460)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 99200)
end

function mod:OnEngage()
	first = true
	self:Bar(199345, 32) -- Down Draft
	self:Bar(191325, 15) -- Breath of Corruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DownDraft(args)
	self:Message(args.spellId, "Important", "Warning")
	self:Bar(args.spellId, 29)
end

do
	local prev = 0
	function mod:FallingRocksDamage(args)
		local t = GetTime()
		if t-prev > 2 and self:Me(args.destGUID) then
			prev = t
			self:Message(args.spellId, "Personal", "Alarm", CL.you:format(args.spellName))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 199332 then -- Breath of Corruption
		self:Message(191325, "Attention", "Info")
		self:Bar(191325, first and 20 or 30)
		first = false
	end
end

