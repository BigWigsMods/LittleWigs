--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Throne of the Tides Trash", 643)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	41096,  -- Naz'jar Oracle
	41139,  -- Naz'jar Spiritmender
	212681, -- Vicious Snap Dragon
	40577,  -- Naz'jar Sentinel
	212673, -- Naz'jar Ravager
	40634,  -- Naz'jar Tempest Witch
	212775, -- Faceless Seer
	40936,  -- Faceless Watcher
	40925   -- Tainted Sentry
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nazjar_oracle = "Naz'jar Oracle"
	L.vicious_snap_dragon = "Vicious Snap Dragon"
	L.nazjar_sentinel = "Naz'jar Sentinel"
	L.nazjar_ravager = "Naz'jar Ravager"
	L.nazjar_tempest_witch = "Naz'jar Tempest Witch"
	L.faceless_seer = "Faceless Seer"
	L.faceless_watcher = "Faceless Watcher"
	L.tainted_sentry = "Tainted Sentry"

	L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Naz'jar Oracle
		{76820, "DISPEL"}, -- Hex
		76813, -- Healing Wave
		-- Vicious Snap Dragon
		{426663, "ME_ONLY"}, -- Ravenous Pursuit
		-- Naz'jar Sentinel
		{426741, "TANK_HEALER"}, -- Shellbreaker
		428542, -- Crushing Depths
		-- Naz'jar Ravager
		426684, -- Volatile Bolt
		426645, -- Acid Barrage
		-- Naz'jar Tempest Witch
		{75992, "SAY"}, -- Lightning Surge
		-- Faceless Seer
		426783, -- Mind Flay
		426808, -- Null Blast
		-- Faceless Watcher
		76590, -- Shadow Smash
		{429021, "TANK", "OFF"}, -- Crush
		-- Tainted Sentry
		76634, -- Swell
	}, {
		[76820] = L.nazjar_oracle,
		[426663] = L.vicious_snap_dragon,
		[426741] = L.nazjar_sentinel,
		[426684] = L.nazjar_ravager,
		[75992] = L.nazjar_tempest_witch,
		[426783] = L.faceless_seer,
		[76590] = L.faceless_watcher,
		[76634] = L.tainted_sentry,
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		-- Warmups
		self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	end

	-- Naz'jar Oracle
	self:Log("SPELL_CAST_START", "Hex", 76820)
	self:Log("SPELL_AURA_APPLIED", "HexApplied", 76820)
	self:Log("SPELL_CAST_START", "HealingWave", 76813)

	if self:Retail() then
		-- Vicious Snap Dragon
		self:Log("SPELL_AURA_APPLIED", "RavenousPursuitApplied", 426663)

		-- Naz'jar Sentinel
		self:Log("SPELL_CAST_START", "Shellbreaker", 426741)
		self:Log("SPELL_AURA_APPLIED", "CrushingDepthsApplied", 428542)

		-- Naz'jar Ravager
		self:Log("SPELL_CAST_START", "VolatileBolt", 426684)
		self:Log("SPELL_CAST_START", "AcidBarrage", 426645)
	end

	-- Naz'jar Tempest Witch
	self:Log("SPELL_AURA_APPLIED", "LightningSurgeApplied", 75992)

	if self:Retail() then
		-- Faceless Seer
		self:Log("SPELL_CAST_START", "MindFlay", 426783)
		self:Log("SPELL_CAST_START", "NullBlast", 426808)
	end

	-- Faceless Watcher
	self:Log("SPELL_CAST_START", "ShadowSmash", 76590)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "Crush", 429021)
	end

	-- Tainted Sentry
	self:Log("SPELL_CAST_START", "Swell", 76634)
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			-- Naz'jar Oracle
			{76820, "DISPEL"}, -- Hex
			76813, -- Healing Wave
			-- Naz'jar Tempest Witch
			{75992, "SAY"}, -- Lightning Surge
			-- Faceless Watcher
			76590, -- Shadow Smash
			-- Tainted Sentry
			76634, -- Swell
		}, {
			[76820] = L.nazjar_oracle,
			[75992] = L.nazjar_tempest_witch,
			[76590] = L.faceless_watcher,
			[76634] = L.tainted_sentry,
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.ozumat_warmup_trigger then
		-- Ozumat warmup
		local ozumatModule = BigWigs:GetBossModule("Ozumat", true)
		if ozumatModule then
			ozumatModule:Enable()
			ozumatModule:Warmup()
		end
	end
end

-- Naz'jar Oracle

function mod:Hex(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 20.7, args.sourceGUID)
end

function mod:HexApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:HealingWave(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 3.6, args.sourceGUID)
end

-- Vicious Snap Dragon

function mod:RavenousPursuitApplied(args)
	local onMe = self:Me(args.destGUID)
	if onMe and self:Tank() then
		-- tanks don't care about being fixated
		return
	end
	self:TargetMessage(args.spellId, "red", args.destName)
	if onMe then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Naz'jar Sentinel

do
	local prev = 0
	function mod:Shellbreaker(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
			--self:NameplateCDBar(args.spellId, 18.2, args.sourceGUID)
		end
	end
end

function mod:CrushingDepthsApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

-- Naz'jar Ravager

function mod:VolatileBolt(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 21.9, args.sourceGUID)
end

function mod:AcidBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 10.9, args.sourceGUID)
end

-- Naz'jar Tempest Witch

function mod:LightningSurgeApplied(args)
	local onMe = self:Me(args.destGUID)
	-- don't alert if a NPC is debuffed (usually by a mind-controlled mob)
	if onMe or (self:Player(args.destFlags) and self:Dispeller("magic", nil, args.spellId)) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		if onMe then
			self:Say(args.spellId, nil, nil, "Lightning Surge")
		end
	end
	-- if this is uncommented, move to SPELL_CAST_SUCCESS
	--self:NameplateCDBar(args.spellId, 19.4, args.sourceGUID)
end

-- Faceless Seer

do
	local prev = 0
	function mod:MindFlay(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 8.5, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:NullBlast(args)
		-- these NPCs can be mind-controlled by Priests and this ability can be cast,
		-- but don't suppress alerts as the ability still only harms players.
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 10.9, args.sourceGUID)
	end
end

-- Faceless Watcher

function mod:ShadowSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 24.3, args.sourceGUID)
end

function mod:Crush(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 17.0, args.sourceGUID)
end

-- Tainted Sentry

function mod:Swell(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 20.6, args.sourceGUID)
end
