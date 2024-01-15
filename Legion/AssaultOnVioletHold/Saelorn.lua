
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Saelorn", 1544, 1697)
if not mod then return end
mod:RegisterEnableMob(102387)
mod.engageId = 1851

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{202414, "SAY"}, -- Venom Spray
		{202306, "FLASH"}, -- Creeping Slaughter
		202473, -- Fel Detonation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "VenomSpray", 202414)
	self:Log("SPELL_AURA_APPLIED", "CreepingSlaughter", 202306)
	self:Log("SPELL_CAST_START", "FelDetonation", 202473)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local list = mod:NewTargetList()
	function mod:VenomSpray(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.1, args.spellId, list, "yellow", "alert", nil, nil, self:Dispeller("poison"))
			self:CDBar(args.spellId, 22)
		end
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Venom Spray")
		end
	end
end

function mod:CreepingSlaughter(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm")
		self:Flash(args.spellId)
	end
end

function mod:FelDetonation(args)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 30)
end
