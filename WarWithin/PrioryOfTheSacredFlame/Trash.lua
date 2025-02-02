local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Priory of the Sacred Flame Trash", 2649)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	212826, -- Guard Captain Suleyman
	212831, -- Forge Master Damian
	212827, -- High Priest Aemya
	211291, -- Sergeant Shaynemail (with boss)
	239836, -- Sergenat Shaynemail (as trash)
	211290, -- Elaena Emberlanz (with boss)
	239833, -- Elaena Emberlanz (as trash)
	211289, -- Taener Duelmal (with boss)
	239834, -- Taener Duelmal (as trash)
	206696, -- Arathi Knight
	206705, -- Arathi Footman
	206694, -- Fervent Sharpshooter
	206697, -- Devout Priest
	206698, -- Fanatical Conjuror
	206710, -- Lightspawn
	206704, -- Ardent Paladin
	221760, -- Risen Mage
	217658 -- Sir Braunpyke
)

--------------------------------------------------------------------------------
-- Locals
--

local nextBrutalSmash = 0
local nextHolyRadiance = 0
local nextEmberStorm = 0
local shaynemailGUID = nil
local elaenaGUID = nil
local taenerGUID = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sacred_flame = "Sacred Flame"
	L.guard_captain_suleyman = "Guard Captain Suleyman"
	L.forge_master_damian = "Forge Master Damian"
	L.high_priest_aemya = "High Priest Aemya"
	L.sergeant_shaynemail = "Sergeant Shaynemail"
	L.elaena_emberlanz = "Elaena Emberlanz"
	L.taener_duelmal = "Taener Duelmal"
	L.arathi_knight = "Arathi Knight"
	L.arathi_footman = "Arathi Footman"
	L.fervent_sharpshooter = "Fervent Sharpshooter"
	L.devout_priest = "Devout Priest"
	L.fanatical_conjuror = "Fanatical Conjuror"
	L.lightspawn = "Lightspawn"
	L.ardent_paladin = "Ardent Paladin"
	L.risen_mage = "Risen Mage"
	L.sir_braunpyke = "Sir Braunpyke"

	L.baron_braunpyke_warmup_trigger = "They've served their purpose. Baron, demonstrate your worth."
	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "|cFFFF0000Requires Priest or Paladin.|r Automatically select the NPC dialog option that grants you the 'Blessing of the Sacred Flame' aura."
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sacred Flame
		"custom_on_autotalk",
		435088, -- Blessing of the Sacred Flame
		-- Guard Captain Suleyman
		{448485, "TANK_HEALER", "NAMEPLATE"}, -- Shield Slam
		{448492, "NAMEPLATE"}, -- Thunderclap
		-- Forge Master Damian
		{427897, "NAMEPLATE"}, -- Heat Wave
		{427950, "NAMEPLATE"}, -- Seal of Flame
		427900, -- Molten Pool
		-- High Priest Aemya
		{428150, "NAMEPLATE"}, -- Reflective Shield
		-- Sergeant Shaynemail
		{424621, "NAMEPLATE"}, -- Brutal Smash
		{424423, "NAMEPLATE"}, -- Lunging Strike
		-- Elaena Emberlanz
		{424431, "HEALER", "NAMEPLATE"}, -- Holy Radiance
		{448515, "TANK", "NAMEPLATE"}, -- Divine Judgment
		{427583, "NAMEPLATE"}, -- Repentance XXX removed in 11.1?
		-- Taener Duelmal
		{424420, "DISPEL", "NAMEPLATE"}, -- Cinderblast
		{424462, "NAMEPLATE"}, -- Ember Storm
		-- Arathi Knight
		{427609, "NAMEPLATE"}, -- Disrupting Shout
		-- Arathi Footman
		{427342, "NAMEPLATE"}, -- Defend
		{426964, "TANK", "NAMEPLATE"}, -- Mortal Strike
		-- Fervent Sharpshooter
		{453458, "DISPEL", "NAMEPLATE"}, -- Caltrops
		-- Devout Priest
		{427356, "NAMEPLATE"}, -- Greater Heal
		{427346, "DISPEL", "NAMEPLATE"}, -- Inner Fire
		-- Fanatical Conjuror
		{427484, "NAMEPLATE"}, -- Flamestrike
		-- Lightspawn
		{448787, "NAMEPLATE"}, -- Purification
		427601, -- Burst of Light
		-- Ardent Paladin
		{424429, "NAMEPLATE"}, -- Consecration
		-- Risen Mage
		{444743, "NAMEPLATE"}, -- Fireball Volley
		-- Sir Braunpyke
		{435165, "TANK", "NAMEPLATE"}, -- Blazing Strike
	}, {
		["custom_on_autotalk"] = L.sacred_flame,
		[448485] = L.guard_captain_suleyman,
		[427897] = L.forge_master_damian,
		[428150] = L.high_priest_aemya,
		[424621] = L.sergeant_shaynemail,
		[424431] = L.elaena_emberlanz,
		[424420] = L.taener_duelmal,
		[427609] = L.arathi_knight,
		[427342] = L.arathi_footman,
		[453458] = L.fervent_sharpshooter,
		[427356] = L.devout_priest,
		[427484] = L.fanatical_conjuror,
		[448787] = L.lightspawn,
		[424429] = L.ardent_paladin,
		[444743] = L.risen_mage,
		[435165] = L.sir_braunpyke,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Sacred Flame
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "BlessingOfTheSacredFlame", 435088)

	-- Guard Captain Suleyman
	self:RegisterEngageMob("GuardCaptainSuleymanEngaged", 212826)
	self:Log("SPELL_CAST_START", "ShieldSlam", 448485)
	self:Log("SPELL_CAST_START", "Thunderclap", 448492)
	self:Death("GuardCaptainSuleymanDeath", 212826)

	-- Forge Master Damian
	self:RegisterEngageMob("ForgeMasterDamianEngaged", 212831)
	self:Log("SPELL_CAST_START", "HeatWave", 427897)
	self:Log("SPELL_CAST_START", "SealOfFlame", 427950)
	self:Log("SPELL_PERIODIC_DAMAGE", "MoltenPoolDamage", 427900)
	self:Log("SPELL_PERIODIC_MISSED", "MoltenPoolDamage", 427900)
	self:Death("ForgeMasterDamianDeath", 212831)

	-- High Priest Aemya
	self:RegisterEngageMob("HighPriestAemyaEngaged", 212827)
	self:Log("SPELL_CAST_START", "ReflectiveShield", 428150)
	self:Log("SPELL_CAST_SUCCESS", "ReflectiveShieldSuccess", 428150)
	self:Log("SPELL_AURA_REMOVED", "ReflectiveShieldRemoved", 428150)
	self:Death("HighPriestAemyaDeath", 212827)

	-- Sergeant Shaynemail
	self:RegisterEngageMob("SergeantShaynemailEngaged", 211291, 239836)
	self:Log("SPELL_CAST_START", "BrutalSmash", 424621)
	self:Log("SPELL_CAST_SUCCESS", "BrutalSmashSuccess", 424621)
	self:Log("SPELL_CAST_START", "LungingStrike", 424423)
	self:Log("SPELL_CAST_SUCCESS", "LungingStrikeSuccess", 424423)
	self:Death("SergeantShaynemailDeath", 211291, 239836)

	-- Elaena Emberlanz
	self:RegisterEngageMob("ElaenaEmberlanzEngaged", 211290, 239833)
	self:Log("SPELL_CAST_START", "HolyRadiance", 424431)
	self:Log("SPELL_CAST_SUCCESS", "HolyRadianceSuccess", 424431)
	self:Log("SPELL_CAST_START", "DivineJudgment", 448515)
	self:Log("SPELL_CAST_START", "Repentance", 427583) -- XXX removed in 11.1
	self:Death("ElaenaEmberlanzDeath", 211290, 239833)

	-- Taener Duelmal
	self:RegisterEngageMob("TaenerDuelmalEngaged", 211289, 239834)
	self:Log("SPELL_CAST_START", "Cinderblast", 424420)
	self:Log("SPELL_INTERRUPT", "CinderblastInterrupt", 424420)
	self:Log("SPELL_CAST_SUCCESS", "CinderblastSuccess", 424420)
	self:Log("SPELL_AURA_APPLIED", "CinderblastApplied", 424420)
	self:Log("SPELL_CAST_START", "EmberStorm", 424462)
	self:Log("SPELL_CAST_SUCCESS", "EmberStormSuccess", 424462)
	self:Death("TaenerDuelmalDeath", 211289, 239834)

	-- Captain Dailcry
	self:Log("SPELL_AURA_APPLIED", "BattleCryApplied", 424419)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BattleCryApplied", 424419)

	-- Arathi Knight
	self:RegisterEngageMob("ArathiKnightEngaged", 206696)
	self:Log("SPELL_CAST_START", "DisruptingShout", 427609)
	self:Death("ArathiKnightDeath", 206696)

	-- Arathi Footman
	self:RegisterEngageMob("ArathiFootmanEngaged", 206705)
	self:Log("SPELL_CAST_SUCCESS", "Defend", 427342)
	self:Log("SPELL_CAST_START", "MortalStrike", 426964)
	self:Log("SPELL_CAST_SUCCESS", "MortalStrikeSuccess", 426964)
	self:Death("ArathiFootmanDeath", 206705)

	-- Fervent Sharpshooter
	self:RegisterEngageMob("FerventSharpshooterEngaged", 206694)
	self:Log("SPELL_CAST_SUCCESS", "Caltrops", 453458)
	self:Log("SPELL_AURA_APPLIED", "CaltropsApplied", 453461)
	self:Death("FerventSharpshooterDeath", 206694)

	-- Devout Priest
	self:RegisterEngageMob("DevoutPriestEngaged", 206697)
	self:Log("SPELL_CAST_START", "GreaterHeal", 427356)
	self:Log("SPELL_INTERRUPT", "GreaterHealInterrupt", 427356)
	self:Log("SPELL_CAST_SUCCESS", "GreaterHealSuccess", 427356)
	self:Log("SPELL_CAST_START", "InnerFire", 427346)
	self:Log("SPELL_INTERRUPT", "InnerFireInterrupt", 427346)
	self:Log("SPELL_CAST_SUCCESS", "InnerFireSuccess", 427346)
	self:Log("SPELL_AURA_APPLIED", "InnerFireApplied", 427346)
	self:Death("DevoutPriestDeath", 206697)

	-- Fanatical Conjuror
	self:RegisterEngageMob("FanaticalConjurorEngaged", 206698)
	self:Log("SPELL_CAST_START", "Flamestrike", 427484)
	self:Log("SPELL_PERIODIC_DAMAGE", "FlamestrikeDamage", 427473) -- no alert on APPLIED, doesn't damage for 1.5s
	self:Log("SPELL_PERIODIC_MISSED", "FlamestrikeDamage", 427473)
	self:Death("FanaticalConjurorDeath", 206698)

	-- Lightspawn
	self:RegisterEngageMob("LightspawnEngaged", 206710)
	self:Log("SPELL_CAST_START", "BurstOfLight", 427601)
	self:Log("SPELL_CAST_SUCCESS", "Purification", 448787)
	self:Log("SPELL_AURA_APPLIED", "PurificationApplied", 448787)
	self:Death("LightspawnDeath", 206710)

	-- Ardent Paladin
	self:RegisterEngageMob("ArdentPaladinEngaged", 206704)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "Consecration", 424429)
	else -- XXX remove in 11.1
		self:Log("SPELL_CAST_SUCCESS", "Consecration", 424429)
	end
	self:Log("SPELL_PERIODIC_DAMAGE", "ConsecrationDamage", 424430) -- no alert on APPLIED, doesn't damage for 1.5s
	self:Log("SPELL_PERIODIC_MISSED", "ConsecrationDamage", 424430)
	self:Death("ArdentPaladinDeath", 206704)

	-- Risen Mage
	self:RegisterEngageMob("RisenMageEngaged", 221760)
	self:Log("SPELL_CAST_START", "FireballVolley", 444743)
	self:Log("SPELL_INTERRUPT", "FireballVolleyInterrupt", 444743)
	self:Log("SPELL_CAST_SUCCESS", "FireballVolleySuccess", 444743)
	self:Death("RisenMageDeath", 221760)

	-- Sir Braunpyke
	self:RegisterEngageMob("SirBraunpykeEngaged", 217658)
	self:Log("SPELL_CAST_START", "BlazingStrike", 435165)
	self:Death("SirBraunpykeDeath", 217658)
end

function mod:OnBossDisable()
	nextBrutalSmash = 0
	nextHolyRadiance = 0
	nextEmberStorm = 0
	shaynemailGUID = nil
	elaenaGUID = nil
	taenerGUID = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.baron_braunpyke_warmup_trigger then
		-- Baron Braunpyke warmup
		local baronBraunpykeModule = BigWigs:GetBossModule("Baron Braunpyke", true)
		if baronBraunpykeModule then
			baronBraunpykeModule:Enable()
			baronBraunpykeModule:Warmup()
		end
	end
end

-- Sacred Flame

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		-- Priests and Paladins can talk to the Sacred Flame to buff the whole party with
		-- Blessing of the Sacred Flame, which causes your attacks to deal bonus damage.
		if self:GetGossipID(120715) then -- Priest
			-- 120715:Harness the power of the Sacred Flame.
			self:SelectGossipID(120715)
		elseif self:GetGossipID(120716) then -- Paladin
			-- 120716:Harness the power of the Sacred Flame.
			self:SelectGossipID(120716)
		end
	end
end

function mod:BlessingOfTheSacredFlame(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Guard Captain Suleyman

do
	local timer

	function mod:GuardCaptainSuleymanEngaged(guid)
		self:CDBar(448485, 2.3) -- Shield Slam
		self:Nameplate(448485, 2.3, guid) -- Shield Slam
		self:CDBar(448492, 15.3) -- Thunderclap
		self:Nameplate(448492, 15.3, guid) -- Thunderclap
		timer = self:ScheduleTimer("GuardCaptainSuleymanDeath", 30)
	end

	function mod:ShieldSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 10.9)
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
		if self:Tank() then
			self:PlaySound(args.spellId, "alarm")
		else
			self:PlaySound(args.spellId, "info")
		end
		timer = self:ScheduleTimer("GuardCaptainSuleymanDeath", 30)
	end

	function mod:Thunderclap(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 15.8)
		self:Nameplate(args.spellId, 15.8, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("GuardCaptainSuleymanDeath", 30)
	end

	function mod:GuardCaptainSuleymanDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(448485) -- Shield Slam
		self:StopBar(448492) -- Thunderclap
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Forge Master Damian

do
	local timer

	function mod:ForgeMasterDamianEngaged(guid)
		self:CDBar(427950, 5.6) -- Seal of Flame
		self:Nameplate(427950, 5.6, guid) -- Seal of Flame
		self:CDBar(427897, 8.4) -- Heat Wave
		self:Nameplate(427897, 8.4, guid) -- Heat Wave
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	function mod:HeatWave(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 17.0)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	function mod:SealOfFlame(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 17.0)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	do
		local prev = 0
		function mod:MoltenPoolDamage(args)
			if self:Me(args.destGUID) and args.time - prev > 2 then
				prev = args.time
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end

	function mod:ForgeMasterDamianDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(427897) -- Heat Wave
		self:StopBar(427950) -- Seal of Flame
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- High Priest Aemya

do
	local timer

	function mod:HighPriestAemyaEngaged(guid)
		self:CDBar(428150, 21.4) -- Reflective Shield
		self:Nameplate(428150, 21.4, guid) -- Reflective Shield
		timer = self:ScheduleTimer("HighPriestAemyaDeath", 60)
	end

	function mod:ReflectiveShield(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("HighPriestAemyaDeath", 60)
	end

	function mod:ReflectiveShieldSuccess(args)
		self:StopBar(args.spellId)
		self:StopNameplate(args.spellId, args.sourceGUID)
	end

	function mod:ReflectiveShieldRemoved(args)
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		-- cast at 100 mana, mana generation is paused while Reflective Shield buff is active
		self:CDBar(args.spellId, 20.1)
		self:Nameplate(args.spellId, 20.1, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:HighPriestAemyaDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(428150) -- Reflective Shield
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Sergeant Shaynemail

do
	local timer

	function mod:SergeantShaynemailEngaged(guid)
		if isElevenDotOne then
			if self:MobId(guid) == 211291 then -- Sergeant Shaynemail, boss version
				shaynemailGUID = guid
			end
		end
		self:CDBar(424423, 5.2) -- Lunging Strike
		self:Nameplate(424423, 5.2, guid) -- Lunging Strike
		nextBrutalSmash = GetTime() + 25.2
		self:CDBar(424621, 25.2) -- Brutal Smash
		self:Nameplate(424621, 25.2, guid) -- Brutal Smash
		timer = self:ScheduleTimer("SergeantShaynemailDeath", 30)
	end

	function mod:BrutalSmash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		-- 4.5s cast, ~24.6s energy gain
		self:CDBar(args.spellId, 29.1)
		self:Nameplate(args.spellId, 29.1, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("SergeantShaynemailDeath", 30)
	end

	function mod:BrutalSmashSuccess(args)
		nextBrutalSmash = GetTime() + 24.6
	end

	function mod:LungingStrike(args)
		if timer then
			self:CancelTimer(timer)
		end
		-- doesn't switch targets until the end of the cast, so can't target scan
		self:Message(args.spellId, "red")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("SergeantShaynemailDeath", 30)
	end

	function mod:LungingStrikeSuccess(args)
		if isElevenDotOne then
			self:CDBar(args.spellId, 12.1)
			self:Nameplate(args.spellId, 12.1, args.sourceGUID)
		else
			self:CDBar(args.spellId, 13.1)
			self:Nameplate(args.spellId, 13.1, args.sourceGUID)
		end
	end

	function mod:SergeantShaynemailDeath(args)
		shaynemailGUID = nil
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(424621) -- Brutal Smash
		self:StopBar(424423) -- Lunging Strike
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Elaena Emberlanz

do
	local timer

	function mod:ElaenaEmberlanzEngaged(guid)
		if isElevenDotOne then
			if self:MobId(guid) == 211290 then -- Elaena Emberlanz, boss version
				elaenaGUID = guid
			end
			self:CDBar(448515, 8.0) -- Divine Judgment
			self:Nameplate(448515, 8.0, guid) -- Divine Judgment
			local unit = self:UnitTokenFromGUID(guid)
			if unit then
				-- Elaena's energy doesn't always reset after a wipe
				local timeUntilHolyRadiance = 25.2 * (1 - UnitPower(unit) / UnitPowerMax(unit))
				nextHolyRadiance = GetTime() + timeUntilHolyRadiance
				self:CDBar(424431, timeUntilHolyRadiance) -- Holy Radiance
				self:Nameplate(424431, timeUntilHolyRadiance, guid) -- Holy Radiance
			else
				nextHolyRadiance = GetTime() + 25.2
				self:CDBar(424431, 25.2) -- Holy Radiance
				self:Nameplate(424431, 25.2, guid) -- Holy Radiance
			end
		else -- XXX remove this block in 11.1
			self:CDBar(424431, 1.1) -- Holy Radiance
			self:Nameplate(424431, 1.1, guid) -- Holy Radiance
			self:CDBar(448515, 4.0) -- Divine Judgment
			self:Nameplate(448515, 4.0, guid) -- Divine Judgment
			self:CDBar(427583, 7.6) -- Repentance
			self:Nameplate(427583, 7.6, guid) -- Repentance
		end
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:HolyRadiance(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		-- 2s cast + 8s channel + 25s energy gain + delay
		self:CDBar(args.spellId, 36.4)
		self:Nameplate(args.spellId, 36.4, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:HolyRadianceSuccess(args)
		nextHolyRadiance = GetTime() + 34.4
	end

	function mod:DivineJudgment(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 13.4)
		self:Nameplate(args.spellId, 13.4, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:Repentance(args) -- XXX removed in 11.1
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 20.6)
		self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:ElaenaEmberlanzDeath(args)
		elaenaGUID = nil
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(424431) -- Holy Radiance
		self:StopBar(448515) -- Divine Judgment
		self:StopBar(427583) -- Repentance XXX removed in 11.1
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Taener Duelmal

do
	local timer

	function mod:TaenerDuelmalEngaged(guid)
		if isElevenDotOne then
			if self:MobId(guid) == 211289 then -- Taener Duelmal, boss version
				taenerGUID = guid
			end
			self:CDBar(424420, 8.1) -- Cinderblast
			self:Nameplate(424420, 8.1, guid) -- Cinderblast
			local unit = self:UnitTokenFromGUID(guid)
			if unit then
				-- Taener's energy doesn't always reset after a wipe
				local timeUntilEmberStorm = 25.2 * (1 - UnitPower(unit) / UnitPowerMax(unit))
				nextEmberStorm = GetTime() + timeUntilEmberStorm
				self:CDBar(424462, timeUntilEmberStorm) -- Ember Storm
				self:Nameplate(424462, timeUntilEmberStorm, guid) -- Ember Storm
			else
				nextEmberStorm = GetTime() + 25.2
				self:CDBar(424462, 25.2) -- Ember Storm
				self:Nameplate(424462, 25.2, guid) -- Ember Storm
			end
		else -- XXX remove in 11.1
			self:CDBar(424462, 2.1) -- Ember Storm
			self:Nameplate(424462, 2.1, guid) -- Ember Storm
			self:CDBar(424420, 5.6) -- Cinderblast
			self:Nameplate(424420, 5.6, guid) -- Cinderblast
		end
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
	end

	function mod:Cinderblast(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if self:Interrupter() then
			self:PlaySound(args.spellId, "warning")
		end
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
	end

	function mod:CinderblastInterrupt(args)
		self:CDBar(424420, 15.0)
		self:Nameplate(424420, 15.0, args.destGUID)
	end

	function mod:CinderblastSuccess(args)
		self:CDBar(args.spellId, 15.0)
		self:Nameplate(args.spellId, 15.0, args.sourceGUID)
	end

	function mod:CinderblastApplied(args)
		local onMe = self:Me(args.destGUID)
		if onMe or self:Dispeller("magic", nil, args.spellId) then
			self:TargetMessage(args.spellId, "orange", args.destName)
			if onMe then
				self:PlaySound(args.spellId, "info", nil, args.destName)
			else
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			end
		end
	end

	function mod:EmberStorm(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		-- cast at 100 energy: 1.5s cast, 6s channel, 1s delay, 25s energy gain
		self:CDBar(args.spellId, 34.0)
		self:Nameplate(args.spellId, 34.0, args.sourceGUID)
		self:PlaySound(args.spellId, "long")
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
	end

	function mod:EmberStormSuccess(args)
		nextEmberStorm = GetTime() + 32.5
	end

	function mod:TaenerDuelmalDeath(args)
		taenerGUID = nil
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(424420) -- Cinderblast
		self:StopBar(424462) -- Ember Storm
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Captain Dailcry

function mod:BattleCryApplied(args)
	if self:IsMobEngaged(args.destGUID) then
		local t = GetTime()
		local mobId = self:MobId(args.destGUID)
		-- we start most of these timers "early" (at cast start) but gaining Battle Cry during each ability's
		-- cast does nothing because energy will still be at 100. this is accounted for because the nextAbility
		-- trackers aren't set until energy resets to 0.
		if mobId == 211291 or mobId == 239836 then -- Sergeant Shaynemail
			local timeUntilBrutalSmash = nextBrutalSmash - t
			if timeUntilBrutalSmash > 0 then
				nextBrutalSmash = nextBrutalSmash - 12.5
				timeUntilBrutalSmash = timeUntilBrutalSmash - 12.5
				if timeUntilBrutalSmash > 0 then
					self:CDBar(424621, {timeUntilBrutalSmash, 29.1}) -- Brutal Smash
					self:Nameplate(424621, timeUntilBrutalSmash, args.destGUID) -- Brutal Smash
				else
					self:CDBar(424621, {0.01, 29.1}) -- Brutal Smash
					self:Nameplate(424621, 0, args.destGUID) -- Brutal Smash
				end
			end
		elseif mobId == 211290 or mobId == 239833 then -- Elaena Emberlanz
			local timeUntilHolyRadiance = nextHolyRadiance - t
			if timeUntilHolyRadiance > 0 then
				nextHolyRadiance = nextHolyRadiance - 12.5
				timeUntilHolyRadiance = timeUntilHolyRadiance - 12.5
				if timeUntilHolyRadiance > 0 then
					self:CDBar(424431, {timeUntilHolyRadiance, 36.4}) -- Holy Radiance
					self:Nameplate(424431, timeUntilHolyRadiance, args.destGUID) -- Holy Radiance
				else
					self:CDBar(424431, {0.01, 36.4}) -- Holy Radiance
					self:Nameplate(424431, 0, args.destGUID) -- Holy Radiance
				end
			end
		elseif mobId == 211289 or mobId == 239834 then -- Taener Duelmal
			local timeUntilEmberStorm = nextEmberStorm - t
			if timeUntilEmberStorm > 0 then
				nextEmberStorm = nextEmberStorm - 12.5
				timeUntilEmberStorm = timeUntilEmberStorm - 12.5
				if timeUntilEmberStorm > 0 then
					self:CDBar(424462, {timeUntilEmberStorm, 34.0}) -- Ember Storm
					self:Nameplate(424462, timeUntilEmberStorm, args.destGUID) -- Ember Storm
				else
					self:CDBar(424462, {0.01, 34.0}) -- Ember Storm
					self:Nameplate(424462, 0, args.destGUID) -- Ember Storm
				end
			end
		end
	end
end

function mod:CaptainDailcryWipe() -- called from CaptainDailcry's OnWipe
	-- clear timers for any mini-bosses that reset with the boss as well
	if shaynemailGUID then
		self:SergeantShaynemailDeath({destGUID = shaynemailGUID})
	end
	if elaenaGUID then
		self:ElaenaEmberlanzDeath({destGUID = elaenaGUID})
	end
	if taenerGUID then
		self:TaenerDuelmalDeath({destGUID = taenerGUID})
	end
end

-- Arathi Knight

function mod:ArathiKnightEngaged(guid)
	self:Nameplate(427609, 20.1, guid) -- Disrupting Shout
end

function mod:DisruptingShout(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:ArathiKnightDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Arathi Footman

function mod:ArathiFootmanEngaged(guid)
	-- Defend isn't cast until 50%
	if self:Normal() then
		-- Mortal Strike is only cast in Normal
		self:Nameplate(426964, 2.3, guid) -- Mortal Strike
	end
end

do
	local prev = 0
	function mod:Defend(args)
		if self:Normal() then
			self:Nameplate(args.spellId, 60.7, args.sourceGUID)
		else -- Heroic, Mythic
			self:Nameplate(args.spellId, 30.3, args.sourceGUID)
		end
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:MortalStrike(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:MortalStrikeSuccess(args)
	self:Nameplate(args.spellId, 15.5, args.sourceGUID)
end

function mod:ArathiFootmanDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Fervent Sharpshooter

function mod:FerventSharpshooterEngaged(guid)
	self:Nameplate(453458, 8.3, guid) -- Caltrops
end

do
	local prev = 0
	function mod:Caltrops(args)
		self:Nameplate(args.spellId, 27.9, args.sourceGUID)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:CaltropsApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement", nil, 453458) then
		self:TargetMessage(453458, "yellow", args.destName)
		self:PlaySound(453458, "info", nil, args.destName)
	end
end

function mod:FerventSharpshooterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Devout Priest

function mod:DevoutPriestEngaged(guid)
	-- Greater Heal is not cast until a mob's health is low
	self:Nameplate(427346, 7.1, guid) -- Inner Fire
end

do
	local prev = 0
	function mod:GreaterHeal(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:GreaterHealInterrupt(args)
	self:Nameplate(427356, 25.5, args.destGUID)
end

function mod:GreaterHealSuccess(args)
	self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

do
	local prev = 0
	function mod:InnerFire(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:InnerFireInterrupt(args)
	self:Nameplate(427346, 21.1, args.destGUID)
end

function mod:InnerFireSuccess(args)
	self:Nameplate(args.spellId, 21.1, args.sourceGUID)
end

function mod:InnerFireApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then -- filter Spellsteal
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:DevoutPriestDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Fanatical Conjuror

function mod:FanaticalConjurorEngaged(guid)
	self:Nameplate(427484, 6.0, guid) -- Flamestrike
end

do
	local prev = 0
	function mod:Flamestrike(args)
		-- goes on cooldown at cast start
		if isElevenDotOne then
			self:Nameplate(args.spellId, 23.1, args.sourceGUID)
		else
			self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:FlamestrikeDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(427484, "underyou")
			self:PlaySound(427484, "underyou")
		end
	end
end

function mod:FanaticalConjurorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Lightspawn

function mod:LightspawnEngaged(guid)
	self:Nameplate(448787, 9.2, guid) -- Purification
end

function mod:Purification(args)
	self:Nameplate(args.spellId, 16.2, args.sourceGUID)
end

function mod:PurificationApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local prev = 0
	function mod:BurstOfLight(args)
		-- cast at 20%, mob dies after this cast
		self:ClearNameplate(args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "long")
		end
	end
end

function mod:LightspawnDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ardent Paladin

function mod:ArdentPaladinEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(424429, 8.3, guid) -- Consecration
	else -- XXX remove in 11.1
		self:Nameplate(424429, 8.0, guid) -- Consecration
	end
end

function mod:Consecration(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 23.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:ConsecrationDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(424429, "underyou")
			self:PlaySound(424429, "underyou")
		end
	end
end

function mod:ArdentPaladinDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Risen Mage

function mod:RisenMageEngaged(guid)
	if isElevenDotOne then
		self:Nameplate(444743, 10.0, guid) -- Fireball Volley
	else -- XXX remove in 11.1
		self:Nameplate(444743, 8.0, guid) -- Fireball Volley
	end
end

do
	local prev = 0
	function mod:FireballVolley(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:FireballVolleyInterrupt(args)
	if isElevenDotOne then
		self:Nameplate(444743, 22.2, args.destGUID)
	else -- XXX remove in 11.1
		self:Nameplate(444743, 15.7, args.destGUID)
	end
end

function mod:FireballVolleySuccess(args)
	if isElevenDotOne then
		self:Nameplate(args.spellId, 22.2, args.sourceGUID)
	else -- XXX remove in 11.1
		self:Nameplate(444743, 15.7, args.destGUID)
	end
end

function mod:RisenMageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sir Braunpyke

do
	local timer

	function mod:SirBraunpykeEngaged(guid)
		self:CDBar(435165, 7.1) -- Blazing Strike
		self:Nameplate(435165, 7.1, guid) -- Blazing Strike
		timer = self:ScheduleTimer("SirBraunpykeDeath", 30)
	end

	function mod:BlazingStrike(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 13.3)
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("SirBraunpykeDeath", 30)
	end

	function mod:SirBraunpykeDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(435165) -- Blazing Strike
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end
