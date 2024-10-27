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
	206698, -- Fanatical Conjuror
	206710, -- Lightspawn
	206704, -- Ardent Paladin
	221760, -- Risen Mage
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
		{448485, "TANK_HEALER"}, -- Shield Slam
		448492, -- Thunderclap
		-- Forge Master Damian
		427897, -- Heat Wave
		427950, -- Seal of Flame
		-- High Priest Aemya
		429091, -- Inner Fire
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
		{427609, "NAMEPLATE"}, -- Disrupting Shout
		-- Arathi Footman
		{427342, "NAMEPLATE"}, -- Defend
		-- Devout Priest
		{427356, "NAMEPLATE"}, -- Greater Heal
		{427346, "DISPEL", "NAMEPLATE"}, -- Inner Fire
		-- Fanatical Conjuror
		{427484, "NAMEPLATE"}, -- Flamestrike
		-- Lightspawn
		427601, -- Burst of Light
		-- Ardent Paladin
		{424429, "NAMEPLATE"}, -- Consecration
		-- Risen Mage
		{444743, "NAMEPLATE"}, -- Fireball Volley
	}, {
		["custom_on_autotalk"] = L.sacred_flame,
		[448485] = L.guard_captain_suleyman,
		[427897] = L.forge_master_damian,
		[429091] = L.high_priest_aemya,
		[424621] = L.sergeant_shaynemail,
		[424431] = L.elaena_emberlanz,
		[424420] = L.taener_duelmal,
		[427609] = L.arathi_knight,
		[427342] = L.arathi_footman,
		[427356] = L.devout_priest,
		[427484] = L.fanatical_conjuror,
		[427601] = L.lightspawn,
		[424429] = L.ardent_paladin,
		[444743] = L.risen_mage,
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
	self:Log("SPELL_CAST_START", "InnerFireAemya", 429091)
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
	self:Death("ArathiKnightDeath", 206696)

	-- Arathi Footman
	self:Log("SPELL_CAST_SUCCESS", "Defend", 427342)
	self:Death("ArathiFootmanDeath", 206705)

	-- Devout Priest
	self:Log("SPELL_CAST_START", "GreaterHeal", 427356)
	self:Log("SPELL_INTERRUPT", "GreaterHealInterrupt", 427356)
	self:Log("SPELL_CAST_SUCCESS", "GreaterHealSuccess", 427356)
	self:Log("SPELL_CAST_START", "InnerFire", 427346)
	self:Log("SPELL_INTERRUPT", "InnerFireInterrupt", 427346)
	self:Log("SPELL_CAST_SUCCESS", "InnerFireSuccess", 427346)
	self:Log("SPELL_AURA_APPLIED", "InnerFireApplied", 427346)
	self:Death("DevoutPriestDeath", 206697)

	-- Fanatical Conjuror
	self:Log("SPELL_CAST_START", "Flamestrike", 427484)
	self:Death("FanaticalConjurorDeath", 206698)

	-- Lightspawn
	self:Log("SPELL_CAST_START", "BurstOfLight", 427601)

	-- Ardent Paladin
	self:Log("SPELL_CAST_SUCCESS", "Consecration", 424429)
	self:Log("SPELL_PERIODIC_DAMAGE", "ConsecrationDamage", 424430) -- no alert on APPLIED, doesn't damage for 1.5s
	self:Log("SPELL_PERIODIC_MISSED", "ConsecrationDamage", 424430)
	self:Death("ArdentPaladinDeath", 206704)

	-- Risen Mage
	self:Log("SPELL_CAST_START", "FireballVolley", 444743)
	self:Log("SPELL_INTERRUPT", "FireballVolleyInterrupt", 444743)
	self:Log("SPELL_CAST_SUCCESS", "FireballVolleySuccess", 444743)
	self:Death("RisenMageDeath", 221760)
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

	function mod:ShieldSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 14.6)
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

	function mod:GuardCaptainSuleymanDeath()
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
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	function mod:SealOfFlame(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("ForgeMasterDamianDeath", 30)
	end

	function mod:ForgeMasterDamianDeath()
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

	function mod:InnerFireAemya(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if not unit or not UnitAffectingCombat(unit) then
			-- occasionally cast when not engaged
			return
		end
		if timer then
			self:CancelTimer(timer)
		end
		-- TODO is this still cast in combat?
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 30.3)
		timer = self:ScheduleTimer("HighPriestAemyaDeath", 60)
	end

	function mod:ReflectiveShield(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 53.4)
		timer = self:ScheduleTimer("HighPriestAemyaDeath", 60)
	end

	function mod:HighPriestAemyaDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(429091) -- Inner Fire
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

	function mod:SergeantShaynemailDeath()
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
		self:CDBar(args.spellId, 13.4)
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:Repentance(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
		self:CDBar(args.spellId, 20.6)
		timer = self:ScheduleTimer("ElaenaEmberlanzDeath", 30)
	end

	function mod:ElaenaEmberlanzDeath()
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
		if self:Interrupter() then
			self:PlaySound(args.spellId, "warning")
		end
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
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
		self:PlaySound(args.spellId, "long")
		self:CDBar(args.spellId, 34.1)
		timer = self:ScheduleTimer("TaenerDuelmalDeath", 30)
	end

	function mod:TaenerDuelmalDeath()
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
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
end

function mod:ArathiKnightDeath(args)
	self:ClearNameplate(args.destGUID)
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
		self:Nameplate(args.spellId, 31.6, args.sourceGUID)
	end
end

function mod:ArathiFootmanDeath(args)
	self:ClearNameplate(args.destGUID)
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
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:GreaterHealInterrupt(args)
	self:Nameplate(427356, 25.5, args.destGUID)
end

function mod:GreaterHealSuccess(args)
	self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

function mod:InnerFire(args)
	self:Nameplate(args.spellId, 0, args.sourceGUID)
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

do
	local prev = 0
	function mod:Flamestrike(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	end
end

function mod:FanaticalConjurorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Lightspawn

do
	local prev = 0
	function mod:BurstOfLight(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "long")
		end
	end
end

-- Ardent Paladin

function mod:Consecration(args)
	self:Nameplate(args.spellId, 23.0, args.sourceGUID)
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

do
	local prev = 0
	function mod:FireballVolley(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:FireballVolleyInterrupt(args)
	self:Nameplate(444743, 15.7, args.destGUID)
end

function mod:FireballVolleySuccess(args)
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
end

function mod:RisenMageDeath(args)
	self:ClearNameplate(args.destGUID)
end
