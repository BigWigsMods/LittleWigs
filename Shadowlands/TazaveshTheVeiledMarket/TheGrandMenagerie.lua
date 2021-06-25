
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
mod.engageId = 2441

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Alcruux
		349627, -- Gluttony
		{350010, "EMPHASIZED", "ME_ONLY"}, -- Devoured Anima
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
	self:Log("SPELL_AURA_APPLIED", "PurificationProtocolApplied", 349954)
	self:Log("SPELL_AURA_REMOVED", "PurificationProtocolRemoved", 349954)
	self:Log("SPELL_CAST_START", "FlagellationProtocol", 349934)
	self:Log("SPELL_CAST_START", "VentingProtocol", 349987)

	-- Venza Goldfuse
	self:Log("SPELL_CAST_START", "ChainsOfDamnation", 350101)
	self:Log("SPELL_CAST_START", "WhirlingAnnihilation", 350086)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
end

function mod:GrandConsumption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
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
end

function mod:VentingProtocol(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(350101, "orange", name)
		self:PlaySound(350101, "alert", nil, name)
	end
	
	function mod:ChainsOfDamnation(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:WhirlingAnnihilation(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
