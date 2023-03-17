--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharions Lair Trash", 1458)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
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
	L.rockbound_trapper = "Rockbound Trapper"
	L.emberhusk_dominator = "Emberhusk Dominator"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Tarspitter Lurker
		183465, -- Viscid Bile
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
		-- Rockbound Trapper
		193585, -- Bound
		-- Emberhusk Dominator
		226406, -- Ember Swipe
		{201983, "DISPEL"}, -- Frenzy
	}, {
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
		[193585] = L.rockbound_trapper,
		[226406] = L.emberhusk_dominator,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Tarspitter Lurker
	self:Log("SPELL_CAST_START", "ViscidBile", 183465)

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
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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

-- Rockbound Trapper

function mod:Bound(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Emberhusk Dominator

function mod:EmberSwipe(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:FrenzyApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end
