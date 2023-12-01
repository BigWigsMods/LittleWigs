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

	L.warmup_trigger1 = "With the Focusing Iris under my control" -- You are too late, demon hunter! With the Focusing Iris under my control, I can siphon the arcane energy from Azeroth's ley lines directly into my magnificent self!
	L.warmup_trigger2 = "Drained of magic, your world will be ripe" -- Drained of magic, your world will be ripe for destruction by my demon masters... and my power will be limitless!
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

--------------------------------------------------------------------------------
-- Event Handlers
--

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
			self:MessageOld("stages", "cyan", nil, CL.soon:format(CL.phase:format(2)), false)
			self:Bar("warmup", 29, CL.phase:format(2), "spell_arcane_prismaticcloak")
		elseif phase == 2 and UnitExists("boss1") then
			-- Phase 2 OnEngage
			phase = 3
			self:MessageOld("stages", "cyan", nil, CL.phase:format(2), false)
			self:Bar(233248, 21) -- Seed of Darkness

			self:RegisterEvent(event, "CheckBossStatus") -- Shenanigans over
		end
	end
end

---------------------------------------
-- Archmage Xylem

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger1, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 27.6, CL.active, "spell_mage_focusingcrystal")
	elseif msg:find(L.warmup_trigger2, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 13.3, CL.active, "spell_mage_focusingcrystal")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 242015 then -- Blink
		local spellName = self:SpellName(spellId)
		self:StopBar(blinkSpells[blinkCount] and ("%s (%s)"):format(spellName, self:SpellName(blinkSpells[blinkCount])) or spellName)
		self:MessageOld(242015, "yellow", nil, blinkSpells[blinkCount] and ("%s (%s)"):format(spellName, self:SpellName(blinkSpells[blinkCount])) or spellName)
		blinkCount = blinkCount + 1
		self:CDBar(242015, 26, blinkSpells[blinkCount] and ("%s (%s)"):format(spellName, self:SpellName(blinkSpells[blinkCount])) or spellName)
		-- XXX second second razor ice is actually shadow barrage and it's a mystery what happens after that
	end
end

function mod:ArcaneAnnihilation(args)
	self:MessageOld(args.spellId, "cyan")
	self:Bar(args.spellId, 40, CL.cast:format(args.spellName))

	annihilationCount = annihilationCount + 1
	drawPowerCount = 0
end

function mod:UNIT_SPELLCAST_STOP(_, _, _, spellId)
	if spellId == 234728 then -- Arcane Annihilation
		self:StopBar(CL.cast:format(self:SpellName(spellId)))

		self:MessageOld(spellId, "cyan", nil, CL.over:format(self:SpellName(spellId)))
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
	self:MessageOld(args.spellId, "orange", "alarm")
	self:Bar(args.spellId, 8, CL.cast:format(args.spellName))
end

function mod:DrawPower(args)
	self:MessageOld(args.spellId, "red", "alert")
	drawPowerCount = drawPowerCount + 1
	if drawPowerCount < 2 then
		self:CDBar(args.spellId, 20)
	end
end

---------------------------------------
-- Corrupting Shadows

function mod:CreepingShadowsDamage(args)
	self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
end

function mod:SeedOfDarkness(args)
	self:MessageOld(args.spellId, "red", "long")
	self:TargetBar(args.spellId, 8, args.destName)
	self:Bar(args.spellId, 65.6)
end
