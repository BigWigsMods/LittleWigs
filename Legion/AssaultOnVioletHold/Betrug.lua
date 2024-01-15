
--------------------------------------------------------------------------------
-- TODO List:
-- - Seeds are interrupted for Smash / Execution Combo, timer started in Smash
--   might be wrong

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fel Lord Betrug", 1544, 1711)
if not mod then return end
mod:RegisterEnableMob(102446)
mod.engageId = 1856

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		203641, -- Fel Slash
		202328, -- Mighty Smash
		{205233, "SAY", "FLASH"}, -- Execution
		{210879, "SAY"}, -- Seed of Destruction
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FelSlash", 203641)
	self:Log("SPELL_CAST_START", "MightySmash", 202328)
	self:Log("SPELL_AURA_APPLIED", "Execution", 205233)
	self:Log("SPELL_AURA_REMOVED", "ImpactRemoved", 205265) -- Execution root
	self:Log("SPELL_AURA_APPLIED", "SeedOfDestruction", 210879)
end

function mod:OnEngage()
	self:Bar(210879, 16) -- Seed of Destruction
	self:CDBar(205233, 34) -- Execution
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FelSlash(args)
	self:MessageOld(args.spellId, "red")
end

function mod:MightySmash(args)
	self:MessageOld(args.spellId, "orange", "long", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
	--CDBar is being covered by Execution
	self:CDBar(210879, 21) -- Seed of Destruction, very vague timer
end

function mod:Execution(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alarm", nil, nil, true)
	self:CDBar(args.spellId, 48)
	self:TargetBar(args.spellId, 20, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Execution")
	end
end

function mod:ImpactRemoved(args) -- Execution root got removed
	self:StopBar(205233, args.destName) -- Stop Execution bar
	self:TargetMessageOld(205233, args.destName, "green", "info", CL.removed:format(self:SpellName(75215)), 205233, true) -- Root removed with Execution icon
	if self:Me(args.destGUID) then
		self:Flash(205233)
	end
end

do
	local list = mod:NewTargetList()
	function mod:SeedOfDestruction(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.1, args.spellId, list, "yellow", "alert", nil, nil, true)
			self:CDBar(args.spellId, 22)
		end
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Seed of Destruction")
		end
	end
end
