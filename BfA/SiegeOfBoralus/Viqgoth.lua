--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viq'Goth", 1822, 2140)
if not mod then return end
mod:RegisterEnableMob(128652) -- Viq'Goth
mod:SetEncounterID(2100)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local markCount = 1
local eradicationCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local putridWatersMarker = mod:AddMarkerOption(false, "player", 1, 275014, 1, 2, 3, 4)
function mod:GetOptions()
	return {
		"stages",
		{275014, "SAY"}, -- Putrid Waters
		putridWatersMarker,
		270185, -- Call of the Deep
		269456, -- Eradication
		-- Gripping Terror
		{269366, "CASTBAR"}, -- Repair
		-- Demolishing Terror
		269266, -- Slam
		270590, -- Hull Cracker
	}, {
		[269366] = -18334, -- Gripping Terror
		[269266] = -18340, -- Demolishing Terror
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Call of the Deep
	self:Log("SPELL_CAST_SUCCESS", "DamageBoss35", 269984)
	self:Log("SPELL_CAST_SUCCESS", "PutridWaters", 274991)
	self:Log("SPELL_AURA_APPLIED", "PutridWatersApplied", 275014)
	self:Log("SPELL_AURA_REMOVED", "PutridWatersRemoved", 275014)
	self:Log("SPELL_CAST_START", "Eradication", 269456)

	-- Gripping Terror
	self:Log("SPELL_CAST_START", "RepairStart", 269366)

	-- Demolishing Terror
	self:Log("SPELL_CAST_START", "Slam", 269266)
	self:Log("SPELL_CAST_START", "HullCracker", 270590)
	self:Death("DemolishingTerrorDeath", 137614, 137625, 137626) -- Stage 1, Stage 2, Stage 3
end

function mod:OnEngage()
	markCount = 1
	eradicationCount = 1
	self:SetStage(1)
	self:CDBar(275014, 3.2) -- Putrid Waters
	self:CDBar(270185, 7.0) -- Call of the Deep
end

function mod:VerifyEnable(unit)
	-- boss stays at 1 HP for a few seconds after the fight ends
	return self:GetHealth(unit) > 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 270183 then -- Call of the Deep
		self:Message(270185, "red")
		self:PlaySound(270185, "alarm")
		if self:GetStage() == 1 then
			self:CDBar(270185, 15.8)
		elseif self:GetStage() == 2 then
			self:CDBar(270185, 12.1)
		else -- Stage 3
			self:CDBar(270185, 7.3)
		end
	end
end

function mod:DamageBoss35()
	self:SetStage(self:GetStage() + 1)
	if self:GetStage() <= 3 then -- don't alert on the very last hit
		self:Message("stages", "green", CL.stage:format(self:GetStage()), false)
		self:PlaySound("stages", "long")
	end
end

do
	local playerList = {}

	function mod:PutridWaters(args)
		playerList = {}
		self:CDBar(275014, 20.6)
	end

	function mod:PutridWatersApplied(args)
		local playerListCount = #playerList+1
		playerList[playerListCount] = args.destName
		self:CustomIcon(putridWatersMarker, args.destName, markCount)
		markCount = (markCount % 4) + 1
		self:TargetsMessage(args.spellId, "yellow", playerList, 2, nil, nil, 0.6)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Putrid Waters")
			self:PlaySound(args.spellId, "warning")
		end
	end

	function mod:PutridWatersRemoved(args)
		self:CustomIcon(putridWatersMarker, args.destName)
	end
end

function mod:Eradication(args)
	if eradicationCount < 3 then -- ignore the 3rd cast, the fight is ending
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "warning")
		eradicationCount = eradicationCount + 1
	end
end

-- Gripping Terror

function mod:RepairStart(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CastBar(args.spellId, 3)
end

-- Demolishing Terror

function mod:Slam(args)
	self:Message(args.spellId, "orange")
	local mobId = self:MobId(args.sourceGUID)
	if mobId == 137614 then -- Stage 1
		self:CDBar(args.spellId, 18.2)
	elseif mobId == 137625 then -- Stage 2
		self:CDBar(args.spellId, 13.4)
	else -- 137626, Stage 3
		self:CDBar(args.spellId, 10.9)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:HullCracker(args)
	-- only cast when the tank is out of range
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end

function mod:DemolishingTerrorDeath(args)
	self:StopBar(269266) -- Slam
end
