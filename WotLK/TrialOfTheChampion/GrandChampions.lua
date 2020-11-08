-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grand Champions", 650, 634)
if not mod then return end
mod:RegisterEnableMob(
	-- Horde NPCs
	34657, 34701, 34702, 34703, 34705,
	-- Mounts
	36557, 36559,
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
		-7534,  -- Poison Bottle
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
	self:Log("SPELL_AURA_APPLIED", "PoisonBottle", 67594)
	self:Log("SPELL_PERIODIC_DAMAGE", "PoisonBottle", 67594)
	self:Log("SPELL_PERIODIC_MISSED", "PoisonBottle", 67594)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:HexOfMendingApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:HexOfMendingRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:HealingWave(args)
	self:MessageOld(args.spellId, "orange", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
end

function mod:PolymorphApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 4, args.destName)
end

function mod:PolymorphRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

do
	local prev = 0
	function mod:PoisonBottle(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:MessageOld(-7534, "blue", "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
