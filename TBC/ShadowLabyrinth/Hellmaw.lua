-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ambassador Hellmaw", 724, 544)
if not mod then return end
mod:RegisterEnableMob(18731)
-- mod.engageId = 1908 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		33547, -- Fear
		"berserk",
	},{
		[33547] = "general",
		["berserk"] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Fear", 33547)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 18731)
end

function mod:OnEngage()
	self:CDBar(33547, 15)
	if not self:Normal() then self:Berserk(180) end
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Fear(args)
	self:CDBar(args.spellId, 25.5) -- 25.5 - 30s
end
