
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oblivion Elemental", 2212)
if not mod then return end
mod:RegisterEnableMob(153244)
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
	self:RegisterEvent("ENCOUNTER_END")

	self:Log("SPELL_CAST_SUCCESS", "Hopelessness", 297574)
end

-- There are no boss frames to trigger the engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, engageId, name, diff, size, status)
	if engageId == self.engageId then
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
		self:SendMessage("BigWigs_EncounterEnd", self, engageId, name, diff, size, status)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hopelessness(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
