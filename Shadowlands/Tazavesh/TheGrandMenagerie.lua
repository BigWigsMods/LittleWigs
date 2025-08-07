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
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local chainsOfDamnationCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.achillite_warmup_trigger = "Are rampaging beasts ruining your day? We have the solution!"
	L.venza_goldfuse_warmup_trigger = "Now's my chance! That axe is mine!"
	L.warmup_icon = "achievement_dungeon_brokerdungeon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- Alcruux
		349627, -- Gluttony
		350010, -- Devoured Anima
		349663, -- Grip of Hunger
		349797, -- Grand Consumption
		-- Achillite
		{349954, "SAY_COUNTDOWN"}, -- Purification Protocol
		{349934, "TANK_HEALER"}, -- Flagellation Protocol
		349987, -- Venting Protocol
		350045, -- Corrosive Anima
		350037, -- Exposed Anima Core
		-- Venza Goldfuse
		{350101, "SAY", "DISPEL"}, -- Chains of Damnation
		350086, -- Whirling Annihilation
	}, {
		[349627] = -23159, -- Alcruux
		[349954] = -23231, -- Achillite
		[350101] = -23241, -- Venza Goldfuse
	}
end

function mod:OnBossEnable()
	-- Staging
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Achillite and Venza Goldfuse engaged

	-- Alcruux
	self:Log("SPELL_AURA_APPLIED", "GluttonyApplied", 349627)
	self:Log("SPELL_AURA_REMOVED", "GluttonyRemoved", 349627)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DevouredAnimaApplied", 350010)
	self:Log("SPELL_CAST_START", "GripOfHunger", 349663)
	self:Log("SPELL_CAST_SUCCESS", "GrandConsumption", 349797)
	self:Death("AlcruuxDeath", 176556)

	-- Achillite
	self:Log("SPELL_CAST_SUCCESS", "PurificationProtocol", 349954)
	self:Log("SPELL_AURA_APPLIED", "PurificationProtocolApplied", 349954)
	self:Log("SPELL_AURA_REMOVED", "PurificationProtocolRemoved", 349954)
	self:Log("SPELL_CAST_START", "FlagellationProtocol", 349934)
	self:Log("SPELL_CAST_START", "VentingProtocol", 349987)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorrosiveAnimaDamage", 350045)
	self:Log("SPELL_PERIODIC_MISSED", "CorrosiveAnimaDamage", 350045)
	self:Log("SPELL_AURA_APPLIED", "ExposedAnimaCoreApplied", 350037) -- Achillite Death

	-- Venza Goldfuse
	self:Log("SPELL_CAST_START", "ChainsOfDamnation", 350101)
	self:Log("SPELL_AURA_APPLIED", "ChainsOfDamnationApplied", 350101)
	self:Log("SPELL_CAST_START", "WhirlingAnnihilation", 350086)
	self:Log("SPELL_DAMAGE", "WhirlingAnnihilationDamage", 350090)
	self:Death("VenzaGoldfuseDeath", 176705)
end

function mod:OnEngage()
	chainsOfDamnationCount = 1
	self:StopBar(CL.active)
	self:SetStage(1)
	-- first Gluttony applied shortly after pull
	self:CDBar(349663, 11.9) -- Grip of Hunger
	self:CDBar(349797, 25.7) -- Grand Consumption
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Staging

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 39, CL.active, L.warmup_icon)
end

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.achillite_warmup_trigger then
		self:Message("warmup", "cyan", CL.incoming:format(self:SpellName(-23231)), L.warmup_icon) -- Achillite
		self:Bar("warmup", 13.5, CL.count:format(CL.active, 2), L.warmup_icon)
		self:PlaySound("warmup", "long")
	elseif msg == L.venza_goldfuse_warmup_trigger then
		self:UnregisterEvent(event)
		self:Message("warmup", "cyan", CL.incoming:format(self:SpellName(-23241)), L.warmup_icon) -- Venza Goldfuse
		self:Bar("warmup", 23, CL.count:format(CL.active, 3), L.warmup_icon)
		self:PlaySound("warmup", "long")
	end
end

function mod:EncounterEvent(args)
	if self:MobId(args.sourceGUID) == 176555 then -- Achillite
		self:StopBar(CL.count:format(CL.active, 2))
		self:SetStage(2)
		self:CDBar(349954, 6.7) -- Purification Protocol
		self:CDBar(349934, 15.7) -- Flagellation Protocol
		self:CDBar(349987, 26.7) -- Venting Protocol
	elseif self:MobId(args.sourceGUID) == 176705 then -- Venza Goldfuse
		self:StopBar(CL.count:format(CL.active, 3))
		self:SetStage(3)
		self:CDBar(350101, 5.2) -- Chains of Damnation
		self:CDBar(350086, 17.4) -- Whirling Annihilation
	end
end

-- Alcruux

function mod:GluttonyApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 21.0, args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:GluttonyRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:DevouredAnimaApplied(args)
	if self:Me(args.destGUID) and args.amount % 5 == 0 then
		-- not using StackMessage in order to preserve message color, since alerts are just for the player
		self:Message(args.spellId, "green", CL.stackyou:format(args.amount, args.spellName))
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:GripOfHunger(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 23.0)
	self:PlaySound(args.spellId, "alarm")
end

function mod:GrandConsumption(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:AlcruuxDeath(args)
	self:StopBar(349663) -- Grip of Hunger
	self:StopBar(349797) -- Grand Consumption
end

-- Achillite

do
	local playerList = {}

	function mod:PurificationProtocol(args)
		playerList = {}
		self:CDBar(args.spellId, 23.9)
	end

	function mod:PurificationProtocolApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 2)
		if self:Me(args.destGUID) then
			self:SayCountdown(args.spellId, 6)
		end
		self:PlaySound(args.spellId, "alert", nil, playerList)
	end
end

function mod:PurificationProtocolRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:FlagellationProtocol(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 22.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:VentingProtocol(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 26.6)
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:CorrosiveAnimaDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:ExposedAnimaCoreApplied(args)
	self:Message(args.spellId, "cyan")
	self:StopBar(349954) -- Purification Protocol
	self:StopBar(349934) -- Flagellation Protocol
	self:StopBar(349987) -- Venting Protocol
	self:PlaySound(args.spellId, "info")
end

-- Venza Goldfuse

do
	local function printTarget(self, name, guid)
		self:TargetMessage(350101, "red", name)
		if self:Me(guid) then
			self:Say(350101, nil, nil, "Chains of Damnation")
		end
		self:PlaySound(350101, "alert", nil, name)
	end

	function mod:ChainsOfDamnation(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		chainsOfDamnationCount = chainsOfDamnationCount + 1
		if chainsOfDamnationCount == 2 then
			self:CDBar(args.spellId, 21.8)
		else
			self:CDBar(args.spellId, 30.3)
		end
	end
end

function mod:ChainsOfDamnationApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:WhirlingAnnihilation(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:WhirlingAnnihilationDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(350086, "underyou")
			self:PlaySound(350086, "underyou")
		end
	end
end

function mod:VenzaGoldfuseDeath(args)
	self:StopBar(350101) -- Chains of Damnation
	self:StopBar(350086) -- Whirling Annihilation
end
