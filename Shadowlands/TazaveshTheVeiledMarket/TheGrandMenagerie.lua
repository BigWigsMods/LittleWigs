
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Grand Menagerie", 2441, 2454)
if not mod then return end
mod:RegisterEnableMob(
	176556, -- Alcruux
	176555, -- Achillite
	176705  -- Venza Goldfuse
)
mod:SetEncounterID(2441)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Alcruux
		349627, -- Gluttony
		{350010, "EMPHASIZE", "ME_ONLY"}, -- Devoured Anima
		349663, -- Grip of Hunger
		349797, -- Grand Consumption
		-- Achillite
		{349954, "SAY_COUNTDOWN"}, -- Purification Protocol
		349934, -- Flagellation Protocol
		349987, -- Venting Protocol
		-- Venza Goldfuse
		350101, -- Chains of Damnation
		350086, -- Whirling Annihilation
	}
end

function mod:OnBossEnable()
	-- Alcruus
	self:Log("SPELL_AURA_APPLIED", "GluttonyApplied", 349627)
	self:Log("SPELL_AURA_APPLIED", "DevouredAnimaApplied", 350010)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DevouredAnimaApplied", 350010)
	self:Log("SPELL_CAST_START", "GripOfHunger", 349663)
	self:Log("SPELL_CAST_SUCCESS", "GrandConsumption", 349797)

	-- Achillite
	self:Log("SPELL_CAST_SUCCESS", "PurificationProtocol", 349954)
	self:Log("SPELL_AURA_APPLIED", "PurificationProtocolApplied", 349954)
	self:Log("SPELL_AURA_REMOVED", "PurificationProtocolRemoved", 349954)
	self:Log("SPELL_CAST_START", "FlagellationProtocol", 349934)
	self:Log("SPELL_CAST_START", "VentingProtocol", 349987)

	-- Venza Goldfuse
	self:Log("SPELL_CAST_START", "ChainsOfDamnation", 350101)
	self:Log("SPELL_CAST_START", "WhirlingAnnihilation", 350086)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(349663, 12) -- Grip of Hunger
	self:Bar(349797, 25.9) -- Grand Consumption

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetStage() == 1 and self:GetBossId(176555) then -- Achillite
		self:SetStage(2)
		self:StopBar(349663) -- Grip of Hunger
		self:StopBar(349797) -- Grand Consumption
	
		self:Bar(349954, 6.7) -- Purification Protocol
		self:Bar(349934, 15.7) -- Flagellation Protocol
		self:Bar(349987, 26.7) -- Venting Protocol
	elseif self:GetStage() == 2 and self:GetBossId(176705) then -- Venza Goldfuse
		self:SetStage(3)
		self:StopBar(349954) -- Purification Protocol
		self:StopBar(349934) -- Flagellation Protocol
		self:StopBar(349987) -- Venting Protocol
	
		self:Bar(350101, 5.2) -- Chains of Damnation
		self:Bar(350086, 17.4) -- Whirling Annihilation
	end
end

function mod:GluttonyApplied(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:TargetBar(args.spellId, 21, args.destName)
end

function mod:DevouredAnimaApplied(args)
	local amount = args.amount or 1
	if amount % 5 == 0 then
		self:NewStackMessage(args.spellId, "green", args.destName, args.amount, 20) -- Caps at 20 stacks
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:GripOfHunger(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 23)
end

function mod:GrandConsumption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 30.3)
end

function mod:PurificationProtocol(args)
	self:CDBar(args.spellId, 18.2)
end

do
	local playerList = mod:NewTargetList()
	function mod:PurificationProtocolApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 2)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:SayCountdown(args.spellId, 6)
		end
	end
end

function mod:PurificationProtocolRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:FlagellationProtocol(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23)
end

function mod:VentingProtocol(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 27)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(350101, "orange", name)
		self:PlaySound(350101, "alert", nil, name)
	end
	
	function mod:ChainsOfDamnation(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 25.5)
	end
end

function mod:WhirlingAnnihilation(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 25.5)
end
