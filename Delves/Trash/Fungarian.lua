--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fungarian Delve Trash", {2664, 2679}) -- Fungal Folly, Mycomancer Cavern
if not mod then return end
mod:RegisterEnableMob(
	210677, -- Stoneguard Benston (Fungal Folly gossip NPC)
	211061, -- Patreux (Fungal Folly gossip NPC)
	211060, -- One Tusk (Fungal Folly gossip NPC)
	211027, -- Kasthrik (Fungal Folly gossip NPC)
	211028, -- Twizzle Runabout (Fungal Folly gossip NPC)
	211062, -- Bill (Fungal Folly gossip NPC)
	220293, -- Aliya Hillhelm (Mycomancer Cavern gossip NPC)
	219779, -- Alekk (Mycomancer Cavern gossip NPC)
	220354, -- Chief Dinaire (Mycomancer Cavern gossip NPC)
	213434, -- Sporbit
	225708, -- Sporbit (Bogpiper summon)
	207456, -- Fungal Speartender
	207468, -- Gnarled Reviver
	210478, -- Infected Beast
	207454, -- Fungal Gutter
	207460, -- Fungarian Flinger
	207459, -- Fungal Rotcaster
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
	L.fungal_rotcaster = "Fungal Rotcaster"
	L.particularly_bad_guy = "Particularly Bad Guy"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.fungarian_trash
	self:SetSpellRename(414944, CL.roar) -- Battle Roar (Roar)
	self:SetSpellRename(424798, CL.explosion) -- Bloated Eruption (Explosion)
	self:SetSpellRename(424704, CL.frontal_cone) -- Vicious Stabs (Frontal Cone)
	self:SetSpellRename(372529, CL.fear) -- Hideous Laughter (Fear)
end

local autotalk = mod:AddAutoTalkOption(false)
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
		-- Fungal Rotcaster
		{424750, "DISPEL"}, -- Infectious Spores
		-- Particularly Bad Guy
		372529, -- Hideous Laughter
	},{
		[427710] = L.sporbit,
		[414944] = L.fungal_speartender,
		[424773] = L.gnarled_reviver,
		[424798] = L.infected_beast,
		[424704] = L.fungal_gutter,
		[425040] = L.fungarian_flinger,
		[372529] = L.particularly_bad_guy,
	},{
		[414944] = CL.roar, -- Battle Roar (Roar)
		[424798] = CL.explosion, -- Bloated Eruption (Explosion)
		[424704] = CL.frontal_cone, -- Vicious Stabs (Frontal Cone)
		[372529] = CL.fear, -- Hideous Laughter (Fear)
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

	-- Fungal Rotcaster
	self:Log("SPELL_CAST_START", "InfectiousSpores", 424750)
	self:Log("SPELL_AURA_APPLIED", "InfectiousSporesApplied", 424738)

	-- Particularly Bad Guy
	self:Log("SPELL_CAST_START", "HideousLaughter", 372529)

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Delve Rares", true)
	if raresModule then
		raresModule:Enable()
	end
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
		elseif self:GetGossipID(113928) then -- Fungal Folly, continue Delve (Patreux)
			-- 113928:|cFF0000FF(Delve)|r I accept your challenge!
			self:SelectGossipID(113928)
		elseif self:GetGossipID(113929) then -- Fungal Folly, continue Delve (One Tusk)
			-- 113929:|cFF0000FF(Delve)|r I'm ready to face whatever challenge you have.
			self:SelectGossipID(113929)
		elseif self:GetGossipID(113937) then -- Fungal Folly, continue Delve (Kasthrik)
			-- 113937:|cFF0000FF(Delve)|r I'm up for your challenge!
			self:SelectGossipID(113937)
		elseif self:GetGossipID(113939) then -- Fungal Folly, continue Delve (Twizzle Runabout)
			-- 113939:|cFF0000FF(Delve)|r Run in a specific circle on a time limit? Sure. This isn't the weirdest thing I've done today.
			self:SelectGossipID(113939)
		elseif self:GetGossipID(113941) then -- Fungal Folly, continue Delve (Bill)
			-- 113941:|cFF0000FF(Delve)|r I accept your challenge!
			self:SelectGossipID(113941)
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
		elseif self:GetGossipID(121539) then -- Mycomancer Cavern, start Delve (Chief Dinaire)
			-- 121539:|cFF0000FF(Delve)|r I love scavenger hunts AND treasure. I'm in!
			self:SelectGossipID(121539)
		elseif self:GetGossipID(121541) then -- Mycomancer Cavern, continue Delve (Chief Dinaire)
			-- 121541:|cFF0000FF(Delve)|r Go get the treasure while I handle whatever is about to attack us.
			self:SelectGossipID(121541)
		end
	end
end

-- Sporbit

do
	local prev = 0
	function mod:Sporespolosion(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		local t = args.time
		if t - prev > 2.5 and unit and self:UnitWithinRange(unit, 40) then -- cast while RP fighting, only alert if within range
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Fungal Speartender

function mod:BattleRoar(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and self:UnitWithinRange(unit, 40) then -- cast while RP fighting, only alert if within range
		self:Message(args.spellId, "red", CL.casting:format(CL.roar))
		self:PlaySound(args.spellId, "alert")
	end
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
	self:Message(args.spellId, "orange", CL.explosion)
	self:PlaySound(args.spellId, "alarm")
end

-- Fungal Gutter

function mod:ViciousStabs(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and self:UnitWithinRange(unit, 40) then -- cast while RP fighting, only alert if within range
		self:Message(args.spellId, "yellow", CL.frontal_cone)
		self:PlaySound(args.spellId, "alarm")
	end
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

-- Fungal Rotcaster

function mod:InfectiousSpores(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

function mod:InfectiousSporesApplied(args)
	if self:Me(args.destGUID) or (self:Dispeller("disease", nil, 424750) and self:Player(args.destFlags)) then
		self:TargetMessage(424750, "yellow", args.destName)
		self:PlaySound(424750, "info", nil, args.destName)
	end
end

-- Particularly Bad Guy

function mod:HideousLaughter(args)
	self:Message(args.spellId, "orange", CL.fear)
	self:PlaySound(args.spellId, "alarm")
end
