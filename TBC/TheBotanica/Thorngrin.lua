--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thorngrin the Tender", 553, 560)
if not mod then return end
mod:RegisterEnableMob(17978)
mod.engageId = 1928
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34661, -- Sacrifice
		{34659, "CASTBAR"}, -- Hellfire
		34670, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Sacrifice", 34661)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 34670)
	self:Log("SPELL_AURA_REMOVED", "AuraRemoved", 34661, 34670) -- Sacrifice, Enrage

	self:Log("SPELL_AURA_APPLIED", "Hellfire", 34659)
	self:Log("SPELL_DAMAGE", "HellfireDamage", 34660)
	self:Log("SPELL_MISSED", "HellfireDamage", 34660)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Sacrifice(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 8, args.destName)
	self:CDBar(args.spellId, 22)
end

function mod:Enrage(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "warning", nil, nil, self:Tank() or self:Healer()) -- or self:Dispeller("enrage"))
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:AuraRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Hellfire(args)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 6)
end

do
	local prev = 0
	function mod:HellfireDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > (self:Melee() and 6 or 1.5) then
				prev = t
				self:MessageOld(34659, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end
