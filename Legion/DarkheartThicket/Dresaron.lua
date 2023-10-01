--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dresaron", 1466, 1656)
if not mod then return end
mod:RegisterEnableMob(99200) -- Dresaron
mod:SetEncounterID(1838)
mod:SetRespawnTime(25)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		191325, -- Breath of Corruption
		199389, -- Earthshaking Roar
		199345, -- Down Draft
		199460, -- Falling Rocks
	}
end

function mod:OnBossEnable()
	-- TODO: self:Log("SPELL_CAST_START", "BreathOfCorruption", 191325)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Breath of Corruption
	self:Log("SPELL_CAST_START", "EarthshakingRoar", 199389)
	self:Log("SPELL_CAST_START", "DownDraft", 199345)
	self:Log("SPELL_AURA_APPLIED", "FallingRocksDamage", 199460)
	self:Log("SPELL_PERIODIC_DAMAGE", "FallingRocksDamage", 199460)
	self:Log("SPELL_PERIODIC_MISSED", "FallingRocksDamage", 199460)
end

function mod:OnEngage()
	self:CDBar(191325, 14.4) -- Breath of Corruption
	self:CDBar(199345, 20.4) -- Down Draft
	self:CDBar(199389, 21.0) -- Earthshaking Roar
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 199332 then -- Breath of Corruption
		self:Message(191325, "orange")
		self:PlaySound(191325, "alarm")
		self:CDBar(191325, 29.1)
	end
end

function mod:EarthshakingRoar(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 29.1)
end

function mod:DownDraft(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 29.1)
end

do
	local prev = 0
	function mod:FallingRocksDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end
