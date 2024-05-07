--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Algeth'ar Academy Trash", 2526)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	196974, -- Black Dragonflight Recruiter
	196977, -- Bronze Dragonflight Recruiter
	196978, -- Blue Dragonflight Recruiter
	196979, -- Green Dragonflight Recruiter
	196981, -- Red Dragonflight Recruiter
	196045, -- Corrupted Manafiend
	196577, -- Spellbound Battleaxe
	196576, -- Spellbound Scepter
	196671, -- Arcane Ravager
	196044, -- Unruly Textbook
	192680, -- Guardian Sentry
	192333, -- Alpha Eagle
	197219, -- Vile Lasher
	196200, -- Algeth'ar Echoknight
	196202, -- Spectral Invoker
	196203 -- Ethereal Restorer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_recruiter_autotalk = "Autotalk"
	L.custom_on_recruiter_autotalk_desc = "Instantly pledge to the Dragonflight Recruiters for a buff."
	L.custom_on_recruiter_autotalk_icon = "ui_chat"
	L.critical_strike = "+5% Critical Strike"
	L.haste = "+5% Haste"
	L.mastery = "+Mastery"
	L.versatility = "+5% Versatility"
	L.healing_taken = "+10% Healing taken"

	-- Ah! Here we are! Ahem--long ago, members of the blue dragonflight accidentally overloaded an arcane elemental and created a powerful construct named Vexamus that quickly started to wreak havoc!
	L.vexamus_warmup_trigger = "created a powerful construct named Vexamus"
	-- Perfect, we are just about--wait, Ichistrasz! There is too much life magic! What are you doing?
	L.overgrown_ancient_warmup_trigger = "Ichistrasz! There is too much life magic"
	-- At least we know that works. Watch yourselves.
	L.crawth_warmup_trigger = "At least we know that works. Watch yourselves."

	L.corrupted_manafiend = "Corrupted Manafiend"
	L.spellbound_battleaxe = "Spellbound Battleaxe"
	L.spellbound_scepter = "Spellbound Scepter"
	L.arcane_ravager = "Arcane Ravager"
	L.unruly_textbook = "Unruly Textbook"
	L.guardian_sentry = "Guardian Sentry"
	L.alpha_eagle = "Alpha Eagle"
	L.vile_lasher = "Vile Lasher"
	L.algethar_echoknight = "Algeth'ar Echoknight"
	L.spectral_invoker = "Spectral Invoker"
	L.ethereal_restorer = "Ethereal Restorer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"custom_on_recruiter_autotalk",
		389516, -- Black Dragonflight Pledge Pin
		389512, -- Bronze Dragonflight Pledge Pin
		389521, -- Blue Dragonflight Pledge Pin
		389536, -- Green Dragonflight Pledge Pin
		389501, -- Red Dragonflight Pledge Pin
		-- Corrupted Manafiend
		388863, -- Mana Void
		-- Spellbound Battleaxe
		{388911, "TANK"}, -- Severing Slash
		-- Spellbound Scepter
		396812, -- Mystic Blast
		-- Arcane Ravager
		388976, -- Riftbreath
		{388984, "SAY"}, -- Vicious Ambush
		-- Unruly Textbook
		388392, -- Monotonous Lecture
		-- Guardian Sentry
		377912, -- Expel Intruders
		378003, -- Deadly Winds
		{377991, "TANK"}, -- Storm Slash
		-- Alpha Eagle
		377389, -- Call of the Flock
		377383, -- Gust
		-- Vile Lasher
		390912, -- Detonation Seeds
		-- Algeth'ar Echoknight
		387910, -- Astral Whirlwind
		-- Spectral Invoker
		{387843, "SAY", "SAY_COUNTDOWN"}, -- Astral Bomb
		-- Ethereal Restorer
		{387955, "DISPEL"}, -- Celestial Shield
	}, {
		["custom_on_recruiter_autotalk"] = CL.general,
		[388863] = L.corrupted_manafiend,
		[388911] = L.spellbound_battleaxe,
		[396812] = L.spellbound_scepter,
		[388976] = L.arcane_ravager,
		[388392] = L.unruly_textbook,
		[377912] = L.guardian_sentry,
		[377389] = L.alpha_eagle,
		[390912] = L.vile_lasher,
		[387910] = L.algethar_echoknight,
		[387843] = L.spectral_invoker,
		[387955] = L.ethereal_restorer,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "BlackPledgeApplied", 389516)
	self:Log("SPELL_AURA_APPLIED", "BronzePledgeApplied", 389512)
	self:Log("SPELL_AURA_APPLIED", "BluePledgeApplied", 389521)
	self:Log("SPELL_AURA_APPLIED", "GreenPledgeApplied", 389536)
	self:Log("SPELL_AURA_APPLIED", "RedPledgeApplied", 389501)

	-- Corrupted Manafiend
	self:Log("SPELL_CAST_START", "ManaVoid", 388863)

	-- Spellbound Battleaxe
	self:Log("SPELL_CAST_START", "SeveringSlash", 388911)

	-- Spellbound Scepter
	self:Log("SPELL_CAST_START", "MysticBlast", 396812)

	-- Arcane Ravager
	self:Log("SPELL_CAST_START", "Riftbreath", 388976)
	self:Log("SPELL_AURA_APPLIED", "ViciousAmbush", 388984)

	-- Unruly Textbook
	self:Log("SPELL_CAST_START", "MonotonousLecture", 388392)

	-- Guardian Sentry
	self:Log("SPELL_CAST_START", "ExpelIntruders", 377912)
	self:Log("SPELL_CAST_START", "DeadlyWinds", 378003)
	self:Log("SPELL_CAST_START", "StormSlash", 377991)
	self:Death("GuardianSentryDeath", 192680)

	-- Alpha Eagle
	self:Log("SPELL_CAST_START", "CallOfTheFlock", 377389)
	self:Log("SPELL_CAST_START", "Gust", 377383)

	-- Vile Lasher
	self:Log("SPELL_CAST_SUCCESS", "DetonationSeeds", 390912)

	-- Algeth'ar Echoknight
	self:Log("SPELL_CAST_START", "AstralWhirlwind", 387910)
	self:Log("SPELL_AURA_APPLIED", "AstralWhirlwindDamage", 387932)
	self:Log("SPELL_PERIODIC_DAMAGE", "AstralWhirlwindDamage", 387932)
	self:Log("SPELL_PERIODIC_MISSED", "AstralWhirlwindDamage", 387932)

	-- Spectral Invoker
	self:Log("SPELL_AURA_APPLIED", "AstralBombApplied", 387843)
	self:Log("SPELL_AURA_REMOVED", "AstralBombRemoved", 387843)

	-- Ethereal Restorer
	self:Log("SPELL_AURA_APPLIED", "CelestialShieldApplied", 387955)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup timers

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg:find(L.vexamus_warmup_trigger, nil, true) then
		-- Vexamus warmup
		local vexamusModule = BigWigs:GetBossModule("Vexamus", true)
		if vexamusModule then
			vexamusModule:Enable()
			vexamusModule:Warmup()
		end
	elseif msg:find(L.overgrown_ancient_warmup_trigger, nil, true) then
		-- Overgrown Ancient warmup
		local overgrownAncientModule = BigWigs:GetBossModule("Overgrown Ancient", true)
		if overgrownAncientModule then
			overgrownAncientModule:Enable()
			overgrownAncientModule:Warmup()
		end
	elseif msg:find(L.crawth_warmup_trigger, nil, true) then
		-- Crawth warmup
		local crawthModule = BigWigs:GetBossModule("Crawth", true)
		if crawthModule then
			crawthModule:Enable()
			crawthModule:Warmup()
		end
	end
end

-- Auto-gossip

function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_recruiter_autotalk") then
		if self:GetGossipID(107065) then
			-- Black Dragonflight Recruiter (+Critical Strike)
			self:SelectGossipID(107065)
		elseif self:GetGossipID(107081) then
			-- Bronze Dragonflight Recruiter (+Haste)
			self:SelectGossipID(107081)
		elseif self:GetGossipID(107082) then
			-- Blue Dragonflight Recruiter (+Mastery)
			self:SelectGossipID(107082)
		elseif self:GetGossipID(107083) then
			-- Green Dragonflight Recruiter (+Healing Taken)
			self:SelectGossipID(107083)
		elseif self:GetGossipID(107088) then
			-- Red Dragonflight Recruiter (+Versatility)
			self:SelectGossipID(107088)
		end
	end
end

-- Dragonflight Pledge Pins

function mod:BlackPledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.critical_strike)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BronzePledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.haste)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BluePledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.mastery)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:GreenPledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.healing_taken)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:RedPledgeApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", L.versatility)
		self:PlaySound(args.spellId, "info")
	end
end

-- Corrupted Manafiend

do
	local prev = 0
	function mod:ManaVoid(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Spellbound Battleaxe

do
	local prev = 0
	function mod:SeveringSlash(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Spellbound Scepter

function mod:MysticBlast(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Arcane Ravager

function mod:Riftbreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ViciousAmbush(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId, nil, nil, "Vicious Ambush")
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Unruly Textbook

do
	local prev = 0
	function mod:MonotonousLecture(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Guardian Sentry

function mod:ExpelIntruders(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 26.7)
end

function mod:DeadlyWinds(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 11)
end

function mod:StormSlash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end

function mod:GuardianSentryDeath(args)
	self:StopBar(377912) -- Expel Intruders
	self:StopBar(378003) -- Deadly Winds
	self:StopBar(377991) -- Storm Slash
end

-- Alpha Eagle

function mod:CallOfTheFlock(args)
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:Gust(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Vile Lasher

do
	local prev = 0
	function mod:DetonationSeeds(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Algeth'ar Echoknight

do
	local prev = 0
	function mod:AstralWhirlwind(args)
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
	function mod:AstralWhirlwindDamage(args)
		if self:Me(args.destGUID) and not self:Tank() then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PlaySound(387910, "underyou")
				self:PersonalMessage(387910, "near")
			end
		end
	end
end

-- Spectral Invoker

do
	local prev = 0
	local prevSay = 0
	function mod:AstralBombApplied(args)
		local t = args.time
		local onMe = self:Me(args.destGUID)
		if t - prev > 1.5 then
			prev = t
			self:TargetMessage(args.spellId, "yellow", args.destName)
			if onMe then
				self:PlaySound(args.spellId, "info", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
		if onMe and t - prevSay > 3 then
			prevSay = t
			self:Say(args.spellId, nil, nil, "Astral Bomb")
			self:SayCountdown(args.spellId, 3, nil, 2)
		end
	end
end

function mod:AstralBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Ethereal Restorer

-- no longer alerting on start cast, it's stunnable but not interruptible. but most importantly
-- this doesn't scale with key level as of 2023-02-05.
function mod:CelestialShieldApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert")
	end
end
