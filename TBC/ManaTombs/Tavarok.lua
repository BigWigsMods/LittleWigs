
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Tavarok", 557, 535)
if not mod then return end
mod:RegisterEnableMob(18343)
-- mod.engageId = 1901 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{32361, "ICON"}, -- Crystal Prison
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CrystalPrison", 32361)
	self:Log("SPELL_AURA_REMOVED", "CrystalPrisonRemoved", 32361)

	self:Death("Win", 18343)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrystalPrison(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 5)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:CrystalPrisonRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
