
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tugar Bloodtotem", 1129)
if not mod then return end
mod:RegisterEnableMob(117230, 117484) -- Tugar Bloodtotem, Jormog the Behemoth

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name "Tugar Bloodtotem"
end
mod.displayName = L.name

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		237950, -- Earthquake
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_SUCCESS", "Earthquake", 237950)

	self:Death("Win", 117230)
end

function mod:OnEngage()
	self:CDBar(237950, 21)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Earthquake(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CastBar(args.spellId, 5)
end

