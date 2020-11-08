--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Botanist Freywinn", 553, 559)
if not mod then return end
mod:RegisterEnableMob(17975)
mod.engageId = 1926
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local addsAlive = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34550, -- Tranquility
		34752, -- Freezing Touch
	}, {
		[34550] = "general",
		[34752] = -5453, -- White Seedling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Tranquility", 34551) -- 34551 = "Tree Form", the buff he applies to himself while channeling Tranquility. He applies 34550 to every unit being healed.
	self:Log("SPELL_AURA_REMOVED", "TranquilityOver", 34551)
	self:Log("SPELL_CAST_SUCCESS", "SummonFrayerProtectors", 34557)
	self:Death("AddDeath", 19953)

	self:Log("SPELL_AURA_APPLIED", "FreezingTouch", 34752)
	self:Log("SPELL_AURA_REMOVED", "FreezingTouchRemoved", 34752)
end

function mod:OnEngage()
	addsAlive = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Tranquility()
	self:MessageOld(34550, "red", "long", CL.casting:format(self:SpellName(34550)))
	self:CastBar(34550, 45)
end

function mod:TranquilityOver()
	self:MessageOld(34550, "green", nil, CL.over:format(self:SpellName(34550)))
	self:StopBar(CL.cast:format(self:SpellName(34550)))
end

function mod:SummonFrayerProtectors()
	addsAlive = addsAlive + 3
end

function mod:AddDeath()
	addsAlive = addsAlive - 1
	self:MessageOld(34550, "green", "info", CL.add_remaining:format(addsAlive))
end

function mod:FreezingTouch(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 3, args.destName)
end

function mod:FreezingTouchRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
