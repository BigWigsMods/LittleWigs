-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Devourer of Souls", 601, 616)
if not mod then return end
--mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36502)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{69051, "ICON"}, -- Mirrored Soul
		68912, -- Wailing Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MirroredSoul", 69051)
	self:Log("SPELL_AURA_REMOVED", "MirroredSoulRemoved", 69051)
	self:Log("SPELL_AURA_APPLIED", "WailingSoul", 68912)
	self:Death("Win", 36502)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MirroredSoul(args)
	if self:MobId(args.destGUID) == 36502 then return end
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert")
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:MirroredSoulRemoved(args)
	if self:MobId(args.destGUID) == 36502 then return end
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellId, args.destName)
end

function mod:WailingSoul(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 15)
end
