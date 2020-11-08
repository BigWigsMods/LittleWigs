-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Devourer of Souls", 632, 616)
if not mod then return end
mod:RegisterEnableMob(36502)
mod.engageId = 2007
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{69051, "ICON"}, -- Mirrored Soul
		68912, -- Wailing Souls
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MirroredSoul", 69051)
	self:Log("SPELL_AURA_REMOVED", "MirroredSoulRemoved", 69051)
	self:Log("SPELL_AURA_APPLIED", "WailingSouls", 68912)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MirroredSoul(args)
	if self:MobId(args.destGUID) ~= 36502 then -- both the boss and its target get this debuff
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alert")
		self:TargetBar(args.spellId, 8, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end
end

function mod:MirroredSoulRemoved(args)
	if self:MobId(args.destGUID) ~= 36502 then
		self:PrimaryIcon(args.spellId)
		self:StopBar(args.spellName, args.destName)
	end
end

function mod:WailingSouls(args)
	self:MessageOld(args.spellId, "red")
	self:Bar(args.spellId, 15)
end
