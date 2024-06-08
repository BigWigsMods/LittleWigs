if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerubian Delve Trash", {2680, 2684, 2685, 2688}) -- Earthcrawl Mines, The Dread Pit, Skittering Breach, The Spiral Weave
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	215685, -- Foreman Pivk (Earthcrawl Mines gossip NPC)
	219680, -- Vant (The Dread Pit gossip NPC)
	220585, -- Lamplighter Havrik Chayvn (Skittering Breach gossip NPC)
	218103, -- Nerubian Lord
	208242, -- Nerubian Darkcaster
	216584, -- Nerubian Captain
	216583, -- Chittering Fearmonger
	208245 -- Skittering Swarmer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nerubian_lord = "Nerubian Lord"
	L.nerubian_darkcaster = "Nerubian Darkcaster"
	L.nerubian_captain = "Nerubian Captain"
	L.chittering_fearmonger = "Chittering Fearmonger"
	L.skittering_swarmer = "Skittering Swarmer"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Nerubian Lord
		450714, -- Jagged Barbs
		450637, -- Leeching Swarm
		-- Nerubian Darkcaster
		449318, -- Shadows of Strife
		-- Nerubian Captain
		450546, -- Webbed Aegis
		450509, -- Wide Swipe
		-- Chittering Fearmonger
		433410, -- Fearful Shriek
		-- Skittering Swarmer
		450197, -- Skitter Charge
	}, {
		[450714] = L.nerubian_lord,
		[449318] = L.nerubian_darkcaster,
		[450546] = L.nerubian_captain,
		[433410] = L.chittering_fearmonger,
		[450197] = L.skittering_swarmer,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Nerubian Lord
	self:Log("SPELL_CAST_START", "JaggedBarbs", 450714)
	self:RegisterEvent("UNIT_SPELLCAST_START") -- Leeching Swarm

	-- Nerubian Darkcaster
	self:Log("SPELL_CAST_START", "ShadowsOfStrife", 449318)

	-- Nerubian Captain
	self:Log("SPELL_CAST_START", "WebbedAegis", 450546)
	self:Log("SPELL_CAST_START", "WideSwipe", 450509)

	-- Chittering Fearmonger
	self:Log("SPELL_CAST_START", "FearfulShriek", 433410)

	-- Skittering Swarmer
	self:Log("SPELL_CAST_START", "SkitterCharge", 450197)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(121408) then -- Skittering Breach, start Delve
			-- 121408:|cFF0000FF(Delve)|r I'll go deeper in and stop the nerubian ritual.
			self:SelectGossipID(121408)
		elseif self:GetGossipID(121508) then -- The Dread Pit, start Delve
			-- 121508:|cFF0000FF(Delve)|r I'll take your device and use it to recover the memory gems in the area.
			self:SelectGossipID(121508)
		elseif self:GetGossipID(123392) then -- The Dread Pit, continue Delve
			-- 123392:|cFF0000FF(Delve)|r I'll use the modified device to get through the webs up ahead.
			self:SelectGossipID(123392)
		elseif self:GetGossipID(120330) then -- Earthcrawl Mines, start Delve
			-- 120330:|cFF0000FF(Delve)|r I'll guard the cart and help you rescue your friends.
			self:SelectGossipID(120330)
		elseif self:GetGossipID(120383) then -- Earthcrawl Mines, continue Delve
			-- 120383:Let's get this cart moving. I'll keep you safe.
			self:SelectGossipID(120383)
		end
	end
end

-- Nerubian Lord

function mod:JaggedBarbs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_START(_, unit, castGUID, spellId)
		if spellId == 450637 and castGUID ~= prev then -- Leeching Swarm
			prev = castGUID
			self:Message(spellId, "yellow")
			self:PlaySound(spellId, "info")
		end
	end
end

-- Nerubian Darkcaster

function mod:ShadowsOfStrife(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nerubian Captain

function mod:WebbedAegis(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:WideSwipe(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Chittering Fearmonger

function mod:FearfulShriek(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Skittering Swarmer

function mod:SkitterCharge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end
