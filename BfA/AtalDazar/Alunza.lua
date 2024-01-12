--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Priestess Alun'za", 1763, 2082)
if not mod then return end
mod:RegisterEnableMob(122967) -- Priestess Alun'za
mod:SetEncounterID(2084)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local transfusionCount = 1
local spiritOfGoldCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local spiritOfGoldMarker = mod:AddMarkerOption(true, "npc", 8, 259205, 8) -- Spirit of Gold
function mod:GetOptions()
	return {
		255558, -- Tainted Blood
		{255577, "CASTBAR"}, -- Transfusion
		{255579, "DISPEL"}, -- Gilded Claws
		{255582, "DISPEL"}, -- Molten Gold
		277072, -- Corrupted Gold
		259205, -- Spirit of Gold
		spiritOfGoldMarker,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TaintedBloodApplied", 255558)
	self:Log("SPELL_AURA_REMOVED", "TaintedBloodRemoved", 255558)
	self:Log("SPELL_CAST_START", "Transfusion", 255577)
	self:Log("SPELL_CAST_SUCCESS", "TransfusionSuccess", 255577)
	self:Log("SPELL_CAST_SUCCESS", "GildedClaws", 255579)
	self:Log("SPELL_CAST_SUCCESS", "MoltenGold", 255591)
	self:Log("SPELL_AURA_APPLIED", "MoltenGoldApplied", 255582)
	self:Log("SPELL_AURA_APPLIED", "CorruptedGold", 277072)
	self:Log("SPELL_SUMMON", "SpiritOfGoldSummon", 259209)
end

function mod:OnEngage()
	transfusionCount = 1
	spiritOfGoldCount = 1
	if not self:Normal() then
		self:CDBar(259205, 9.0, CL.count:format(self:SpellName(259205), spiritOfGoldCount)) -- Spirit of Gold
	end
	if self:Tank() or self:Dispeller("magic", true, 255579) then
		self:CDBar(255579, 12.6) -- Gilded Claws
	end
	self:CDBar(255582, 16.6) -- Molten Gold
	self:CDBar(255577, 25.1, CL.count:format(self:SpellName(255577), transfusionCount)) -- Transfusion
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local taintedBloodCheck, name, onMe = nil, mod:SpellName(255558), false

	local function checkForTaintedBlood(self, firstCheck)
		if not onMe then
			self:Message(255558, "blue", CL.no:format(name))
			if not firstCheck then -- avoid spamming warning
				self:PlaySound(255558, "warning", "runin")
			end
			taintedBloodCheck = self:ScheduleTimer(checkForTaintedBlood, 1.5, self)
		else
			self:Message(255558, "green", CL.you:format(name))
			taintedBloodCheck = nil
		end
	end

	function mod:Transfusion(args)
		self:StopBar(CL.count:format(args.spellName, transfusionCount))
		self:Message(args.spellId, "red", CL.count:format(args.spellName, transfusionCount))
		self:PlaySound(args.spellId, "warning") -- voice warning is in the Taunted Blood check if needed
		self:CastBar(args.spellId, 4)
		transfusionCount = transfusionCount + 1
		self:CDBar(args.spellId, 34.0, CL.count:format(args.spellName, transfusionCount))
		checkForTaintedBlood(self, true)
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
	-- can be spellstolen, but using CAST_SUCCESS so don't have to filter based on destFlags
	if self:Tank() or self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "purple", CL.onboss:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 34.0)
	end
end

function mod:MoltenGold(args)
	self:CDBar(255582, 34.0)
end

function mod:MoltenGoldApplied(args)
	if self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:CorruptedGold(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId)
				self:PlaySound(args.spellId, "underyou", "gtfo")
			end
		end
	end
end

do
	local spiritOfGoldGUID = nil

	function mod:SpiritOfGoldSummon(args)
		self:StopBar(CL.count:format(self:SpellName(259205), spiritOfGoldCount))
		self:Message(259205, "cyan", CL.count:format(self:SpellName(259205), spiritOfGoldCount))
		self:PlaySound(259205, "info")
		spiritOfGoldCount = spiritOfGoldCount + 1
		self:CDBar(259205, 34.0, CL.count:format(self:SpellName(259205), spiritOfGoldCount))
		-- register events to auto-mark the add
		if self:GetOption(spiritOfGoldMarker) then
			spiritOfGoldGUID = args.destGUID
			self:RegisterTargetEvents("MarkSpiritOfGold")
		end
	end

	function mod:MarkSpiritOfGold(_, unit, guid)
		if spiritOfGoldGUID == guid then
			spiritOfGoldGUID = nil
			self:CustomIcon(spiritOfGoldMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end
