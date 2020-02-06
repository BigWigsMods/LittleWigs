
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oblivion Elemental", 2212)
if not mod then return end
mod:RegisterEnableMob(153244)
mod:SetAllowWin(true)
mod.engageId = 2372

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.oblivion_elemental = "Oblivion Elemental"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297574, -- Hopelessness
	}
end

function mod:OnRegister()
	self.displayName = L.oblivion_elemental
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")

	self:Log("SPELL_CAST_SUCCESS", "Hopelessness", 297574)
end

-- There are no boss frames to trigger the engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hopelessness(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
