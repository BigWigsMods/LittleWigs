
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Dalliah the Doomsayer", 552, 549)
if not mod then return end
mod:RegisterEnableMob(20885)
mod.engageId = 1913
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39013, -- Heal
		{36175, "CASTBAR"}, -- Whirlwind
		39009, -- Gift of the Doomsayer
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Heal", 36144, 39013) -- normal, heroic

	self:Log("SPELL_CAST_START", "Whirlwind", 36142, 36175) -- normal, heroic
	self:Log("SPELL_DAMAGE", "WhirlwindDamage", 36142, 36175)
	self:Log("SPELL_MISSED", "WhirlwindDamage", 36142, 36175)

	self:Log("SPELL_CAST_START", "GiftOfTheDoomsayer", 36173, 39009) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "GiftOfTheDoomsayerApplied", 36173, 39009)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Heal(args)
	self:MessageOld(39013, "orange", nil, CL.casting:format(args.spellName))
end

function mod:Whirlwind()
	self:MessageOld(36175, "red")
	self:CastBar(36175, 6)
end

do
	local prev = 0
	function mod:WhirlwindDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > (self:Melee() and 6 or 1.5) then
				prev = t
				self:MessageOld(36175, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:GiftOfTheDoomsayer(args)
	self:MessageOld(39009, "yellow", nil, CL.casting:format(args.spellName))
end

function mod:GiftOfTheDoomsayerApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(39009, args.destName, "yellow")
		self:TargetBar(39009, 10, args.destName)
	end
end
