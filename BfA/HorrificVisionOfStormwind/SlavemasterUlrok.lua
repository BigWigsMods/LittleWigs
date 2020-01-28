
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Slavemaster Ul'rok", 2213)
if not mod then return end
mod:RegisterEnableMob(153541)
mod.engageId = 2375

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.slavemaster_ulrok = "Slavemaster Ul'rok"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		298691, -- Chains of Servitude
	}
end

function mod:OnRegister()
	self.displayName = L.slavemaster_ulrok
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")

	self:Log("SPELL_CAST_START", "ChainsOfServitude", 298691)
end

-- There are no boss frames to trigger the engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
	if engageId == self.engageId then
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
	end
end


--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChainsOfServitude(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
