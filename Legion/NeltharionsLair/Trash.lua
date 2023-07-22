--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharions Lair Trash", 1458)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	96247,  -- Vileshard Crawler
	91001,  -- Tarspitter Lurker
	91006,  -- Rockback Gnasher
	91000,  -- Vileshard Hulk
	101438, -- Vileshard Chunk
	92610,  -- Understone Drummer
	113998, -- Mightstone Breaker
	90997,  -- Mightstone Breaker
	92612,  -- Mightstone Breaker
	113538, -- Mightstone Breaker
	90998,  -- Blightshard Shaper
	94224,  -- Petrifying Totem
	94331,  -- Petrifying Crystal
	102404, -- Stoneclaw Grubmaster
	92538,  -- Tarspitter Grub
	91002,  -- Rotdrool Grabber
	102253, -- Understone Demolisher
	102232, -- Rockbound Trapper
	113537, -- Emberhusk Dominator
	102287  -- Emberhusk Dominator
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rokmora_first_warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	L.rokmora_second_warmup_trigger = "Either way, I will enjoy every moment of it. Rokmora, crush them!"

	L.vileshard_crawler = "Vileshard Crawler"
	L.tarspitter_lurker = "Tarspitter Lurker"
	L.rockback_gnasher = "Rockback Gnasher"
	L.vileshard_hulk = "Vileshard Hulk"
	L.vileshard_chunk = "Vileshard Chunk"
	L.understone_drummer = "Understone Drummer"
	L.mightstone_breaker = "Mightstone Breaker"
	L.blightshard_shaper = "Blightshard Shaper"
	L.stoneclaw_grubmaster = "Stoneclaw Grubmaster"
	L.tarspitter_grub = "Tarspitter Grub"
	L.rotdrool_grabber = "Rotdrool Grabber"
	L.understone_demolisher = "Understone Demolisher"
	L.rockbound_trapper = "Rockbound Trapper"
	L.emberhusk_dominator = "Emberhusk Dominator"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Vileshard Crawler
		183407, -- Acid Splatter
		-- Tarspitter Lurker
		183465, -- Viscid Bile
		226388, -- Rancid Ooze
		-- Rockback Gnasher
		202181, -- Stone Gaze
		-- Vileshard Hulk
		226296, -- Piercing Shards
		{193505, "TANK_HEALER"}, -- Fracture
		-- Vileshard Chunk
		226287, -- Crush
		-- Understone Drummer
		183526, -- War Drums
		-- Mightstone Breaker
		183088, -- Avalanche
		-- Blightshard Shaper
		202108, -- Petrifying Totem
		186576, -- Petrifying Cloud
		186616, -- Petrified
		-- Stoneclaw Grubmaster
		183548, -- Worm Call
		-- Tarspitter Grub
		193803, -- Metamorphosis
		-- Rotdrool Grabber
		183539, -- Barbed Tongue
		-- Understone Demolisher
		188587, -- Charskin
		{200154, "ME_ONLY"}, -- Burning Hatred
		-- Rockbound Trapper
		193585, -- Bound
		-- Emberhusk Dominator
		226406, -- Ember Swipe
		{201983, "DISPEL"}, -- Frenzy
	}, {
		[183407] = L.vileshard_crawler,
		[183465] = L.tarspitter_lurker,
		[202181] = L.rockback_gnasher,
		[226296] = L.vileshard_hulk,
		[226287] = L.vileshard_chunk,
		[183526] = L.understone_drummer,
		[183088] = L.mightstone_breaker,
		[202108] = L.blightshard_shaper,
		[183548] = L.stoneclaw_grubmaster,
		[193803] = L.tarspitter_grub,
		[183539] = L.rotdrool_grabber,
		[188587] = L.understone_demolisher,
		[193585] = L.rockbound_trapper,
		[226406] = L.emberhusk_dominator,
	}, {
		[200154] = CL.fixate,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Vileshard Crawler
	self:Log("SPELL_AURA_APPLIED", "AcidSplatterDamage", 183407)
	self:Log("SPELL_PERIODIC_DAMAGE", "AcidSplatterDamage", 183407)

	-- Tarspitter Lurker
	self:Log("SPELL_CAST_START", "ViscidBile", 183465)
	self:Log("SPELL_AURA_APPLIED", "RancidOozeDamage", 226388)
	self:Log("SPELL_PERIODIC_DAMAGE", "RancidOozeDamage", 226388)

	-- Rockback Gnasher
	self:Log("SPELL_CAST_START", "StoneGaze", 202181)
	self:Log("SPELL_AURA_APPLIED", "StoneGazeApplied", 202181)

	-- Vileshard Hulk
	self:Log("SPELL_CAST_START", "PiercingShards", 226296)
	self:Log("SPELL_CAST_START", "Fracture", 193505)

	-- Vileshard Chunk
	self:Log("SPELL_CAST_START", "Crush", 226287)

	-- Understone Drummer
	self:Log("SPELL_AURA_APPLIED", "WarDrums", 183526)

	-- Mightstone Breaker
	self:Log("SPELL_CAST_START", "Avalanche", 183088)

	-- Blightshard Shaper
	self:Log("SPELL_CAST_START", "PetrifyingTotem", 202108)
	self:Log("SPELL_AURA_APPLIED", "PetrifyingCloudApplied", 186576)
	self:Log("SPELL_AURA_APPLIED", "PetrifiedApplied", 186616)

	-- Stoneclaw Grubmaster
	self:Log("SPELL_CAST_START", "WormCall", 183548)

	-- Tarspitter Grub
	self:Log("SPELL_AURA_APPLIED", "Metamorphosis", 193803)

	-- Rotdrool Grabber
	self:Log("SPELL_CAST_START", "BarbedTongue", 183539)

	-- Understone Demolisher
	self:Log("SPELL_CAST_START", "Charskin", 188587)
	self:Log("SPELL_CAST_START", "BurningHatred", 200154)
	self:Log("SPELL_AURA_APPLIED", "BurningHatredApplied", 200154)

	-- Rockbound Trapper
	self:Log("SPELL_CAST_START", "Bound", 193585)

	-- Emberhusk Dominator
	self:Log("SPELL_CAST_START", "EmberSwipe", 226406)
	self:Log("SPELL_AURA_APPLIED", "FrenzyApplied", 201983)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.rokmora_first_warmup_trigger then
		-- Rokmora 1st line warmup
		self:UnregisterEvent(event)
		local rokmoraModule = BigWigs:GetBossModule("Rokmora", true)
		if rokmoraModule then
			rokmoraModule:Enable()
			rokmoraModule:WarmupLong()
		end
	elseif msg == L.rokmora_second_warmup_trigger then
		-- Rokmora 2nd line warmup
		self:UnregisterEvent(event)
		local rokmoraModule = BigWigs:GetBossModule("Rokmora", true)
		if rokmoraModule then
			rokmoraModule:Enable()
			rokmoraModule:WarmupShort()
		end
	end
end

-- Vileshard Crawler

do
	local prev = 0
	function mod:AcidSplatterDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Tarspitter Lurker

do
	local prev = 0
	function mod:ViscidBile(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:RancidOozeDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Rockback Gnasher

function mod:StoneGaze(args)
	-- this is only cast when there's a Stoneclaw Hunter nearby to use Kill Command
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:StoneGazeApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Vileshard Hulk

function mod:PiercingShards(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Fracture(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

-- Vileshard Chunk

function mod:Crush(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Understone Drummer

function mod:WarDrums(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

-- Mightstone Breaker

function mod:Avalanche(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Blightshard Shaper

function mod:PetrifyingTotem(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:PetrifyingCloudApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:PetrifiedApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	else
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

-- Stoneclaw Grubmaster

function mod:WormCall(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Tarspitter Grub

function mod:Metamorphosis(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Rotdrool Grabber

function mod:BarbedTongue(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Understone Demolisher

function mod:Charskin(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:BurningHatred(args)
	if self:MobId(args.sourceGUID) ~= 101476 then -- Molten Charskin, Dargrul's summon
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:BurningHatredApplied(args)
	local onMe = self:Me(args.destGUID)
	if self:MobId(args.sourceGUID) == 101476 -- Molten Charskin, Dargrul's summon
		or (onMe and self:Tank()) then
		-- Dargrul's adds cast this too, filter those mobs out
		-- tanks don't care about being fixated
		return
	end
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
	if onMe then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Rockbound Trapper

function mod:Bound(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Emberhusk Dominator

function mod:EmberSwipe(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:FrenzyApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end
