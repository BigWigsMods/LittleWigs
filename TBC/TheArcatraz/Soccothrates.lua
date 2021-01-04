
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Wrath-Scryer Soccothrates", 552, 550)
if not mod then return end
mod:RegisterEnableMob(20886)
mod.engageId = 1915
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{-5293, "SAY"}, -- Felfire
		35759, -- Felfire Shock
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "FelfireKnockback", 36512) -- Knockback before the charge that leaves a trail of fire

	self:Log("SPELL_AURA_APPLIED", "FelfireShock", 35759, 39006) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "FelfireShockRemoved", 35759, 39006)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FelfireKnockback()
	self:MessageOld(-5293, "red", nil, CL.incoming:format(self:SpellName(-5293)))
	self:CastBar(-5293, 4.9)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(-5293, 100) -- 100 = Charge
		end
		self:TargetMessageOld(-5293, player, "orange", nil, 100, -5293)
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 36038 then -- Charge Targeting
			self:GetBossTarget(printTarget, 0.4, self:UnitGUID(unit))
		end
	end
end

function mod:FelfireShock(args)
	if self:Me(args.destGUID) or (args.spellId == 35759 and self:Dispeller("magic")) then -- heroic version can't be dispelled
		self:TargetMessageOld(35759, args.destName, "yellow")
		self:TargetBar(35759, 6, args.destName)
	end
end

function mod:FelfireShockRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
