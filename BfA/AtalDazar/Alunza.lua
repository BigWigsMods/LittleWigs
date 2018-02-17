--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Priestess Alun'za", 1204, 2082)
if not mod then return end
mod:RegisterEnableMob(122967)
mod.engageId = 2084

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		255558, -- Tainted Blood
		255577, -- Transfusion
		{255579, "TANK"}, -- Gilded Claws
		255582, -- Molten Gold
		258709, -- Corrupted Gold
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TaintedBloodApplied", 255558)
	self:Log("SPELL_CAST_START", "Transfusion", 255577)
	self:Log("SPELL_CAST_SUCCESS", "TransfusionSuccess", 255577)
	self:Log("SPELL_CAST_START", "GildedClaws", 255579)
	self:Log("SPELL_AURA_APPLIED", "MoltenGold", 255582)
	self:Log("SPELL_DAMAGE", "CorruptedGold", 258709)
	self:Log("SPELL_ABSORBED", "CorruptedGold", 258709)
end

function mod:OnEngage()
	self:Bar(255579, 11) -- Gilded Claws
	self:Bar(255582, 19) -- Molten Gold
	self:Bar(255577, 25) -- Transfusion
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local taintedBloodCheck, name = nil, mod:SpellName(255558)

	local function checkForTaintedBlood()
		if not UnitDebuff("player", name) then
			mod:Message(255558, "blue", "Warning", CL.no:format(name))
			taintedBloodCheck = mod:ScheduleTimer(checkForTaintedBlood, 1.5)
		else
			mod:Message(255558, "green", nil, CL.you:format(name))
			taintedBloodCheck = nil
		end
	end

	function mod:Transfusion(args)
		self:Message(args.spellId, "red", "Warning", CL.casting:format(args.spellName))
		self:Bar(args.spellId, 34)
		self:Bar(args.spellId, 4, CL.cast:format(args.spellName))
		checkForTaintedBlood()
	end

	function mod:TaintedBloodApplied(args)
		if taintedBloodCheck and self:Me(args.destGUID) then
			self:CancelTimer(taintedBloodCheck)
			checkForTaintedBlood() -- immediately check and give the positive message
		end
	end

	function mod:TransfusionSuccess(args)
		if taintedBloodCheck then
			self:CancelTimer(taintedBloodCheck)
			taintedBloodCheck = nil
		end
	end
end

function mod:GildedClaws(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:Bar(args.spellId, 34)
end

function mod:MoltenGold(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, args.destName, "orange", "Info")
	end
	self:Bar(args.spellId, 34)
end

do
	local prev = 0
	function mod:CorruptedGold(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then
			prev = GetTime()
			self:Message(args.spellId, "blue", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end
