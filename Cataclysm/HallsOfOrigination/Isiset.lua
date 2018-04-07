-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Isiset", 644, 127)
if not mod then return end
mod:RegisterEnableMob(39587)
mod.engageId = 1077
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextSplitWarning = 71

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		74373, -- Veil of Sky
		74137, -- Supernova
		74135, -- Astral Rain
		74045, -- Energy Flux
		-2556, -- Mirror Images
	}
end

function mod:OnBossEnable()
	-- 3 ids per spell: destroying a mirror image disables 1 ability, empowers others. 2nd & 3rd ids are empowered versions
	self:Log("SPELL_AURA_APPLIED", "VeilOfSky", 74133, 74372, 74373)
	self:Log("SPELL_AURA_REMOVED", "VeilOfSkyRemoved", 74133, 74372, 74373)

	self:Log("SPELL_CAST_START", "Supernova", 74136, 74137, 76670)

	self:Log("SPELL_DAMAGE", "AstralRain", 74135, 74366, 74370)
	self:Log("SPELL_MISSED", "AstralRain", 74135, 74366, 74370)

	self:Log("SPELL_DAMAGE", "EnergyFlux", 74045)
	self:Log("SPELL_MISSED", "EnergyFlux", 74045)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	nextSplitWarning = 71 -- 66% and 33%
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:VeilOfSky(args)
	self:Message(74373, "Attention")
	self:CDBar(74373, 60)
end

function mod:VeilOfSkyRemoved(args)
	self:StopBar(74373)
end

function mod:Supernova(args)
	self:Message(74137, "Important", "Alarm", CL.casting:format(args.spellName))
	self:CastBar(74137, 3)
end

do
	local prev = 0
	function mod:AstralRain(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(74135, "Personal", "Alert", CL.you:format(args.spellName))
			end
		end
	end

	function mod:EnergyFlux(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextSplitWarning then
		self:Message(-2556, "Positive", nil, CL.soon:format(self:SpellName(-2556))) -- Mirror Image
		nextSplitWarning = nextSplitWarning - 33

		if nextSplitWarning < 33 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 69941 then -- Mirror Image
		self:Message(-2556, "Neutral", "Info")
	end
end
