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
	196576, -- Spellbound Scepter
	196671, -- Arcane Ravager
	196044, -- Unruly Textbook
	192680, -- Guardian Sentry
	192333, -- Alpha Eagle
	197219, -- Vile Lasher
	196198, -- Algeth'ar Security
	196200, -- Algeth'ar Echoknight
	196202, -- Spectral Invoker
	196203 -- Ethereal Restorer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.recruiter_autotalk = "Autotalk"
	L.recruiter_autotalk_desc = "Instantly pledge to the Dragonflight Recruiters for a buff."
	L.critical_strike = "+5% Critical Strike"
	L.haste = "+5% Haste"
	L.mastery = "+Mastery"
	L.versatility = "+5% Versatility"
	L.healing_taken = "+10% Healing taken"

	L.corrupted_manafiend = "Corrupted Manafiend"
	L.spellbound_scepter = "Spellbound Scepter"
	L.arcane_ravager = "Arcane Ravager"
	L.unruly_textbook = "Unruly Textbook"
	L.guardian_sentry = "Guardian Sentry"
	L.alpha_eagle = "Alpha Eagle"
	L.vile_lasher = "Vile Lasher"
	L.algethar_security = "Algeth'ar Security"
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
		"recruiter_autotalk",
		389516, -- Black Dragonflight Pledge Pin
		389512, -- Bronze Dragonflight Pledge Pin
		389521, -- Blue Dragonflight Pledge Pin
		389536, -- Green Dragonflight Pledge Pin
		389501, -- Red Dragonflight Pledge Pin
		-- Corrupted Manafiend
		388863, -- Mana Void
		-- Spellbound Scepter
		396812, -- Mystic Blast
		388886, -- Arcane Rain
		-- Arcane Ravager
		388976, -- Riftbreath
		{388984, "SAY"}, -- Vicious Ambush
		-- Unruly Textbook
		388392, -- Monotonous Lecture
		-- Guardian Sentry
		377912, -- Expel Intruders
		-- Alpha Eagle
		377389, -- Call of the Flock
		-- Vile Lasher
		390912, -- Detonation Seeds
		-- Algeth'ar Security
		387862, -- Disrupting Pulse
		-- Algeth'ar Echoknight
		387910, -- Astral Whirlwind
		-- Spectral Invoker
		{387843, "SAY", "SAY_COUNTDOWN"}, -- Astral Bomb
		-- Ethereal Restorer
		{387955, "DISPEL"}, -- Celestial Shield
	}, {
		["recruiter_autotalk"] = CL.general,
		[388863] = L.corrupted_manafiend,
		[396812] = L.spellbound_scepter,
		[388976] = L.arcane_ravager,
		[388392] = L.unruly_textbook,
		[377912] = L.guardian_sentry,
		[377389] = L.alpha_eagle,
		[390912] = L.vile_lasher,
		[387862] = L.algethar_security,
		[387910] = L.algethar_echoknight,
		[387843] = L.spectral_invoker,
		[387955] = L.ethereal_restorer,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "BlackPledgeApplied", 389516)
	self:Log("SPELL_AURA_APPLIED", "BronzePledgeApplied", 389512)
	self:Log("SPELL_AURA_APPLIED", "BluePledgeApplied", 389521)
	self:Log("SPELL_AURA_APPLIED", "GreenPledgeApplied", 389536)
	self:Log("SPELL_AURA_APPLIED", "RedPledgeApplied", 389501)

	-- Corrupted Manafiend
	self:Log("SPELL_CAST_START", "ManaVoid", 388863)

	-- Spellbound Scepter
	self:Log("SPELL_CAST_START", "MysticBlast", 396812)
	self:Log("SPELL_CAST_START", "ArcaneRain", 388886)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneRainSuccess", 388886)

	-- Arcane Ravager
	self:Log("SPELL_CAST_START", "Riftbreath", 388976)
	self:Log("SPELL_AURA_APPLIED", "ViciousAmbush", 388984)

	-- Unruly Textbook
	self:Log("SPELL_CAST_START", "MonotonousLecture", 388392)

	-- Guardian Sentry
	self:Log("SPELL_CAST_START", "ExpelIntruders", 377912)

	-- Alpha Eagle
	self:Log("SPELL_CAST_START", "CallOfTheFlock", 377389)

	-- Vile Lasher
	self:Log("SPELL_CAST_SUCCESS", "DetonationSeeds", 390912)

	-- Algeth'ar Security
	self:Log("SPELL_CAST_START", "DisruptingPulse", 387862)

	-- Algeth'ar Echoknight
	self:Log("SPELL_CAST_SUCCESS", "AstralWhirlwind", 387910)
	self:Log("SPELL_AURA_APPLIED", "AstralWhirlwindDamage", 387932)
	self:Log("SPELL_PERIODIC_DAMAGE", "AstralWhirlwindDamage", 387932)
	self:Log("SPELL_PERIODIC_MISSED", "AstralWhirlwindDamage", 387932)

	-- Spectral Invoker
	self:Log("SPELL_CAST_START", "AstralBomb", 387843)
	self:Log("SPELL_AURA_APPLIED", "AstralBombApplied", 387843)

	-- Ethereal Restorer
	self:Log("SPELL_CAST_START", "CelestialShield", 387955)
	self:Log("SPELL_AURA_APPLIED", "CelestialShieldApplied", 387955)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Auto-gossip

function mod:GOSSIP_SHOW(event)
	if self:GetOption("recruiter_autotalk") then
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

-- Spellbound Scepter

function mod:MysticBlast(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:ArcaneRain(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:ArcaneRainSuccess(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end

-- Arcane Ravager

function mod:Riftbreath(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:ViciousAmbush(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId)
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Unruly Textbook

function mod:MonotonousLecture(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Guardian Sentry

function mod:ExpelIntruders(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Alpha Eagle

function mod:CallOfTheFlock(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
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

-- Algeth'ar Security

function mod:DisruptingPulse(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
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
	function mod:AstralBomb(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:AstralBombApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:TargetMessage(args.spellId, "orange", args.destName)
				self:PlaySound(args.spellId, "alarm")
				self:Say(args.spellId)
				self:SayCountdown(args.spellId, 5)
			end
		end
	end
end

-- Ethereal Restorer

function mod:CelestialShield(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:CelestialShieldApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning")
	end
end
