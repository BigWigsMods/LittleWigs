-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grand Champions", 542, 634)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(
	-- Horde NPCs
	34657, 34701, 34702, 34703, 34705,
	-- Announcers
	35004, 35005,
	-- Alliance NPCs
	35569, 35570, 35571, 35572, 35617
)
mod.engageId = 2022
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{-7534, "FLASH"}, -- Poison Bottle
		67534, -- Hex of Mending
		67528, -- Healing Wave
		66043, -- Polymorph
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "HexOfMendingApplied", 67534)
	self:Log("SPELL_AURA_REMOVED", "HexOfMendingRemoved", 67534)
	self:Log("SPELL_CAST_START", "HealingWave", 67528)
	self:Log("SPELL_AURA_APPLIED", "PolymorphApplied", 66043)
	self:Log("SPELL_AURA_REMOVED", "PolymorphRemoved", 66043)
	self:Log("SPELL_AURA_APPLIED", "PoisonBottle", 67701, 67594)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:HexOfMendingApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:HexOfMendingRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:HealingWave(args)
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
end

function mod:PolymorphApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 4, args.destName)
end

function mod:PolymorphRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

do
	local prev = 0
	function mod:PoisonBottle(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 4 then
				self:TargetMessage(-7534, args.destName, "Personal", "Alarm")
				self:Flash(-7534)
				prev = t
			end
		end
	end
end
