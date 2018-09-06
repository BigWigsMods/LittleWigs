
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viq'Goth", 1822, 2140)
if not mod then return end
mod:RegisterEnableMob(128652) -- Viq'Goth
mod.engageId = 2100

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{275014, "FLASH", "SAY", "SAY_COUNTDOWN"}, -- Putrid Waters
		270185, -- Call of the Deep
		270605, -- Summon Demolisher XXX Icon and Desc needed (also for warnings and timer)
		269266, -- Slam
		269366, -- Repair
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "PutridWatersApplied", 275014)
	self:Log("SPELL_AURA_REMOVED", "PutridWatersRemoved", 275014)
	self:Log("SPELL_CAST_START", "Slam", 269266)
	self:Log("SPELL_CAST_START", "RepairStart", 269366)
end

function mod:OnEngage()
	stage = 1
	self:CDBar(275014, 5) -- Putrid Waters
	self:CDBar(270185, 6) -- Call of the Deep
	self:CDBar(270605, 20) -- Summon Demolisher
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 270183 then -- Call of the Deep
		self:Message(270185, "orange")
		self:PlaySound(270185, "alarm")

		local timer = stage == 1 and 15 or stage == 2 and 12 or 7
		self:CDBar(270185, timer)
	elseif spellId == 269984 then -- Damage Boss 35%
		stage = stage + 1
		if stage < 4 then
			self:Message("stages", "green", nil, CL.stage:format(stage), false)
			self:PlaySound("stages", "long")

			self:CDBar(270605, stage == 2 and 39.5 or 55.5) -- Summon Demolisher
		end
	elseif spellId == 270605 then -- Summon Demolisher
		self:Message(spellId, "yellow")
		self:PlaySound(spellId, "alert")
		self:CDBar(spellId, 20) -- XXX Need to Check
	end
end

do
	local playerList = mod:NewTargetList()
	function mod:PutridWatersApplied(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:CDBar(args.spellId, 20)
		end
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId)
			self:Flash(args.spellId)
			self:SayCountdown(args.spellId, 30)
		end
		self:TargetsMessage(args.spellId, "yellow", playerList, 2)
	end
end

function mod:PutridWatersRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:Slam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8)
end

function mod:RepairStart(args)
	self:Message(args.spellId, "cyan", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
