--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Moragg", 608, 627)
if not mod then return end
mod:RegisterEnableMob(
	29316, -- Moragg
	32235 -- Chaos Watcher (replacement boss)
)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		54396, -- Optic Link
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "OpticLink", 54396)
	self:Log("SPELL_AURA_REMOVED", "OpticLinkRemoved", 54396)

	self:Death("Win", 29316, 32235)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:OpticLink(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:TargetBar(args.spellId, 12, args.destName)

	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:OpticLinkRemoved(args)
	self:StopBar(args.spellName, args.spellId)
end
