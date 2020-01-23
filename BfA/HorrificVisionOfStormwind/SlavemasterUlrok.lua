
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Slavemaster Ul'rok", 2213)
if not mod then return end
mod:RegisterEnableMob(153541)
mod.engageId = 2375

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		298691, -- Chains of Servitude
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChainsOfServitude", 298691)
end

-- There is no INSTANCE_ENCOUNTER_ENGAGE_UNIT event to trigger the engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChainsOfServitude(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
