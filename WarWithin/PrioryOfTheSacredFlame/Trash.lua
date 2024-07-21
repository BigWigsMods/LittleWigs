if not BigWigsLoader.isBeta then return end
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
	211291, -- Sergeant Shaynemail
	211290, -- Elaena Emberlanz
	211289, -- Taener Duelmal
	206696, -- Arathi Knight
	206705, -- Arathi Footman
	206697, -- Devout Priest
	206698, -- Fanatical Mage
	206710, -- Lightspawn
	217658 -- Sir Braunpyke
)

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
	L.devout_priest = "Devout Priest"
	L.fanatical_mage = "Fanatical Mage"
	L.lightspawn = "Lightspawn"
	L.sir_braunpyke = "Sir Braunpyke"

	L.baron_braunpyke_warmup_trigger = "They've served their purpose. Baron, demonstrate your worth."
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true) -- TODO buff locale?
function mod:GetOptions()
	return {
		-- Sacred Flame
		autotalk,
		435088, -- Blessing of the Sacred Flame
		-- Guard Captain Suleyman
		{448485, "TANK_HEALER"}, -- Shield Slam
		448492, -- Thunderclap
		-- Forge Master Damian
		427897, -- Heat Wave
		427950, -- Seal of Flame
		-- High Priest Aemya
		429091, -- Inner Light
		428150, -- Reflective Shield
		-- Sergeant Shaynemail
		424621, -- Brutal Smash
		424423, -- Lunging Strike
		-- Elaena Emberlanz
		{424431, "HEALER"}, -- Holy Radiance
		{448515, "TANK"}, -- Divine Judgment
		427583, -- Repentance
		-- Taener Duelmal
		{424420, "DISPEL"}, -- Cinderblast
		424462, -- Ember Storm
		-- Arathi Knight
		427609, -- Disrupting Shout
		-- Arathi Footman
		427342, -- Defend
		-- Devout Priest
		427356, -- Greater Heal
		{427346, "DISPEL"}, -- Inner Light
		-- Fanatical Mage
		427484, -- Flamestrike
		-- Lightspawn
		427601, -- Burst of Light
	}, {
		[autotalk] = L.sacred_flame,
		[448485] = L.guard_captain_suleyman,
		[427897] = L.forge_master_damian,
		[429091] = L.high_priest_aemya,
		[424621] = L.sergeant_shaynemail,
		[424431] = L.elaena_emberlanz,
		[424420] = L.taener_duelmal,
		[427609] = L.arathi_knight,
		[427342] = L.arathi_footman,
		[427356] = L.devout_priest,
		[427484] = L.fanatical_mage,
		[427601] = L.lightspawn,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Sacred Flame
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "BlessingOfTheSacredFlame", 435088)

	-- Guard Captain Suleyman
	self:Log("SPELL_CAST_START", "ShieldSlam", 448485)
	self:Log("SPELL_CAST_START", "Thunderclap", 448492)
	self:Death("GuardCaptainSuleymanDeath", 212826)

	-- Forge Master Damian
	self:Log("SPELL_CAST_START", "HeatWave", 427897)
	self:Log("SPELL_CAST_START", "SealOfFlame", 427950)
	self:Death("ForgeMasterDamianDeath", 212831)

	-- High Priest Aemya
	self:Log("SPELL_CAST_START", "InnerLight", 429091)
	self:Log("SPELL_CAST_START", "ReflectiveShield", 428150)
	self:Death("HighPriestAemyaDeath", 212827)

	-- Sergeant Shaynemail
	self:Log("SPELL_CAST_START", "BrutalSmash", 424621)
	self:Log("SPELL_CAST_START", "LungingStrike", 424423)
	self:Death("SergeantShaynemailDeath", 211291)

	-- Elaena Emberlanz
	self:Log("SPELL_CAST_START", "HolyRadiance", 424431)
	self:Log("SPELL_CAST_START", "DivineJudgment", 448515)
	self:Log("SPELL_CAST_START", "Repentance", 427583)
	self:Death("ElaenaEmberlanzDeath", 211290)

	-- Taener Duelmal
	self:Log("SPELL_CAST_START", "Cinderblast", 424420)
	self:Log("SPELL_AURA_APPLIED", "CinderblastApplied", 424420)
	self:Log("SPELL_CAST_START", "EmberStorm", 424462)
	self:Death("TaenerDuelmalDeath", 211289)

	-- Arathi Knight
	self:Log("SPELL_CAST_START", "DisruptingShout", 427609)

	-- Arathi Footman
	self:Log("SPELL_CAST_SUCCESS", "Defend", 427342) -- alert on SUCCESS instead of START, it will just recast if you stop the initial cast

	-- Devout Priest
	self:Log("SPELL_CAST_START", "GreaterHeal", 427356)
	self:Log("SPELL_AURA_APPLIED", "InnerLightApplied", 427346)

	-- Fanatical Mage
	self:Log("SPELL_CAST_START", "Flamestrike", 427484)

	-- Lightspawn
	self:Log("SPELL_CAST_START", "BurstOfLight", 427601)
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

-- Sacred Flame Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(120716) then
			-- Paladins and Priests can talk to the Sacred Flame to buff the whole party with
			-- Blessing of the Sacred Flame, which causes your attacks to deal bonus damage.
			-- 120716:Harness the power of the Eternal Flame.
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

	function mod:ShieldSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 9.7)
		timer = self:ScheduleTimer("GuardCaptainSuleymanDeath", 30)
	end

	function mod:Thunderclap(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 15.8)
		timer = self:ScheduleTimer("GuardCaptainSuleymanDeath", 30)
	end

	function mod:GuardCaptainSuleymanDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(448485) -- Shield Slam
		self:StopBar(448492) -- Thunderclap
	end
end

-- Forge Master Damian

do
	local timer

	function mod:HeatWave(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 9.7)
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	function mod:SealOfFlame(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 26.7)
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	function mod:ForgeMasterDamianDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(427897) -- Heat Wave
		self:StopBar(427950) -- Seal of Flame
	end
end

-- High Priest Aemya

do
	local timer

	function mod:InnerLight(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if not unit or not UnitAffectingCombat(unit) then
			-- occasionally cast when not engaged
			return
		end
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 30.3)
		timer = self:ScheduleTimer("HighPriestAemyaDeath", 30)
	end

	function mod:ReflectiveShield(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 48.6)
		timer = self:ScheduleTimer("HighPriestAemyaDeath", 30)
	end

	function mod:HighPriestAemyaDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(429091) -- Inner Light
		self:StopBar(428150) -- Reflective Shield
	end
end

-- Sergeant Shaynemail

do
	local timer

	function mod:BrutalSmash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 26.7)
		timer = self:ScheduleTimer("SergeantShaynemailDeath", 30)
	end

	function mod:LungingStrike(args)
		if timer then
			self:CancelTimer(timer)
		end
		-- TODO targetscan?
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 14.6)
		timer = self:ScheduleTimer("SergeantShaynemailDeath", 30)
	end

	function mod:SergeantShaynemailDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(424621) -- Brutal Smash
		self:StopBar(424423) -- Lunging Strike
	end
end

-- Elaena Emberlanz

do
	local timer

	function mod:HolyRadiance(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 36.4)
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:DivineJudgment(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 14.5)
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:Repentance(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "long")
		self:CDBar(args.spellId, 15.8)
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:ElaenaEmberlanzDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(424431) -- Holy Radiance
		self:StopBar(448515) -- Divine Judgment
		self:StopBar(427583) -- Repentance
	end
end

-- Taener Duelmal

do
	local timer

	function mod:Cinderblast(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 14.6)
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
	end

	function mod:CinderblastApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			self:TargetMessage(args.spellId, "orange", args.destName)
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		end
	end

	function mod:EmberStorm(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "long")
		self:CDBar(args.spellId, 34.1)
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
	end

	function mod:TaenerDuelmalDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(424420) -- Cinderblast
		self:StopBar(424462) -- Ember Storm
	end
end

-- Arathi Knight

function mod:DisruptingShout(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Arathi Footman

do
	local prev = 0
	function mod:Defend(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Devout Priest

do
	local prev = 0
	function mod:GreaterHeal(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:InnerLightApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then -- filter Spellsteal
		self:Message(args.spellId, "orange", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Fanatical Mage

do
	local prev = 0
	function mod:Flamestrike(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Lightspawn

function mod:BurstOfLight(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end
