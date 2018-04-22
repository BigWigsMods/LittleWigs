if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Priestess Alun'za", 1763, 2082)
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

	local function checkForTaintedBlood(self)
		if not UnitDebuff("player", name) then
			self:Message(255558, "blue", nil, CL.no:format(name))
			self:PlaySound(255558, "warning", "runin")
			taintedBloodCheck = self:ScheduleTimer(checkForTaintedBlood, 1.5)
		else
			self:Message(255558, "green", nil, CL.you:format(name))
			taintedBloodCheck = nil
		end
	end

	function mod:Transfusion(args)
		self:Message(args.spellId, "red", nil, CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning") -- voice warning is in the Taunted Blood check if needed
		self:Bar(args.spellId, 34)
		self:Bar(args.spellId, 4, CL.cast:format(args.spellName))
		checkForTaintedBlood(self)
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
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "defensive")
	self:Bar(args.spellId, 34)
end

function mod:MoltenGold(args)
	self:TargetMessage(args.spellId, args.destName, "orange")
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:PlaySound(args.spellId, "info", self:Dispeller("magic") and "dispelnow")
	end
	self:Bar(args.spellId, 34)
end

do
	local prev = 0
	function mod:CorruptedGold(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then
			prev = GetTime()
			self:Message(args.spellId, "blue", nil, CL.underyou:format(args.spellName))
			self:PlaySound(args.spellId, "alarm", "gtfo")
		end
	end
end
