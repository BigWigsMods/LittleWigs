
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Therum Deepforge", 2213)
if not mod then return end
mod:RegisterEnableMob(156577)
mod.engageId = 2374

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		309671, -- Empowered Forge Breath
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")

	self:Log("SPELL_CAST_START", "EmpoweredForgeBreath", 309671)
end

-- There are no boss frames to trigger the engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

function mod:OnEngage()
	self:Bar(309671, 8.5) -- Empowered Forge Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EmpoweredForgeBreath(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 14.6)
end
