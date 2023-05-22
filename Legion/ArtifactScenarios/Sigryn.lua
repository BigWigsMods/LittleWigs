
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sigryn", 1703) -- The God-Queen's Fury
if not mod then return end
mod:RegisterEnableMob(116484, 116496, 116499) -- Sigryn, Runeseer Faljar, Jarl Velbrand
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--

local bloodCount = 1
local runeCount, shieldCount = 1, 1
local bladestormCount = 1

local runeTimers = {42, 14, 82, 43, 11, 45, 11, 11}
local shieldTimers = {96, 70, 120, 65}
local bloodTimer = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sigryn = "Sigryn"
	L.jarl = "Jarl Velbrand"
	L.faljar = "Runeseer Faljar"

	L.warmup_trigger = "What's this? The outsider has come to stop me?"

	L.absorb = "Absorb"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- "infobox", -- CC DR?
		--[[ Sigryn ]]--
		{237945, "EMPHASIZE", "COUNTDOWN", "CASTBAR"}, -- (Empowered) Blood of the Father
		237730, -- Dark Wings
		238694, -- Throw Spear
		238691, -- Spear of Vengeance (Damage)
		--[[ Runeseer Faljar ]]--
		{237949, "INFOBOX"}, -- (Empowered) Ancestral Knowledge
		237914, -- Runic Detonation
		--[[ Jarl Velbrand ]]--
		237947, -- (Empowered) Berserker's Rage
		237857, -- Bladestorm
	}, {
		[237945] = L.sigryn,
		[237949] = L.faljar,
		[237947] = L.jarl,
	}
end

function mod:OnRegister()
	self.displayName = L.sigryn
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	self:Log("SPELL_CAST_START", "BloodOfTheFatherCast", 237945)
	self:Log("SPELL_AURA_APPLIED", "BloodOfTheFatherApplied", 237945)
	self:Log("SPELL_SUMMON", "DarkWings", 237730)
	self:Log("SPELL_CAST_START", "ThrowSpear", 238694)
	self:Log("SPELL_PERIODIC_DAMAGE", "SpearDamage", 238691)
	self:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "AncestralKnowledge", 237949)
	self:Log("SPELL_AURA_REMOVED", "AncestralKnowledgeRemoved", 237949)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss2")

	self:Log("SPELL_AURA_APPLIED", "BerserkersRage", 237947)
	self:Log("SPELL_AURA_REMOVED", "BerserkersRageRemoved", 237947)
	self:Log("SPELL_CAST_START", "BladestormCast", 237857)

	self:Death("Win", 116484) -- Sigryn
end

function mod:OnEngage()
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	bloodCount = 1
	bladestormCount = 1
	runeCount, shieldCount = 1, 1

	self:Bar(237947, 27) -- Berserker's Rage
	self:Bar(237914, 42) -- Runic Detonation
	self:Bar(237945, 61) -- Blood of the Father
	bloodTimer = self:ScheduleTimer("CheckBloodCast", 63)
	self:Bar(237949, 96) -- Ancestral Knowledge
	self:Bar(237730, 110) -- Dark Wings
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 17, CL.active, "inv_helmet_158")
	end
end

---------------------------------------
-- Sigryn

function mod:BloodOfTheFatherCast(args)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
	bloodCount = bloodCount + 1
	if bloodCount < 4 then
		local cd = bloodCount == 2 and 70 or 100 -- 60 70 100
		self:Bar(args.spellId, cd)
		self:CancelTimer(bloodTimer)
		bloodTimer = self:ScheduleTimer("CheckBloodCast", cd + 2)
	end
end

-- Fallback for if Sigryn was CC'd for the cast
function mod:CheckBloodCast()
	self:MessageOld(237945, "green", "info", CL.interrupted:format(self:SpellName(237945)))
	bloodCount = bloodCount + 1
	if bloodCount < 4 then
		local cd = bloodCount == 2 and 70 or 100
		self:Bar(237945, cd - 2)
		bloodTimer = self:ScheduleTimer("CheckBloodCast", cd)
	end
end

function mod:BloodOfTheFatherApplied(args)
	-- RIP
	self:MessageOld(args.spellId, "red", "long")
	self:TargetBar(args.spellId, 27, args.destName)
end

function mod:UNIT_SPELLCAST_INTERRUPTED(_, _, _, spellId)
	if spellId == 237945 then -- Blood of the Father
		self:StopBar(CL.cast:format(self:SpellName(spellId)))
		self:MessageOld(spellId, "green", "info", CL.interrupted:format(self:SpellName(spellId)))
	end
end

do
	local prev = 0
	function mod:DarkWings(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:StopBar(args.spellName)
			self:MessageOld(args.spellId, "orange", "alarm", CL.soon:format(args.spellName))
			self:Bar(args.spellId, 5, 100, args.spellId) -- 100 = Charge
			self:ScheduleTimer("CDBar", 5, args.spellId, 15) -- mostly ~20
		end
	end
end

function mod:ThrowSpear(args)
	self:MessageOld(args.spellId, "yellow", "info")
end

do
	local prev = 0
	function mod:SpearDamage(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
		end
	end
end

---------------------------------------
-- Runeseer Faljar

do
	local maxAbsorb = 5000000
	local function updateInfoBox()
		local remaining = UnitGetTotalAbsorbs("boss2")
		local percent = remaining / maxAbsorb
		mod:SetInfoBar(237949, 1, percent)

		local text = ("%s (%d%%)"):format(mod:AbbreviateNumber(remaining), math.ceil(percent * 100))
		if remaining == 0 then
			text = ("|cff02ff02%s"):format(text)
		end
		mod:SetInfo(237949, 2, text)
		mod:SimpleTimer(updateInfoBox, 0.1)
	end

	function mod:AncestralKnowledge(args)
		self:MessageOld(args.spellId, "orange", "alert")
		shieldCount = shieldCount + 1
		if shieldCount > 3 then
			self:CDBar(args.spellId, shieldTimers[shieldCount] or 25)
		else
			self:Bar(args.spellId, shieldTimers[shieldCount])
		end

		if self:CheckOption(args.spellId, "INFOBOX") then
			maxAbsorb = UnitGetTotalAbsorbs("boss2")
			self:OpenInfo(args.spellId, args.spellName)
			self:SetInfoBar(args.spellId, 1, 1)
			self:SetInfo(args.spellId, 1, L.absorb)
			self:SetInfo(args.spellId, 2, ("%s (%d%%)"):format(self:AbbreviateNumber(maxAbsorb), 100))
			self:SimpleTimer(updateInfoBox, 0.1)
		end
	end

	function mod:AncestralKnowledgeRemoved(args)
		self:CloseInfo(args.spellId)
		self:MessageOld(args.spellId, "green", "info", CL.removed:format(args.spellName))
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 237914 then -- Runic Detonation
		self:MessageOld(spellId, "red", "warning")
		runeCount = runeCount + 1
		local cd = runeTimers[runeCount]
		if cd then
			self:CDBar(spellId, cd)
		end
	end
end

---------------------------------------
-- Jarl Velbrand

function mod:BerserkersRage(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:BerserkersRageRemoved(args)
	self:MessageOld(args.spellId, "green", "info", CL.over:format(args.spellName))
end

function mod:BladestormCast(args)
	self:MessageOld(args.spellId, "yellow", "alarm", CL.casting:format(args.spellName))
	bladestormCount = bladestormCount + 1
	if bladestormCount == 2 then
		self:Bar(args.spellId, 105)
		self:Bar(237947, 78) -- Berserk's Rage
	elseif bladestormCount == 3 then
		self:Bar(args.spellId, 30)
	end
end
