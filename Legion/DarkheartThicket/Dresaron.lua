
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dresaron", 1466, 1656)
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
	self:CDBar(199345, 21) -- Down Draft
	self:CDBar(191325, 13.5) -- Breath of Corruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DownDraft(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:CDBar(args.spellId, 30) -- pull:20.8, 34.7 / hc pull:21.7, 30.3, 30.4 / m pull:21.8, 34.0, 35.2
end

do
	local prev = 0
	function mod:FallingRocksDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alarm", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 199332 then -- Breath of Corruption
		self:MessageOld(191325, "yellow", "info")
		self:CDBar(191325, first and 20 or 30) -- XXX m pull:13.5, 21.5, 13.8, 20.6, 14.6, 20.6
		first = false
	end
end

