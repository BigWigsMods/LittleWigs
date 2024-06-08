if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fungarian Delve Trash", {2664, 2679}) -- Fungal Folly, Mycomancer Cavern
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	210677, -- Stoneguard Benston (Fungal Folly gossip NPC)
	220293, -- Aliya Hillhelm (Mycomancer Cavern gossip NPC)
	213434, -- Sporbit
	225708, -- Sporbit (Bogpiper summon)
	207456, -- Fungal Speartender
	207468, -- Gnarled Reviver
	210478, -- Infected Beast
	207454 -- Fungal Gutter
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sporbit = "Sporbit"
	L.fungal_speartender = "Fungal Speartender"
	L.gnarled_reviver = "Gnarled Reviver"
	L.infected_beast = "Infected Beast"
	L.fungal_gutter = "Fungal Gutter"
end

--------------------------------------------------------------------------------
-- Initialization
--

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
	}, {
		[427710] = L.sporbit,
		[414944] = L.fungal_speartender,
		[424773] = L.gnarled_reviver,
		[424798] = L.infected_beast,
		[424704] = L.fungal_gutter,
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
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(111366) then -- Fungal Folly, start Delve
			-- 111366:I'll dive into this cavern and get your friends back.
			self:SelectGossipID(111366)
		elseif self:GetGossipID(121536) then -- Mycomancer Cavern, start Delve
			-- 121536:|cFF0000FF(Delve)|r I'll get your pigs back and make those fungarians pay for this.
			self:SelectGossipID(121536)
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
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
