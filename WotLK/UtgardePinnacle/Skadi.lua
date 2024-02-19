--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skadi the Ruthless", 575, 643)
if not mod then return end
mod:RegisterEnableMob(26693)
mod:SetEncounterID(mod:Classic() and 581 or 2029)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{59322, "SAY"}, -- Whirlwind
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 59322, 50228)
	self:Log("SPELL_DAMAGE", "WhirlwindDamage", 59323, 50229)
	self:Log("SPELL_MISSED", "WhirlwindDamage", 59323, 50229)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		self:TargetMessage(59322, "orange", player)
		self:PlaySound(59322, "info", nil, player)
		if self:Me(guid) then
			self:Say(59322, nil, nil, "Whirlwind")
		end
	end

	function mod:Whirlwind(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(59322, 10, CL.cast:format(args.spellName))
		self:CDBar(59322, 23)
	end
end

do
	local prev = 0
	function mod:WhirlwindDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(59322, "underyou")
				self:PlaySound(59322, "underyou", nil, args.destName)
			end
		end
	end
end
