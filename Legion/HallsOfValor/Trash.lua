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
	95834,  -- Valarjar Mystic
	97197,  -- Valarjar Purifier
	95832,  -- Valarjar Shieldmaiden
	101639, -- Valarjar Shieldmaiden
	101637, -- Valarjar Aspirant
	97219,  -- Solsten
	97202,  -- Olmyr the Enlightened
	96640,  -- Valarjar Marksman
	99891,  -- Storm Drake
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
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects various gossip options around the dungeon."

	L.thundercaller = "Valarjar Thundercaller"
	L.drake = "Storm Drake"
	L.sentinel = "Stormforged Sentinel"
	L.mystic = "Valarjar Mystic"
	L.purifier = "Valarjar Purifier"
	L.shieldmaiden = "Valarjar Shieldmaiden"
	L.aspirant = "Valarjar Aspirant"
	L.solsten = "Solsten"
	L.olmyr = "Olmyr the Enlightened"
	L.marksman = "Valarjar Marksman"
	L.angerhoof = "Angerhoof Bull"
	L.trapper = "Valarjar Trapper"
	L.fourkings = "The Four Kings"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"custom_on_autotalk",
		-- Valarjar Thundercaller
		{215430, "SAY", "FLASH", "PROXIMITY"}, -- Thunderstrike
		-- Storm Drake
		198888, -- Lightning Breath
		-- Stormforged Sentinel
		210875, -- Charged Pulse
		{198745, "DISPEL"}, -- Protective Light
		{199805, "SAY"}, -- Crackle
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
		-- Solsten
		200901, -- Eye of the Storm
		-- Olmyr the Enlightened
		192158, -- Sanctify
		-- Valarjar Marksman
		199210, -- Penetrating Shot
		-- Angerhoof Bull
		199090, -- Rumbling Stomp
		-- Valarjar Trapper
		199341, -- Bear Trap
		-- The Four Kings
		199726, -- Unruly Yell
		200969, -- Call Ancestor
	}, {
		["custom_on_autotalk"] = "general",
		[215430] = L.thundercaller,
		[198888] = L.drake,
		[210875] = L.sentinel,
		[198931] = L.mystic,
		[192563] = L.purifier,
		[199050] = L.shieldmaiden,
		[191508] = L.aspirant,
		[200901] = L.solsten,
		[192158] = L.olmyr,
		[199210] = L.marksman,
		[199090] = L.angerhoof,
		[199341] = L.trapper,
		[199726] = L.fourkings,
	}, {
		[198745] = CL.shield,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")

	-- Valarjar Thundercaller
	self:Log("SPELL_AURA_APPLIED", "Thunderstrike", 215430)
	self:Log("SPELL_AURA_REMOVED", "ThunderstrikeRemoved", 215430)

	-- Storm Drake
	self:Log("SPELL_CAST_START", "LightningBreath", 198888)

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

	-- Solsten
	self:Log("SPELL_CAST_START", "EyeOfTheStorm", 200901)

	-- Olmyr the Enlightened
	self:Log("SPELL_CAST_START", "Sanctify", 192158)

	-- Valarjar Marksman
	self:Log("SPELL_CAST_START", "PenetratingShot", 199210)

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

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(44755) then
			-- King Ranulf
			self:SelectGossipID(44755)
		elseif self:GetGossipID(44801) then
			-- King Haldor
			self:SelectGossipID(44801)
		elseif self:GetGossipID(44802) then
			-- King Bjorn
			self:SelectGossipID(44802)
		elseif self:GetGossipID(44754) then
			-- King Tor
			self:SelectGossipID(44754)
		end
	end
end

-- Valarjar Thundercaller

function mod:Thunderstrike(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:TargetBar(args.spellId, 3, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:Say(args.spellId)
		self:OpenProximity(args.spellId, 8)
	end
end

function mod:ThunderstrikeRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
	end
end

-- Storm Drake

function mod:LightningBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Valarjar Mystic

function mod:HealingLight(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:HolyRadiance(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:RuneOfHealing(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Valarjar Purifier

function mod:CleansingFlames(args)
	self:Message(args.spellId, "red")
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
			self:Say(199805)
		end
	end
	function mod:Crackle(args)
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
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

-- Valarjar Marksman

function mod:PenetratingShot(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Angerhoof Bull

function mod:RumblingStomp(args)
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
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:CallAncestor(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
