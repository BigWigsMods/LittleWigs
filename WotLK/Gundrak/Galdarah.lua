
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Gal'darah", 530, 596)
if not mod then return end
mod:RegisterEnableMob(29306)

local formPhase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.forms = "Forms"
	L.forms_desc = "Warn before Gal'darah changes forms."

	L.form_rhino = "Rhino Form Soon"
	L.form_troll = "Troll Form Soon"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"forms",
		59827, -- Impaling Charge
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target", "focus")
	self:Log("SPELL_CAST_SUCCESS", "ImpalingCharge", 59827, 54956) -- Heroic, Normal

	self:Death("Win", 29306)
end

function mod:OnEngage()
	formPhase = 1
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	if self:MobId(UnitGUID(unit)) == 29306 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 81 and formPhase == 1 then
			formPhase = formPhase + 1
			self:Message("forms", "Positive", nil, L.form_rhino, false)
		elseif hp < 56 and formPhase == 2 then
			formPhase = formPhase + 1
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target", "focus")
			self:Message("forms", "Positive", nil, L.form_troll, false)
		end
	end
end

function mod:ImpalingCharge(args)
	self:TargetMessage(59827, args.destName, "Attention", "Info", nil, nil, true)
end

