
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Gal'darah", 604, 596)
if not mod then return end
mod:RegisterEnableMob(29306)
mod.engageId = 1981
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.forms = "Forms"
	L.forms_desc = "Warn before Gal'darah changes forms."

	L.form_rhino = "Rhino Form"
	L.form_troll = "Troll Form"
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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "ImpalingCharge", 59827, 54956) -- Heroic, Normal
	self:Log("SPELL_AURA_APPLIED", "WhirlingSlash", 59825, 55249) -- Heroic, Normal
	self:Log("SPELL_AURA_APPLIED_DOSE", "WhirlingSlash", 59825, 55249) -- Heroic, Normal
end

function mod:OnEngage()
	self:CDBar("forms", 32.5, L.form_rhino, "ability_hunter_pet_rhino")
	self:DelayedMessage("forms", 27.5, "yellow", CL.soon:format(L.form_rhino))
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 55297 then -- Rhino Form
		self:CDBar("forms", 34.1, L.form_troll, "achievement_character_troll_male")
		self:DelayedMessage("forms", 29, "yellow", CL.soon:format(L.form_troll))
	elseif spellId == 55299 then -- Troll Form
		self:CDBar("forms", 33.6, L.form_rhino, "ability_hunter_pet_rhino")
		self:DelayedMessage("forms", 28.5, "yellow", CL.soon:format(L.form_rhino))
	end
end

function mod:ImpalingCharge(args)
	self:TargetMessageOld(59827, args.destName, "yellow", "info", nil, nil, true)
end

do
	local prev = 0
	function mod:WhirlingSlash(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(59825, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
