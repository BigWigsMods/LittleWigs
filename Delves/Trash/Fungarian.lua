if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fungarian Delve Trash", {2664, 2679}) -- Fungal Folly, Mycomancer Cavern
if not mod then return end
mod:RegisterEnableMob(
	210677, -- Stoneguard Benston (Fungal Folly gossip NPC)
	220293, -- Aliya Hillhelm (Mycomancer Cavern gossip NPC)
	219779, -- Alekk (Mycomancer Cavern gossip NPC)
	213434, -- Sporbit
	225708, -- Sporbit (Bogpiper summon)
	207456, -- Fungal Speartender
	207468, -- Gnarled Reviver
	210478, -- Infected Beast
	207454, -- Fungal Gutter
	207460, -- Fungarian Flinger
	220432 -- Particularly Bad Guy
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.fungarian_trash = "Fungarian Trash"

	L.sporbit = "Sporbit"
	L.fungal_speartender = "Fungal Speartender"
	L.gnarled_reviver = "Gnarled Reviver"
	L.infected_beast = "Infected Beast"
	L.fungal_gutter = "Fungal Gutter"
	L.fungarian_flinger = "Fungarian Flinger"
	L.particularly_bad_guy = "Particularly Bad Guy"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.fungarian_trash
end

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Sporbit
		427710, -- Sporesplosion
		-- Fungal Speartender
		414944, -- Battle Roar
		424891, -- Vine Spear
		-- Gnarled Reviver
		424773, -- Sporogenesis
		-- Infected Beast
		424798, -- Bloated Eruption
		-- Fungal Gutter
		424704, -- Vicious Stabs
		-- Fungarian Flinger
		425040, -- Rotwave Volley
		425042, -- Sporewave
		-- Particularly Bad Guy
		372529, -- Hideous Laughter
	}, {
		[427710] = L.sporbit,
		[414944] = L.fungal_speartender,
		[424773] = L.gnarled_reviver,
		[424798] = L.infected_beast,
		[424704] = L.fungal_gutter,
		[425040] = L.fungarian_flinger,
		[372529] = L.particularly_bad_guy,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Sporbit
	self:Log("SPELL_CAST_START", "Sporespolosion", 427710)

	-- Fungal Speartender
	self:Log("SPELL_CAST_START", "BattleRoar", 414944)
	self:Log("SPELL_CAST_START", "VineSpear", 424891)

	-- Gnarled Reviver
	self:Log("SPELL_CAST_START", "Sporogenesis", 424773)

	-- Infected Beast
	self:Log("SPELL_CAST_START", "BloatedEruption", 424798)

	-- Fungal Gutter
	self:Log("SPELL_CAST_START", "ViciousStabs", 424704)

	-- Fungarian Flinger
	self:Log("SPELL_CAST_START", "RotwaveVolley", 425040)
	self:Log("SPELL_CAST_START", "Sporewave", 425042)

	-- Particularly Bad Guy
	self:Log("SPELL_CAST_START", "HideousLaughter", 372529)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(111366) then -- Fungal Folly, start Delve (Stoneguard Benston)
			-- 111366:I'll dive into this cavern and get your friends back.
			self:SelectGossipID(111366)
		elseif self:GetGossipID(121536) then -- Mycomancer Cavern, start Delve (Aliya Hillhelm)
			-- 121536:|cFF0000FF(Delve)|r I'll get your pigs back and make those fungarians pay for this.
			self:SelectGossipID(121536)
		elseif self:GetGossipID(122875) then -- Mycomancer Cavern, continue Delve (Magni? / Brann)
			-- 122875:|cFF0000FF(Delve)|r Right. Magni. Let's go save Azeroth after we handle some mushrooms.
			self:SelectGossipID(122875)
		elseif self:GetGossipID(121493) then -- Mycomancer Cavern, continue Delve (Alekk)
			-- 121493:|cFF0000FF(Delve)|r This is definitely real, and I will of course help a talking pink elekk named Alekk.
			self:SelectGossipID(121493)
		elseif self:GetGossipID(121564) then -- Mycomancer Cavern, continue Delve (Alekk)
			-- 121564:|cFF0000FF(Delve)|r Goodbye, elekk ten. I'll always remember this.
			self:SelectGossipID(121564)
		end
	end
end

-- Sporbit

do
	local prev = 0
	function mod:Sporespolosion(args)
		local t = args.time
		if t - prev > 2.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Fungal Speartender

function mod:BattleRoar(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:VineSpear(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Gnarled Reviver

function mod:Sporogenesis(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Infected Beast

function mod:BloatedEruption(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Fungal Gutter

function mod:ViciousStabs(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Fungarian Flinger

function mod:RotwaveVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:Sporewave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Particularly Bad Guy

function mod:HideousLaughter(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
