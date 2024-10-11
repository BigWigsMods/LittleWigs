--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Delve Rares", {2664, 2679, 2680, 2681, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690}) -- All Delves
if not mod then return end
mod:RegisterEnableMob(
	223541, -- Stolen Loader
	207482, -- Invasive Sporecap
	228044, -- Reno Jackson
	228030, -- Sir Finley Mrgglton
	208728, -- Treasure Wraith
	227632, -- Venombite
	227635, -- Kas'dru
	227513, -- Tala
	227514, -- Velo
	227573, -- Anub'vir
	227471, -- Zekvir (unattackable)
	217208 -- Zekvir (random spawn)
)

--------------------------------------------------------------------------------
-- Locals
--

local zekvirEngaged = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rares = "Rares"

	L.stolen_loader = "Stolen Loader"
	L.invasive_sporecap = "Invasive Sporecap"
	L.reno_jackson = "Reno Jackson"
	L.sir_finley_mrgglton = "Sir Finley Mrgglton"
	L.treasure_wraith = "Treasure Wraith"
	L.venombite = "Venombite"
	L.kasdru = "Kas'dru"
	L.tala = "Tala"
	L.velo = "Velo"
	L.anubvir = "Anub'vir"
	L.zekvir = "Zekvir"
	L.zekvirs_influence = "Zekvir's Influence"
	L.zekvir_random = "Zekvir (Random Spawn)"
	L.zekvir_breach = "Zekvir incoming"
	L.zekvir_breach_desc = "Show an alert when Zekvir is spawning in the Delve."
	L.zekvir_breach_icon = "INV_Achievement_RaidNerubian_NerubianHulk"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.rares
	self:SetSpellRename(445781, CL.frontal_cone) -- Lava Blast (Frontal Cone)
	self:SetSpellRename(415253, CL.frontal_cone) -- Fungal Breath (Frontal Cone)
	self:SetSpellRename(415250, CL.explosion) -- Fungal Bloom (Explosion)
	self:SetSpellRename(449038, CL.spikes) -- Impaling Spikes (Spikes)
	self:SetSpellRename(450492, CL.fear) -- Horrendous Roar (Fear)
end

local autotalk = mod:AddAutoTalkOption(false, "boss")
function mod:GetOptions()
	return {
		autotalk,
		-- Stolen Loader
		445781, -- Lava Blast
		445718, -- Magma Hammer
		-- Invasive Sporecap
		415253, -- Fungal Breath
		415250, -- Fungal Bloom
		-- Reno Jackson
		462686, -- Skull Cracker
		400335, -- Spike Traps
		-- Sir Finley Mrgglton
		461741, -- Consecration
		459421, -- Holy Light
		-- Treasure Wraith
		418295, -- Umbral Slash
		418297, -- Castigate
		-- Venombite
		458325, -- Evasive Dance
		458311, -- Venom Bite
		-- Kas'dru
		458397, -- Interrupting Shout
		458369, -- Venom Volley
		-- Tala
		458104, -- Venom Volley
		-- Velo
		458090, -- Void Slice
		458099, -- Grasping Darkness
		-- Anub'vir
		449038, -- Impaling Spikes
		-- Zekvir's Influence
		457880, -- Ascension
		457448, -- Shadow Eruption
		-- Zekvir
		"zekvir_breach",
		450519, -- Angler's Web
		450492, -- Horrendous Roar
		450505, -- Enfeebling Spittle
	},{
		[445781] = L.stolen_loader,
		[415253] = L.invasive_sporecap,
		[462686] = L.reno_jackson,
		[461741] = L.sir_finley_mrgglton,
		[418295] = L.treasure_wraith,
		[458325] = L.venombite,
		[458397] = L.kasdru,
		[458104] = L.tala,
		[458090] = L.velo,
		[449038] = L.anubvir,
		[457880] = L.zekvirs_influence,
		["zekvir_breach"] = L.zekvir_random,
	},{
		[445781] = CL.frontal_cone, -- Lava Blast (Frontal Cone)
		[415253] = CL.frontal_cone, -- Fungal Breath (Frontal Cone)
		[415250] = CL.explosion, -- Fungal Bloom (Explosion)
		[449038] = CL.spikes, -- Impaling Spikes (Spikes)
		[450492] = CL.fear, -- Horrendous Roar (Fear)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Stolen Loader
	self:Log("SPELL_CAST_START", "LavaBlast", 445781)
	self:Log("SPELL_CAST_START", "MagmaHammer", 445718)
	self:Death("StolenLoaderDeath", 223541)

	-- Invasive Sporecap
	self:Log("SPELL_CAST_START", "FungalBreath", 415253)
	self:Log("SPELL_CAST_START", "FungalBloom", 415250)
	self:Death("InvasiveSporecapDeath", 207482)

	-- Reno Jackson
	self:Log("SPELL_CAST_START", "SkullCracker", 462686)
	self:Log("SPELL_CAST_START", "SpikeTraps", 400335)
	self:Log("SPELL_CAST_SUCCESS", "SupplyBag", 447392) -- Reno Jackson defeated

	-- Sir Finley Mrgglton (pulls with Reno Jackson)
	self:Log("SPELL_CAST_START", "Consecration", 461741)
	self:Log("SPELL_AURA_APPLIED", "ConsecrationDamage", 461742)
	self:Log("SPELL_PERIODIC_DAMAGE", "ConsecrationDamage", 461742)
	self:Log("SPELL_PERIODIC_MISSED", "ConsecrationDamage", 461742)
	self:Log("SPELL_CAST_START", "HolyLight", 459421)

	-- Treasure Wraith
	self:Log("SPELL_CAST_START", "UmbralSlash", 418295)
	self:Log("SPELL_AURA_APPLIED", "Castigate", 418297)
	self:Death("TreasureWraithDeath", 208728)

	-- Venombite
	self:Log("SPELL_CAST_START", "EvasiveDance", 458325)
	self:Log("SPELL_CAST_START", "VenomBite", 458311)
	self:Death("VenombiteDeath", 227632)

	-- Kas'dru (pulls with Venombite)
	self:Log("SPELL_CAST_START", "InterruptingShout", 458397)
	self:Log("SPELL_CAST_START", "VenomVolley", 458369)
	self:Death("KasdruDeath", 227635)

	-- Tala
	self:Log("SPELL_CAST_START", "VenomVolley", 458104)
	self:Death("TalaDeath", 227513)

	-- Velo (pulls with Tala)
	self:Log("SPELL_CAST_START", "VoidSlice", 458090)
	self:Log("SPELL_CAST_SUCCESS", "VoidSliceSuccess", 458090)
	self:Log("SPELL_CAST_START", "GraspingDarkness", 458099)
	self:Death("VeloDeath", 227514)

	-- Anub'vir
	self:Log("SPELL_CAST_START", "ImpalingSpikes", 449038)
	self:Death("AnubvirDeath", 227573)

	-- Zekvir's Influence
	self:Log("SPELL_CAST_START", "Ascension", 457880) -- cast by any Zekvir-empowered mob
	self:Log("SPELL_CAST_START", "ShadowEruption", 457448) -- cast by any Zekvir-empowered mob
	self:Log("SPELL_CAST_START", "AnglersWebImage", 457881) -- cast by untargetable Zekvir 227471

	-- Zekvir (random spawn)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Zekvir incoming or Zekvir leaving
	self:Log("SPELL_CAST_START", "EnfeeblingSpittle", 450505)
	self:Log("SPELL_INTERRUPT", "EnfeeblingSpittleInterrupt", 450505)
	self:Log("SPELL_CAST_SUCCESS", "EnfeeblingSpittleSuccess", 450505)
	self:Log("SPELL_AURA_APPLIED", "EnfeeblingSpittleApplied", 450505)
	self:Log("SPELL_CAST_START", "HorrendousRoar", 450492)
	self:Log("SPELL_CAST_START", "AnglersWeb", 450519)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(123520) then -- Reno Jackson, start combat
			-- 123520:Let's fight!
			self:SelectGossipID(123520)
		end
	end
end

-- Stolen Loader

do
	local timer

	function mod:LavaBlast(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.frontal_cone)
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 17.0, CL.frontal_cone)
		timer = self:ScheduleTimer("StolenLoaderDeath", 30)
	end

	function mod:MagmaHammer(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 9.3)
		timer = self:ScheduleTimer("StolenLoaderDeath", 30)
	end

	function mod:StolenLoaderDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(CL.frontal_cone) -- Lava Blast
		self:StopBar(445718) -- Magma Hammer
	end
end

-- Invasive Sporecap

do
	local timer

	function mod:FungalBreath(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange", CL.frontal_cone)
		self:CDBar(args.spellId, 19.4, CL.frontal_cone)
		timer = self:ScheduleTimer("InvasiveSporecapDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:FungalBloom(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.explosion)
		self:CDBar(args.spellId, 23.1, CL.explosion)
		timer = self:ScheduleTimer("InvasiveSporecapDeath", 30)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:InvasiveSporecapDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(CL.frontal_cone) -- Fungal Breath
		self:StopBar(CL.explosion) -- Fungal Bloom
	end
end

-- Reno Jackson

do
	local timer

	function mod:SkullCracker(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 15.8)
		timer = self:ScheduleTimer("RenoJacksonDefeated", 30)
	end

	function mod:SpikeTraps(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 20.6)
		timer = self:ScheduleTimer("RenoJacksonDefeated", 30)
	end

	function mod:SupplyBag(args)
		-- Reno Jackson creates a "Supply Bag" when you defeat him
		if self:MobId(args.sourceGUID) == 228044 then -- Reno Jackson
			self:RenoJacksonDefeated()
		end
	end

	function mod:RenoJacksonDefeated()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(462686) -- Skull Cracker
		self:StopBar(400335) -- Steel Traps
	end
end

-- Sir Finley Mrgglton

function mod:Consecration(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:CDBar(args.spellId, 17.0)
end

do
	local prev = 0
	function mod:ConsecrationDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(461741, "underyou")
			self:PlaySound(461741, "underyou")
		end
	end
end

function mod:HolyLight(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Treasure Wraith

do
	local timer

	function mod:UmbralSlash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 17.6)
		timer = self:ScheduleTimer("TreasureWraithDeath", 30)
	end

	function mod:Castigate(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17.5)
		timer = self:ScheduleTimer("TreasureWraithDeath", 30)
	end

	function mod:TreasureWraithDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(418295) -- Umbral Slash
		self:StopBar(418297) -- Castigate
	end
end

-- Venombite

do
	local timer

	function mod:EvasiveDance(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 21.8)
		timer = self:ScheduleTimer("VenombiteDeath", 30)
	end

	function mod:VenomBite(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 10.3)
		timer = self:ScheduleTimer("VenombiteDeath", 30)
	end

	function mod:VenombiteDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(458325) -- Evasive Dance
		self:StopBar(458311) -- Venom Bite
	end
end

-- Kas'dru

do
	local timer

	function mod:InterruptingShout(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 23.0)
		timer = self:ScheduleTimer("KasdruDeath", 30)
	end

	function mod:VenomVolley(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 18.2)
		timer = self:ScheduleTimer("KasdruDeath", 30)
	end

	function mod:KasdruDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(458397) -- Interrupting Shout
		self:StopBar(458369) -- Venom Volley
	end
end

-- Tala

do
	local timer

	function mod:VenomVolley(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17.8)
		timer = self:ScheduleTimer("TalaDeath", 30)
	end

	function mod:TalaDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(458104) -- Venom Volley
	end
end

-- Velo

do
	local timer

	function mod:VoidSlice(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("VeloDeath", 30)
	end

	function mod:VoidSliceSuccess(args)
		-- doesn't go on cooldown if outranged, 18.2s - 1.5s cast time
		self:CDBar(args.spellId, 16.7)
	end

	function mod:GraspingDarkness(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 21.8)
		timer = self:ScheduleTimer("VeloDeath", 30)
	end

	function mod:VeloDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(458090) -- Void Slice
		self:StopBar(458099) -- Grasping Darkness
	end
end

-- Anub'vir

do
	local timer

	function mod:ImpalingSpikes(args)
		if self:MobId(args.sourceGUID) == 227573 then -- Cast by others
			if timer then
				self:CancelTimer(timer)
			end
			self:Message(args.spellId, "yellow", CL.spikes)
			self:CDBar(args.spellId, 13.3, CL.spikes)
			timer = self:ScheduleTimer("AnubvirDeath", 30)
			self:PlaySound(args.spellId, "warning")
		end
	end

	function mod:AnubvirDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(CL.spikes) -- Impaling Spikes
	end
end

-- Zekvir's Influence

do
	local prev = 0
	function mod:Ascension(args)
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "long")
		end
	end
end

do
	local prev = 0
	function mod:ShadowEruption(args)
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:AnglersWebImage()
	self:Message(450519, "orange")
	self:PlaySound(450519, "alarm")
end

-- Zekvir

do
	local timer

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
		-- [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_Achievement_RaidNerubian_NerubianHulk.BLP:36|t Zekvir has breached the Delve!#Zekvir
		-- [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_Achievement_RaidNerubian_NerubianHulk.BLP:36|t Zekvir burrows into the ground and escapes!#Zekvir
		if msg:find("INV_Achievement_RaidNerubian_NerubianHulk", nil, true) then
			if not zekvirEngaged then
				zekvirEngaged = true
				self:Message("zekvir_breach", "cyan", CL.incoming:format(L.zekvir), L.zekvir_breach_icon)
				self:PlaySound("zekvir_breach", "long")
			else
				self:ZekvirRetreat()
			end
		end
	end

	function mod:EnfeeblingSpittle(args)
		if self:MobId(args.sourceGUID) == 217208 then -- Zekvir rare spawn
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:EnfeeblingSpittleInterrupt(args)
		if self:MobId(args.destGUID) == 217208 then -- Zekvir rare spawn
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
			self:CDBar(450505, 15.3)
			timer = self:ScheduleTimer("ZekvirRetreat", 30)
		end
	end

	function mod:EnfeeblingSpittleSuccess(args)
		if self:MobId(args.sourceGUID) == 217208 then -- Zekvir rare spawn
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
			self:CDBar(args.spellId, 15.3)
			timer = self:ScheduleTimer("ZekvirRetreat", 30)
		end
	end

	function mod:EnfeeblingSpittleApplied(args)
		if self:MobId(args.sourceGUID) == 217208 then -- Zekvir rare spawn
			if self:Me(args.destGUID) then
				self:PersonalMessage(args.spellId)
				self:PlaySound(args.spellId, "info", nil, args.destName)
			end
		end
	end

	function mod:HorrendousRoar(args)
		if self:MobId(args.sourceGUID) == 217208 then -- Zekvir rare spawn
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
			self:Message(args.spellId, "yellow", CL.fear)
			self:CDBar(args.spellId, 18.2, CL.fear)
			timer = self:ScheduleTimer("ZekvirRetreat", 30)
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:AnglersWeb(args)
		if self:MobId(args.sourceGUID) == 217208 then -- Zekvir rare spawn
			if timer then
				self:CancelTimer(timer)
				timer = nil
			end
			self:Message(args.spellId, "orange")
			self:CDBar(args.spellId, 23.1)
			timer = self:ScheduleTimer("ZekvirRetreat", 30)
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:ZekvirRetreat()
		zekvirEngaged = false
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(450505) -- Enfeebling Spittle
		self:StopBar(CL.fear) -- Horrendous Roar
		self:StopBar(450519) -- Angler's Web
	end
end
