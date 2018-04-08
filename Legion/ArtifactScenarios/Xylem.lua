
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archmage Xylem", 1673) -- Closing the Eye
if not mod then return end
mod:RegisterEnableMob(115244) -- Archmage Xylem
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1
local blinkCount = 1
local annihilationCount = 0
local drawPowerCount = 0

local blinkSpells = {
	232661, -- Razor Ice x3
	232661,
	232661,
	234728, -- Arcane Annihilation
	false,
	234728, -- Arcane Annihilation
	-- XXX don't have much for logs after the second Arcane Annihilation
	-- 232661, Razor Ice
	-- (Shadow Barrage not blink),
}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Archmage Xylem"
	L.corruptingShadows = "Corrupting Shadows"

	-- L.warmup_trigger1 = "You are too late, warrior! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!"
	-- L.warmup_trigger2 = "Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",

		--[[ Phase 1 ]]--
		242015, -- Blink
		234728, -- Arcane Annihilation
		231443, -- Shadow Barrage
		231522, -- Draw Power

		--[[ Phase 2 ]]--
		232672, -- Creeping Shadows
		233248, -- Seed of Darkness
	},{
		warmup = "general",
		[242015] = L.name,
		[232672] = L.corruptingShadows,
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
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", nil, "boss1")

	self:Log("SPELL_CAST_START", "ArcaneAnnihilation", 234728)
	self:Log("SPELL_CAST_SUCCESS", "ShadowBarrage", 231443)
	self:Log("SPELL_CAST_SUCCESS", "DrawPower", 231522)

	self:Log("SPELL_PERIODIC_DAMAGE", "CreepingShadowsDamage", 232672)
	self:Log("SPELL_CAST_SUCCESS", "SeedOfDarkness", 233248)

	self:Death("Win", 116839) -- Corrupting Shadows
end

function mod:OnEngage()
	phase = 1
	blinkCount, drawPowerCount, annihilationCount = 1, 0, 0

	self:Bar(242015, 11, ("%s (%s)"):format(self:SpellName(242015), self:SpellName(232661))) -- Blink (Razor Ice)
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
		if criteriaID == 34702 then -- Confront Archmage Xylem
			mod:Enable()
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if not self.isEngaged then
		self:CheckForEncounterEngage()
	else
		if UnitIsDead("player") then
			-- u dun goof'd
			self:ScheduleTimer("Wipe", 4)
			return
		end
		if phase == 1 and not UnitExists("boss1") then
			-- Need to ignore the IEEU from defeating Archmage Xylem so we don't disable
			self:SendMessage("BigWigs_StopBars", self)
			phase = 2
			self:Message("stages", "Neutral", nil, CL.soon:format(CL.phase:format(2)), false)
			self:Bar("warmup", 29, CL.phase:format(2), "spell_arcane_prismaticcloak")
		elseif phase == 2 and UnitExists("boss1") then
			-- Phase 2 OnEngage
			phase = 3
			self:Message("stages", "Neutral", nil, CL.phase:format(2), false)
			self:Bar(233248, 21) -- Seed of Darkness

			self:RegisterEvent(event, "CheckBossStatus") -- Shenanigans over
		end
	end
end

---------------------------------------
-- Archmage Xylem

function mod:Warmup(event)
	self:UnregisterEvent(event)
	self:Bar("warmup", 28, CL.active, "spell_mage_focusingcrystal")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 242015 then -- Blink
		self:Message(242015, "Attention", nil, blinkSpells[blinkCount] and ("%s (%s)"):format(spellName, self:SpellName(blinkSpells[blinkCount])) or spellName)
		blinkCount = blinkCount + 1
		self:CDBar(242015, 26, blinkSpells[blinkCount] and ("%s (%s)"):format(spellName, self:SpellName(blinkSpells[blinkCount])) or spellName)
		-- XXX second second razor ice is actually shadow barrage and it's a mystery what happens after that
	end
end

function mod:ArcaneAnnihilation(args)
	self:Message(args.spellId, "Neutral")
	self:Bar(args.spellId, 40, CL.cast:format(args.spellName))

	annihilationCount = annihilationCount + 1
	drawPowerCount = 0
end

function mod:UNIT_SPELLCAST_STOP(unit, spellName, _, _, spellId)
	if spellId == 234728 then -- Arcane Annihilation
		self:StopBar(CL.cast:format(spellName))

		self:Message(spellId, "Neutral", nil, CL.over:format(spellName))
		blinkCount = blinkCount + 1
		if blinkCount > #blinkSpells then
			blinkCount = 1
		end
		local blinkText = blinkSpells[blinkCount] and ("%s (%s)"):format(self:SpellName(242015), self:SpellName(blinkSpells[blinkCount])) or self:SpellName(242015)
		if annihilationCount % 2 == 0 then
			self:CDBar(231443, 3) -- Shadow Barrage
			self:CDBar(242015, 16, blinkText) -- Blink
		else
			self:CDBar(231443, 4.5) -- Shadow Barrage
			self:CDBar(231522, 16) -- Draw Power 16-18
			self:CDBar(242015, 23, blinkText) -- Blink
		end
	end
end

function mod:ShadowBarrage(args)
	self:StopBar(args.spellName)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end

function mod:DrawPower(args)
	self:Message(args.spellId, "Important", "Alert")
	drawPowerCount = drawPowerCount + 1
	if drawPowerCount < 2 then
		self:CDBar(args.spellId, 20)
	end
end

---------------------------------------
-- Corrupting Shadows

function mod:CreepingShadowsDamage(args)
	self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
end

function mod:SeedOfDarkness(args)
	self:Message(args.spellId, "Important", "Long")
	self:TargetBar(args.spellId, 8, args.destName)
	self:Bar(args.spellId, 65.6)
end
