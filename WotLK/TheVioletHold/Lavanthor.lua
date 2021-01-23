--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lavanthor", 608, 630)
if not mod then return end
mod:RegisterEnableMob(
	29312, -- Lavanthor
	32237 -- Lava Hound (replacement boss)
)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{54282, "TANK_HEALER"}, -- Flame Breath
		54249, -- Lava Burn
		{-7491, "FLASH"}, -- Cauterizing Flames
	}, {
		[54282] = "normal",
		[-7491] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FlameBreath", 54282, 59469) -- Normal, Heroic
	self:Log("SPELL_CAST_SUCCESS", "LavaBurn", 54249, 59594) -- Normal, Heroic
	self:Log("SPELL_CAST_SUCCESS", "CauterizingFlames", 59466)

	self:Death("Win", 29312, 32237)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FlameBreath(args)
	self:Message(54282, "purple", CL.casting:format(args.spellName))
	self:PlaySound(54282, "alert")
end

function mod:LavaBurn(args)
	self:TargetMessage(54249, "orange", args.destName)
	self:PlaySound(54249, "alarm", nil, args.destName)
	self:CDBar(54249, 15)
end

function mod:CauterizingFlames(args)
	local canDispel = self:Dispeller("magic")

	self:Message(-7491, "red", CL.on_group:format(args.spellName))
	self:PlaySound(-7491, canDispel and "warning" or "long")
	-- self:CDBar(-7491, 0)
	if canDispel then
		self:Flash(-7491)
	end
end
