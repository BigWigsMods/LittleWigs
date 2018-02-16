
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Gal'darah", 530, 596)
if not mod then return end
mod:RegisterEnableMob(29306)
mod.engageId = 1981

local formPhase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.forms = "Forms"
	L.forms_desc = "Warn before Gal'darah changes forms."

	L.form_rhino = "Rhino Form Soon"
	L.form_troll = "Troll Form Soon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"forms",
		59827, -- Impaling Charge
		59825, -- Whirling Slash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ImpalingCharge", 59827, 54956) -- Heroic, Normal
	self:Log("SPELL_AURA_APPLIED", "WhirlingSlash", 59825)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WhirlingSlash", 59825)
end

function mod:OnEngage()
	formPhase = 1
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 81 and formPhase == 1 then
		formPhase = formPhase + 1
		self:Message("forms", "Positive", nil, L.form_rhino, false)
	elseif hp < 56 and formPhase == 2 then
		formPhase = formPhase + 1
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1")
		self:Message("forms", "Positive", nil, L.form_troll, false)
	end
end

function mod:ImpalingCharge(args)
	self:TargetMessage(59827, args.destName, "Attention", "Info", nil, nil, true)
end

do
	local prev = 0
	function mod:WhirlingSlash(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
