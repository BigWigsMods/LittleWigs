
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rexxar", 2212)
if not mod then return end
mod:RegisterEnableMob(155098)
mod.engageId = 2370

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rexxar = "Rexxar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		304251, -- Void Quills
	}
end

function mod:OnRegister()
	self.displayName = L.rexxar
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")

	self:Log("SPELL_CAST_START", "VoidQuills", 304251)
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

do
	local prev = 0
	function mod:VoidQuills(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end
