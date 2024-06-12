if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("City of Threads Trash", 2669)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	220196, -- Herald of Ansurek
	220195, -- Sureki Silkbinder
	220197, -- Royal Swarmguard
	219984, -- Xeph'itik
	220401, -- Pale Priest
	220003, -- Eye of the Queen
	223844 -- Covert Webmancer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.herald_of_ansurek = "Herald of Ansurek"
	L.sureki_silkbinder = "Sureki Silkbinder"
	L.royal_swarmguard = "Royal Swarmguard"
	L.xephitik = "Xeph'itik"
	L.pale_priest = "Pale Priest"
	L.eye_of_the_queen = "Eye of the Queen"
	L.covert_webmancer = "Covert Webmancer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Herald of Ansurek
		443437, -- Shadows of Doubt
		-- Sureki Silkbinder
		443430, -- Silk Binding
		-- Royal Swarmguard
		443500, -- Earthshatter
		-- Xeph'itik
		450784, -- Perfume Toss
		451423, -- Gossamer Barrage
		-- Pale Priest
		442653, -- What's That?
		448047, -- Web Wrap
		-- Eye of the Queen
		451543, -- Null Slam
		-- Covert Webmancer
		452162, -- Mending Web
	}, {
		[443437] = L.herald_of_ansurek,
		[443430] = L.sureki_silkbinder,
		[443500] = L.royal_swarmguard,
		[450784] = L.xephitik,
		[442653] = L.pale_priest,
		[451543] = L.eye_of_the_queen,
		[452162] = L.covert_webmancer,
	}
end

function mod:OnBossEnable()
	-- Herald of Ansurek
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfDoubtApplied", 443437)

	-- Sureki Silkbinder
	self:Log("SPELL_CAST_START", "SilkBinding", 443430)

	-- Royal Swarmguard
	self:Log("SPELL_CAST_START", "Earthshatter", 443500)

	-- Xeph'itik
	self:Log("SPELL_CAST_START", "PerfumeToss", 450784)
	self:Log("SPELL_CAST_START", "GossamerBarrage", 451423)
	self:Log("SPELL_CAST_SUCCESS", "PheromoneVeil", 441795)

	-- Pale Priest
	self:Log("SPELL_CAST_START", "WhatsThat", 442653)
	self:Log("SPELL_AURA_APPLIED", "WebWrap", 448047)

	-- Eye of the Queen
	self:Log("SPELL_CAST_START", "NullSlam", 451543)

	-- Covert Webmancer
	self:Log("SPELL_CAST_START", "MendingWeb", 452162)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Herald of Ansurek

function mod:ShadowsOfDoubtApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

-- Sureki Silkbinder

function mod:SilkBinding(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Royal Swarmguard

function mod:Earthshatter(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Xeph'itik

function mod:PerfumeToss(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.8)
end

function mod:GossamerBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 23.1)
end

function mod:PheromoneVeil(args)
	-- TODO could clean up bars a little earlier with [CHAT_MSG_MONSTER_YELL] Enough!#Xeph'itik
	self:StopBar(450784) -- Perfume Toss
	self:StopBar(451423) -- Gossamer Barrage
end

-- Pale Priest

function mod:WhatsThat(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:WebWrap(args)
		self:TargetMessage(args.spellId, "cyan", args.destName)
		local t = args.time
		if t - prev > 1.5 then
			-- just a short sound throttle in case the whole group gets caught at once
			prev = t
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

-- Eye of the Queen

function mod:NullSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Covert Webmender

function mod:MendingWeb(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
