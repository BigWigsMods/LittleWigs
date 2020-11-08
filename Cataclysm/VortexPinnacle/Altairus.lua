
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Altairus", 657, 115)
if not mod then return end
mod:RegisterEnableMob(43873)
mod.engageId = 1041
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		88282, -- Upwind of Altairus
		88286, -- Downwind of Altairus
		{88308, "ICON"}, -- Chilling Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Upwind", 88282) -- Upwind of Altairus
	self:Log("SPELL_AURA_APPLIED", "Downwind", 88286) -- Downwind of Altairus
	self:Log("SPELL_AURA_REMOVED", "DownwindRemoved", 88286) -- Downwind of Altairus
	self:Log("SPELL_CAST_START", "ChillingBreath", 88308)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local haveDownwind = false -- for some reason players get spammed by SPELL_AURA_APPLIED events from Upwind when they have Downwind

	function mod:Upwind(args)
		if self:Me(args.destGUID) and not haveDownwind then
			self:TargetMessageOld(args.spellId, args.destName, "blue", "info")
		end
	end

	function mod:Downwind(args)
		if self:Me(args.destGUID) then
			self:TargetMessageOld(args.spellId, args.destName, "blue", "info")
			haveDownwind = true
		end
	end

	function mod:DownwindRemoved(args)
		if self:Me(args.destGUID) then
			haveDownwind = false
		end
	end
end

function mod:ChillingBreath(args)
	self:Bar(args.spellId, 12)
	self:TargetMessageOld(args.spellId, self:UnitName("boss1target"), "orange")
	self:PrimaryIcon(args.spellId, self:UnitName("boss1target"))
	self:ScheduleTimer("PrimaryIcon", 4, args.spellId)
end

