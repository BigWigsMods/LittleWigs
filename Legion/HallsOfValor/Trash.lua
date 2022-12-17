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
	97202,  -- Olmyr the Enlightened
	96640,  -- Valarjar Marksman
	99891,  -- Storm Drake
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
	L.olmyr = "Olmyr the Enlightened"
	L.marksman = "Valarjar Marksman"
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
		{199805, "SAY"}, -- Crackle
		{198745, "DISPEL"}, -- Protective Light
		-- Valarjar Mystic
		198931, -- Healing Light (replaced by Holy Radiance in mythic difficulty)
		198934, -- Rune of Healing
		215433, -- Holy Radiance
		-- Valarjar Purifier
		192563, -- Cleansing Flames
		-- Valarjar Shieldmaiden
		-- Valarjar Aspirant
		191508, -- Blast of Light
		-- Olmyr the Enlightened
		192158, -- Sanctify
		-- Valarjar Marksman
		199210, -- Penetrating Shot
		-- Valarjar Trapper
		199341, -- Bear Trap
		-- The Four Kings
		199726, -- Unruly Yell
	}, {
		["custom_on_autotalk"] = "general",
		[215430] = L.thundercaller,
		[198888] = L.drake,
		[210875] = L.sentinel,
		[198931] = L.mystic,
		[192563] = L.purifier,
		[191508] = L.aspirant,
		[192158] = L.olmyr,
		[199210] = L.marksman,
		[199341] = L.trapper,
		[199726] = L.fourkings,
	}
end

function mod:OnBossEnable()
	-- Cleansing Flames, Unruly Yell, Sanctify, Blast of Light, Healing Light, Rune of Healing, Holy Radiance, Lightning Breath, Penetrating Shot, Bear Trap, Charged Pulse
	self:Log("SPELL_CAST_START", "Casts", 192563, 199726, 192158, 191508, 198931, 198934, 215433, 198888, 199210, 199341, 210875)

	--[[ Stormforged Sentinel ]]--
	self:Log("SPELL_CAST_START", "CrackleCast", 199805)
	self:Log("SPELL_AURA_APPLIED", "GroundEffectDamage", 199818) -- Crackle
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 199818)
	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 199818)
	self:Log("SPELL_AURA_APPLIED", "ProtectiveShield", 198745)

	self:Log("SPELL_AURA_APPLIED", "Thunderstrike", 215430)
	self:Log("SPELL_AURA_REMOVED", "ThunderstrikeRemoved", 215430)

	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Casts(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, _, guid)
		if self:Me(guid) then
			self:Message(199805, "orange", CL.you:format(self:SpellName(199805)))
			self:PlaySound(199805, "warning")
			self:Say(199805)
		end
	end

	function mod:CrackleCast(args)
		self:GetUnitTarget(printTarget, 0.5, args.sourceGUID)
	end
end

function mod:ProtectiveShield(args)
	self:Message(args.spellId, "yellow", CL.on:format(self:SpellName(182405), args.sourceName)) -- Shield
	if self:Dispeller("magic", true, args.spellId) then
		self:PlaySound(args.spellId, "info")
	end
end

function mod:Thunderstrike(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
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

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(199805, "blue", CL.underyou:format(args.spellName))
				self:PlaySound(199805, "alert")
			end
		end
	end
end

do
	local autoTalk = {
		[97081] = true, -- King Bjorn
		[95843] = true, -- King Haldor
		[97083] = true, -- King Ranulf
		[97084] = true, -- King Tor
	}

	function mod:GOSSIP_SHOW()
		local mobId = self:MobId(self:UnitGUID("npc"))
		if self:GetOption("custom_on_autotalk") and autoTalk[mobId] then
			if self:GetGossipOptions() then
				self:SelectGossipOption(1)
			end
		end
	end
end
