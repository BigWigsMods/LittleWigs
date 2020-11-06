
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Priestess Alun'za", 1763, 2082)
if not mod then return end
mod:RegisterEnableMob(122967)
mod.engageId = 2084
mod.respawnTime = 30

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
	self:Log("SPELL_AURA_REMOVED", "TaintedBloodRemoved", 255558)
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
	local taintedBloodCheck, name, onMe = nil, mod:SpellName(255558), false

	local function checkForTaintedBlood(self)
		if not onMe then
			self:Message(255558, "blue", CL.no:format(name))
			self:PlaySound(255558, "warning", "runin")
			taintedBloodCheck = self:ScheduleTimer(checkForTaintedBlood, 1.5, self)
		else
			self:Message(255558, "green", CL.you:format(name))
			taintedBloodCheck = nil
		end
	end

	function mod:Transfusion(args)
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning") -- voice warning is in the Taunted Blood check if needed
		self:Bar(args.spellId, 34)
		self:Bar(args.spellId, 4, CL.cast:format(args.spellName))
		checkForTaintedBlood(self)
	end

	function mod:TaintedBloodApplied(args)
		if self:Me(args.destGUID) then
			onMe = true
			if taintedBloodCheck then -- immediately check and give the positive message
				self:CancelTimer(taintedBloodCheck)
				checkForTaintedBlood(self)
			end
		end
	end

	function mod:TaintedBloodRemoved(args)
		if self:Me(args.destGUID) then
			onMe = false
		end
	end

	function mod:TransfusionSuccess()
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
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Dispeller("magic") then
		self:PlaySound(args.spellId, "info", "dispelnow", args.destName)
	elseif self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "info")
	end
	self:Bar(args.spellId, 34)
end

do
	local prev = 0
	function mod:CorruptedGold(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "alarm", "gtfo")
			end
		end
	end
end
