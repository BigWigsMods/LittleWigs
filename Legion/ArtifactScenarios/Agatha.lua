
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Agatha", 1616) -- An Impossible Foe
if not mod then return end
mod:RegisterEnableMob(115638) -- Agatha
mod.otherMenu = 1716 -- Broken Shore Mage Tower

--------------------------------------------------------------------------------
-- Locals
--

local imps = {}
local phase = 1
local partyCount = 1
local marker = 1
local hasFury = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Agatha"
	L.levia = "Levia" -- Shortcut for warmup_trigger1 so most locales should still work if you enable quick enough

	L.warmup_trigger1 = "You are too late! Levia's power is mine! Using her knowledge, my minions will infiltrate the Kirin Tor and dismantle it from the inside!" -- 35
	L.warmup_trigger2 = "Even now, my sayaad tempt your weak-willed mages. Your allies will surrender willingly to the Legion!" -- 16
	L.warmup_trigger3 = "But first, you must be punished for taking away my little pet." -- 3

	-- L.servant_trigger = "Kill the Imp Servants before they energize Agatha!"
	-- L.umbral_trigger = "Protect me, my children! I will give you the power!"

	L.imp_servant = "Imp Servant"
	L.imp_servant_desc = 229928 -- Funnel Energy
	L.fuming_imp = "Fuming Imp"
	L.fuming_imp_desc = 236163 -- Plague Zone

	L.absorb = "Absorb"
	L.stacks = "Stacks"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Imps ]]--
		"imp_servant",
		{"fuming_imp", "ICON"},
		236161, -- Plague Zone
		243027, -- Shadow Shield

		--[[ Agatha ]]--
		"warmup",
		{243111, "INFOBOX"}, -- Dark Fury
		242989, -- Translocate
	}, {
		imp_servant = CL.adds,
		warmup = L.name,
	}
end

function mod:OnRegister()
	self.displayName = L.name
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "ImpServant")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_PERIODIC_DAMAGE", "PlagueZoneDamage", 236161)
	self:Log("SPELL_AURA_APPLIED", "ShadowShield", 243027)
	self:Log("SPELL_AURA_REMOVED", "ShadowShieldRemoved", 243027)

	self:Log("SPELL_CAST_SUCCESS", "DarkFury", 243114)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DarkFuryDose", 243111)
	self:Log("SPELL_AURA_REMOVED", "DarkFuryRemoved", 243111)
	self:Log("SPELL_AURA_REMOVED", "DarkFuryShieldRemoved", 243113)

	self:Log("SPELL_CAST_START", "Translocate", 242989)

	self:Death("Win", 115638) -- Agatha
end

function mod:OnEngage()
	imps = {}
	phase = 1
	partyCount = 1
	marker = 1
	hasFury = nil

	self:Bar("imp_servant", 16, L.imp_servant, "spell_warlock_demonsoul")
	self:Bar("fuming_imp", 19, L.fuming_imp, "spell_deathknight_necroticplague")
	self:ScheduleTimer("FumingImp", 19)
	self:Bar(243111, 51) -- Dark Fury
	self:Bar(243027, 62, CL.count:format(self:SpellName(243027), partyCount)) -- Shadow Shield

	self:RegisterTargetEvents("AddScanner")
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AddScanner(event, unit, guid)
	if not guid or imps[guid] then return end
	imps[guid] = true

	if self:MobId(guid) == 115640 and self:CheckOption("fuming_imp", "ICON") then
		self:CustomIcon(unit, marker)
		marker = marker + 1
		if marker > 8 then
			marker = 1
		end
	end
end

function mod:ImpServant(_, msg)
	self:MessageOld("imp_servant", "yellow", "info", L.imp_servant, false)
	self:Bar("imp_servant", 46, L.imp_servant, "spell_warlock_demonsoul")
end

function mod:FumingImp()
	self:MessageOld("fuming_imp", "orange", "warning", L.fuming_imp, false)
	self:CDBar("fuming_imp", 35.2, L.fuming_imp, "spell_deathknight_necroticplague")
	self:ScheduleTimer("FumingImp", 35.2)
end

do
	local prev = 0
	function mod:PlagueZoneDamage(args)
		local t = GetTime()
		if t-prev > 0.9 then -- Ticks every second, but don't spam for stacked zones
			prev = t
			self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
		end
	end
end

do
	-- 0: Smoldering x3
	-- 1: Umbral x3
	-- 2: Umbral, Fuming, Smoldering
	-- 3: Umbral x2, Fuming, Smoldering
	-- 4+: Umbral x2, Fuming, Smoldering x2
	local prev, count = 0, 0
	function mod:ShadowShield(args)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			count = 0
			self:MessageOld(args.spellId, "orange", "alert", CL.count:format(args.spellName, partyCount))
			partyCount = partyCount + 1
			self:CDBar(args.spellId, 61, CL.count:format(args.spellName, partyCount))
		end
		count = count + 1
	end

	function mod:ShadowShieldRemoved(args)
		count = count - 1
		if count < 1 then -- Of course the immunity buff doesn't show on the boss.
			self:MessageOld(args.spellId, "green", nil, CL.removed:format(args.spellName))
			if hasFury then -- Play sound if Dark Fury is on the boss
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

---------------------------------------
-- Agatha

function mod:Warmup(event, msg)
	self:UnregisterEvent(event)
	if msg:find(L.warmup_trigger1, nil, true) or msg:find(L.levia, nil, true) then
		self:Bar("warmup", 35, CL.active, "sha_spell_shaman_lavaburst_nightborne")
	elseif msg:find(L.warmup_trigger2, nil, true) then
		self:Bar("warmup", 16.8, CL.active, "sha_spell_shaman_lavaburst_nightborne")
	elseif msg:find(L.warmup_trigger3, nil, true) then
		self:Bar("warmup", 3.4, CL.active, "sha_spell_shaman_lavaburst_nightborne")
	end
end

do
	local timer = nil
	local maxAbsorb = 4000000
	local function updateInfoBox(self)
		local remaining = UnitGetTotalAbsorbs("boss1")
		local percent = remaining / maxAbsorb
		self:SetInfoBar(243111, 1, percent)

		local text = ("%s (%d%%)"):format(self:AbbreviateNumber(remaining), math.ceil(percent * 100))
		if remaining == 0 then
			text = ("|cff02ff02%s"):format(text)
		end
		self:SetInfo(243111, 2, text)
	end

	function mod:DarkFury(args)
		self:MessageOld(243111, "red", "long")
		self:Bar(243111, phase == 1 and 51 or 68) -- Energy generation slows in phase 2 (2/s->3/2s)
		hasFury = true

		if self:CheckOption(243111, "INFOBOX") then
			maxAbsorb = UnitGetTotalAbsorbs("boss1")
			self:OpenInfo(243111, args.spellName)
			self:SetInfoBar(243111, 1, 1)
			self:SetInfo(243111, 1, L.absorb)
			self:SetInfo(243111, 2, ("%s (%d%%)"):format(self:AbbreviateNumber(maxAbsorb), 100))
			self:SetInfo(243111, 3, L.stacks)
			self:SetInfo(243111, 4, 1)
			timer = self:ScheduleRepeatingTimer(updateInfoBox, 0.1, self)
		end
	end

	function mod:DarkFuryDose(args)
		self:SetInfo(243111, 4, args.amount)
	end

	function mod:DarkFuryShieldRemoved(args)
		self:MessageOld(243111, "green", "long", CL.removed:format(args.spellName))
		if not self:UnitBuff("boss1", 243111) then -- Dark Fury damage buff
			-- Translocate during Dark Fury does weird things
			self:DarkFuryRemoved()
		end
	end

	function mod:DarkFuryRemoved(args)
		hasFury = nil
		self:CloseInfo(243111)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
	end
end

function mod:Translocate(args)
	self:MessageOld(args.spellId, "cyan")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 242987 then -- Translocate
		if phase == 1 then
			phase = 2
			self:MessageOld(242989, "cyan", nil, CL.percent:format(50, self:SpellName(spellId)), false)

			-- Recalc Dark Fury time
			local remaining = (100 - UnitPower(unit)) * 0.68
			self:CDBar(243111, remaining)
		else
			self:MessageOld(242989, "cyan")
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < 55 then
		self:MessageOld(242989, "cyan", nil, CL.soon:format(self:SpellName(242987)), false)
		-- Seems like it's based on damage done after the initial 50% cast, cba to track that
		self:UnregisterUnitEvent(event, unit)
	end
end
