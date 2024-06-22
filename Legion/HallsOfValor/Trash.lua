--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Valor Trash", 1477)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95842,  -- Valarjar Thundercaller
	97068,  -- Storm Drake
	96574,  -- Stormforged Sentinel
	96664,  -- Valarjar Runecarver
	95834,  -- Valarjar Mystic
	97197,  -- Valarjar Purifier
	102423, -- Mug of Mead
	95832,  -- Valarjar Shieldmaiden
	101639, -- Valarjar Shieldmaiden
	101637, -- Valarjar Aspirant
	97219,  -- Solsten
	97202,  -- Olmyr the Enlightened
	96640,  -- Valarjar Marksman
	99891,  -- Storm Drake
	96609,  -- Gildedfur Stag
	96611,  -- Angerhoof Bull
	96934,  -- Valarjar Trapper
	97083,  -- King Ranulf
	95843,  -- King Haldor
	97084,  -- King Tor
	97081   -- King Bjorn
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.mug_of_mead = "Mug of Mead"
	L.valarjar_thundercaller = "Valarjar Thundercaller"
	L.storm_drake = "Storm Drake"
	L.stormforged_sentinel = "Stormforged Sentinel"
	L.valarjar_runecarver = "Valarjar Runecarver"
	L.valarjar_mystic = "Valarjar Mystic"
	L.valarjar_purifier = "Valarjar Purifier"
	L.valarjar_shieldmaiden = "Valarjar Shieldmaiden"
	L.valarjar_aspirant = "Valarjar Aspirant"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr the Enlightened"
	L.valarjar_marksman = "Valarjar Marksman"
	L.gildedfur_stag = "Gildedfur Stag"
	L.angerhoof_bull = "Angerhoof Bull"
	L.valarjar_trapper = "Valarjar Trapper"
	L.fourkings = "The Four Kings"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		-- General
		autotalk,
		-- Mug of Mead
		202298, -- Mug of Mead
		-- Valarjar Thundercaller
		{215430, "SAY", "FLASH"}, -- Thunderstrike
		-- Storm Drake
		198888, -- Lightning Breath
		198892, -- Crackling Storm
		-- Stormforged Sentinel
		210875, -- Charged Pulse
		{198745, "DISPEL"}, -- Protective Light
		{199805, "SAY"}, -- Crackle
		-- Valarjar Runecarver
		198959, -- Etch
		-- Valarjar Mystic
		198931, -- Healing Light (replaced by Holy Radiance in mythic difficulty)
		198934, -- Rune of Healing
		215433, -- Holy Radiance
		-- Valarjar Purifier
		192563, -- Cleansing Flames
		-- Valarjar Shieldmaiden
		199050, -- Mortal Hew
		-- Valarjar Aspirant
		191508, -- Blast of Light
		{199034, "SAY"}, -- Valkyra's Advance
		-- Solsten
		200901, -- Eye of the Storm
		-- Olmyr the Enlightened
		192158, -- Sanctify
		192288, -- Searing Light
		-- Valarjar Marksman
		199210, -- Penetrating Shot
		-- Gildedfur Stag
		199146, -- Bucking Charge
		-- Angerhoof Bull
		199090, -- Rumbling Stomp
		-- Valarjar Trapper
		199341, -- Bear Trap
		-- The Four Kings
		199726, -- Unruly Yell
		200969, -- Call Ancestor
	}, {
		[autotalk] = "general",
		[202298] = L.mug_of_mead,
		[215430] = L.valarjar_thundercaller,
		[198888] = L.storm_drake,
		[210875] = L.stormforged_sentinel,
		[198959] = L.valarjar_runecarver,
		[198931] = L.valarjar_mystic,
		[192563] = L.valarjar_purifier,
		[199050] = L.valarjar_shieldmaiden,
		[191508] = L.valarjar_aspirant,
		[200901] = L.solsten,
		[192158] = L.olmyr,
		[199210] = L.valarjar_marksman,
		[199146] = L.gildedfur_stag,
		[199090] = L.angerhoof_bull,
		[199341] = L.valarjar_trapper,
		[199726] = L.fourkings,
	}, {
		[198745] = CL.shield,
	}
end

function mod:OnBossEnable()
	-- General
	self:RegisterEvent("GOSSIP_SHOW")

	-- Mug of Mead
	self:Log("SPELL_AURA_APPLIED", "MugOfMeadApplied", 202298)
	self:Log("SPELL_AURA_REMOVED", "MugOfMeadRemoved", 202298)

	-- Valarjar Thundercaller
	self:Log("SPELL_AURA_APPLIED", "Thunderstrike", 215430)

	-- Storm Drake
	self:Log("SPELL_CAST_START", "LightningBreath", 198888)
	self:Log("SPELL_CAST_START", "CracklingStorm", 198892)
	self:Log("SPELL_AURA_APPLIED", "CracklingStormDamage", 198903)
	self:Log("SPELL_PERIODIC_DAMAGE", "CracklingStormDamage", 198903)
	self:Log("SPELL_PERIODIC_MISSED", "CracklingStormDamage", 198903)

	-- Valarjar Runecarver
	self:Log("SPELL_CAST_START", "Etch", 198959)

	-- Valarjar Mystic
	self:Log("SPELL_CAST_START", "HealingLight", 198931)
	self:Log("SPELL_CAST_START", "HolyRadiance", 215433)
	self:Log("SPELL_CAST_START", "RuneOfHealing", 198934)

	-- Valarjar Purifier
	self:Log("SPELL_CAST_START", "CleansingFlames", 192563)

	-- Stormforged Sentinel
	self:Log("SPELL_CAST_START", "ChargedPulse", 210875)
	self:Log("SPELL_AURA_APPLIED", "ProtectiveLight", 198745)
	self:Log("SPELL_CAST_START", "Crackle", 199805)
	self:Log("SPELL_AURA_APPLIED", "CrackleDamage", 199818)
	self:Log("SPELL_PERIODIC_DAMAGE", "CrackleDamage", 199818)
	self:Log("SPELL_PERIODIC_MISSED", "CrackleDamage", 199818)

	-- Valarjar Shieldmaiden
	self:Log("SPELL_CAST_START", "MortalHew", 199050)

	-- Valarjar Aspirant
	self:Log("SPELL_CAST_START", "BlastOfLight", 191508)
	self:Log("SPELL_CAST_START", "ValkyrasAdvance", 199034)

	-- Solsten
	self:Log("SPELL_CAST_START", "EyeOfTheStorm", 200901)

	-- Olmyr the Enlightened
	self:Log("SPELL_CAST_START", "Sanctify", 192158)
	self:Log("SPELL_CAST_START", "SearingLight", 192288)

	-- Valarjar Marksman
	self:Log("SPELL_CAST_START", "PenetratingShot", 199210)

	-- Gildedfur Stag
	self:Log("SPELL_CAST_START", "BuckingCharge", 199146)

	-- Angerhoof Bull
	self:Log("SPELL_CAST_START", "RumblingStomp", 199090)

	-- Valarjar Trapper
	self:Log("SPELL_CAST_START", "BearTrap", 199341)

	-- The Four Kings
	self:Log("SPELL_CAST_START", "UnrulyYell", 199726)
	self:Log("SPELL_CAST_SUCCESS", "CallAncestor", 200969)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(44755) then
			-- King Ranulf, begin combat
			self:SelectGossipID(44755)
		elseif self:GetGossipID(44801) then
			-- King Haldor, begin combat
			self:SelectGossipID(44801)
		elseif self:GetGossipID(44802) then
			-- King Bjorn, begin combat
			self:SelectGossipID(44802)
		elseif self:GetGossipID(44754) then
			-- King Tor, begin combat
			self:SelectGossipID(44754)
		end
	end
end

-- Mug of Mead

function mod:MugOfMeadApplied(args)
	self:TargetBar(args.spellId, 20, args.destName)
end

function mod:MugOfMeadRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

-- Valarjar Thundercaller

function mod:Thunderstrike(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:TargetBar(args.spellId, 3, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId, nil, nil, "Thunderstrike")
	end
end

-- Storm Drake

function mod:LightningBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(198892, "red", name)
		self:PlaySound(198892, "alert", nil, name)
	end
	function mod:CracklingStorm(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:CracklingStormDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(198892, "near")
				self:PlaySound(198892, "underyou")
			end
		end
	end
end

-- Valarjar Runecarver

do
	local prev = 0
	function mod:Etch(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Valarjar Mystic

function mod:HealingLight(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:HolyRadiance(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

function mod:RuneOfHealing(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Valarjar Purifier

function mod:CleansingFlames(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Stormforged Sentinel

function mod:ChargedPulse(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ProtectiveLight(args)
	if not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.on:format(CL.shield, args.sourceName))
		if self:Dispeller("magic", true, args.spellId) then
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local function printTarget(self, _, guid)
		if self:Me(guid) then
			self:PersonalMessage(199805)
			self:PlaySound(199805, "alarm")
			self:Say(199805, nil, nil, "Crackle")
		end
	end
	function mod:Crackle(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:CrackleDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(199805, "underyou")
				self:PlaySound(199805, "underyou")
			end
		end
	end
end

-- Valarjar Shieldmaiden

do
	local prev = 0
	function mod:MortalHew(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Valarjar Aspirant

function mod:BlastOfLight(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(199034, "yellow", name)
		self:PlaySound(199034, "alert", nil, name)
		if self:Me(guid) then
			self:Say(199034, nil, nil, "Valkyra's Advance")
		end
	end
	function mod:ValkyrasAdvance(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

-- Solsten

function mod:EyeOfTheStorm(args)
	if self:MobId(args.sourceGUID) == 97219 then -- Solsten
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "long")
	end
end

-- Olmyr the Enlightened

function mod:Sanctify(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end

function mod:SearingLight(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Valarjar Marksman

function mod:PenetratingShot(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Gildedfur Stag

function mod:BuckingCharge(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Angerhoof Bull

function mod:RumblingStomp(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Valarjar Trapper

function mod:BearTrap(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- The Four Kings

function mod:UnrulyYell(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:CallAncestor(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
