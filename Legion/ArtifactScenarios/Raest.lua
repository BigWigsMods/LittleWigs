
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Raest", 1684) -- Thwarting the Twins
if not mod then return end
mod:RegisterEnableMob(116409, 116410) -- Raest Magespear, Karam Magespear
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1
local handGUID = ""

----------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Raest Magespear"

	L.handFromBeyond = "Hand from Beyond"
	L.handFromBeyond_icon = 229022 -- Grasping Hand

	L.rune = 236468
	L.rune_desc = "Places a Rune of Summoning on the ground. If left unsoaked a Thing of Nightmare will spawn."
	L.rune_icon = 236468

	L.thing = 236470
	L.thing_desc = "{236461}"
	L.thing_icon = 236470

	L.killed = "%s killed"

	L.warmup_text = "Karam Magespear Active"
	-- L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	-- L.warmup_trigger2 = "Kill this interloper, brother!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		202081, -- Fixate
		235308, -- Purgatory

		--[[ Stage 2 ]]--
		"handFromBeyond",
		{235578, "FLASH"}, -- Grasp from Beyond

		--[[ Stage 3 ]]--
		{"rune", "FLASH"},
		"thing",
	}, {
		["warmup"] = "general",
		["handFromBeyond"] = CL.stage:format(2),
		["rune"] = CL.stage:format(3),
	}
end

function mod:OnRegister()
	self.displayName = L.name

	-- Big evul hack to enable the module when entering the scenario
	self:RegisterEvent("SCENARIO_UPDATE")
	if C_Scenario.IsInScenario() then
		self:SCENARIO_UPDATE()
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4", "boss5")

	self:Log("SPELL_CAST_START", "Purgatory", 235308)
	self:Log("SPELL_AURA_REMOVED", "PurgatoryRemoved", 235308)
	self:Log("SPELL_CAST_START", "GraspFromBeyond", 235578)
	self:Log("SPELL_INTERRUPT", "Interrupts", "*")
	self:Death("HandFromBeyondDeath", 118698)

	self:Death("Win", 116409)
end

function mod:OnEngage()
	phase = 1
	handGUID = ""
end

function mod:OnDisable()
	self:RegisterEvent("SCENARIO_UPDATE")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SCENARIO_UPDATE()
	if self:IsEnabled() then return end
	local _, _, numCriteria = C_Scenario.GetStepInfo()
	for i = 1, numCriteria do
		local criteriaID = select(9, C_Scenario.GetCriteriaInfo(i))
		if criteriaID == 35050 then -- Raest confronted
			mod:Enable()
		end
	end
end

function mod:Warmup(event)
	self:UnregisterEvent(event)
	self:Bar("warmup", 45.7, L.warmup_text, "ability_fixated_state_red")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 202081 then -- Fixate
		self:Message(spellId, "Important", "Long", spellName .. " - " .. CL.stage:format(phase))
		if phase == 2 then
			self:Bar("handFromBeyond", 9, L.handFromBeyond, L.handFromBeyond_icon) -- Grasp from Beyond
		end
	elseif spellId == 236468 then -- Rune of Summoning
		self:Message("rune", "Attention", "Warning", spellName, spellId)
		self:Flash("rune")
		self:CDBar("rune", 37, spellName, spellId)
		self:Bar("thing", 11, self:SpellName(L.thing), L.thing_icon)
	elseif spellId == 236470 then -- Thing of Nightmares
		self:Message("thing", "Important", "Alarm", spellName, spellId)
	end
end

function mod:Purgatory(args)
	self:Message(args.spellId, "Positive", "Info")
	phase = phase + 1
	self:CastBar(args.spellId, 38.3)
	if phase == 3 then
		self:Bar("rune", 24, self:SpellName(L.rune), L.rune_icon)
	end
end

function mod:PurgatoryRemoved(args)
	self:Message(args.spellId, "Positive", "Info", CL.over:format(args.spellName))
	self:StopBar(CL.cast:format(args.spellName))
end

function mod:GraspFromBeyond(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:CastBar(args.spellId, 10)
	self:Bar(args.spellId, 15)
	if handGUID ~= args.sourceGUID then
		handGUID = args.sourceGUID
		self:Bar("handFromBeyond", 28, L.handFromBeyond, L.handFromBeyond_icon)
	end
	self:Flash(args.spellId)
end

function mod:Interrupts(args)
	if args.extraSpellId == 235578 then -- Grasp from Beyond
		self:Message(235578, "Personal", nil, CL.interrupted:format(args.extraSpellName))
		self:StopBar(CL.cast:format(args.extraSpellName))
	end
end

function mod:HandFromBeyondDeath(args)
	self:Message("handFromBeyond", "Neutral", nil, L.killed:format(L.handFromBeyond), false)
	self:StopBar(CL.cast:format(self:SpellName(235578))) -- Grasp from Beyond
	self:StopBar(235578) -- Grasp from Beyond
end
