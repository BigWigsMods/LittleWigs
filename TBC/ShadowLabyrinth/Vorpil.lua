-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grandmaster Vorpil", 555, 546)
if not mod then return end
mod:RegisterEnableMob(18732)
-- mod.engageId = 1911 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		-5267, -- Draw Shadows
		38791, -- Banish
	},{
		[-5267] = "general",
		[38791] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DrawShadows", 33563)
	self:Log("SPELL_AURA_APPLIED", "Banish", 38791)
	self:Log("SPELL_AURA_REMOVED", "BanishRemoved", 38791)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 18732)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:CDBar(-5267, 44) -- Draw Shadows
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:DrawShadows()
	self:Message(-5267, "Urgent")
	self:CDBar(-5267, 41)
end

function mod:Banish(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:BanishRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
