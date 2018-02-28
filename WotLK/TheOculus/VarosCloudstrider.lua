-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Varos Cloudstrider", 528, 623)
if not mod then return end
--mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27447)

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		51054, -- Amplify Magic
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AmplifyMagic", 51054, 59371)
	self:Log("SPELL_AURA_REMOVED", "AmplifyMagicRemoved", 51054, 59371)
	self:Death("Win", 27447)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:AmplifyMagic(args)
	self:TargetMessage(51054, args.destName, "Important")
	self:TargetBar(51054, 30, args.destName)
end

function mod:AmplifyMagicRemoved(args)
	self:StopBar(51054, args.destName)
end
