--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerubian Delve Trash", {2680, 2684, 2685, 2688}) -- Earthcrawl Mines, The Dread Pit, Skittering Breach, The Spiral Weave
if not mod then return end
mod:RegisterEnableMob(
	215685, -- Foreman Pivk (Earthcrawl Mines gossip NPC)
	216632, -- Lamplighter Rathling (Earthcrawl Mines gossip NPC)
	219680, -- Vant (The Dread Pit gossip NPC)
	220585, -- Lamplighter Havrik Chayvn (Skittering Breach gossip NPC)
	220461, -- Weaver's Agent (The Spiral Weave gossip NPC)
	220462, -- Weaver's Instructions (The Spiral Weave gossip NPC)
	218103, -- Nerubian Lord
	208242, -- Nerubian Darkcaster
	220485, -- Peculiar Nerubian
	216584, -- Nerubian Captain
	228954, -- Nerubian Marauder
	216583, -- Chittering Fearmonger
	208245, -- Skittering Swarmer
	220148, -- Gem Hoarder
	216621, -- Nerubian Webspinner
	219810 -- Nerubian Ritualist
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nerubian_trash = "Nerubian Trash"

	L.nerubian_lord = "Nerubian Lord"
	L.nerubian_darkcaster = "Nerubian Darkcaster"
	L.nerubian_captain = "Nerubian Captain"
	L.chittering_fearmonger = "Chittering Fearmonger"
	L.skittering_swarmer = "Skittering Swarmer"
	L.nerubian_webspinner = "Nerubian Webspinner"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nerubian_trash
	self:SetSpellRename(450714, CL.frontal_cone) -- Jagged Barbs (Frontal Cone)
	self:SetSpellRename(449318, CL.bomb) -- Shadows of Strife (Bomb)
	self:SetSpellRename(450546, CL.shield) -- Webbed Aegis (Shield)
	self:SetSpellRename(450509, CL.frontal_cone) -- Wide Swipe (Frontal Cone)
	self:SetSpellRename(433410, CL.fear) -- Fearful Shriek (Fear)
	self:SetSpellRename(450197, CL.charge) -- Skitter Charge (Charge)
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Nerubian Lord
		450714, -- Jagged Barbs
		450637, -- Leeching Swarm
		-- Nerubian Darkcaster
		{449318, "SAY", "SAY_COUNTDOWN"}, -- Shadows of Strife
		-- Nerubian Captain / Nerubian Marauder
		{450546, "DISPEL"}, -- Webbed Aegis
		450509, -- Wide Swipe
		-- Chittering Fearmonger
		433410, -- Fearful Shriek
		-- Skittering Swarmer
		450197, -- Skitter Charge
		-- Nerubian Webspinner
		433448, -- Web Launch
	},{
		[450714] = L.nerubian_lord,
		[449318] = L.nerubian_darkcaster,
		[450546] = L.nerubian_captain,
		[433410] = L.chittering_fearmonger,
		[450197] = L.skittering_swarmer,
		[433448] = L.nerubian_webspinner,
	},{
		[450714] = CL.frontal_cone, -- Jagged Barbs (Frontal Cone)
		[449318] = CL.bomb, -- Shadows of Strife (Bomb)
		[450546] = CL.shield, -- Webbed Aegis (Shield)
		[450509] = CL.frontal_cone, -- Wide Swipe (Frontal Cone)
		[433410] = CL.fear, -- Fearful Shriek (Fear)
		[450197] = CL.charge, -- Skitter Charge (Charge)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Nerubian Lord
	self:Log("SPELL_CAST_START", "JaggedBarbs", 450714)
	self:Log("SPELL_CAST_START", "LeechingSwarm", 450637)

	-- Nerubian Darkcaster
	self:Log("SPELL_CAST_START", "ShadowsOfStrife", 449318)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfStrifeApplied", 449318)
	self:Log("SPELL_AURA_REMOVED", "ShadowsOfStrifeRemoved", 449318)

	-- Nerubian Captain / Nerubian Marauder
	self:Log("SPELL_CAST_START", "WebbedAegis", 450546)
	self:Log("SPELL_AURA_APPLIED", "WebbedAegisApplied", 450546)
	self:Log("SPELL_CAST_START", "WideSwipe", 450509)

	-- Chittering Fearmonger
	self:Log("SPELL_CAST_START", "FearfulShriek", 433410)

	-- Skittering Swarmer
	self:Log("SPELL_CAST_START", "SkitterCharge", 450197)

	-- Nerubian Webspinner
	self:Log("SPELL_CAST_SUCCESS", "WebLaunch", 433448)

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
		if self:GetGossipID(121408) then -- Skittering Breach, start Delve (Lamplighter Havrik Chayvn)
			-- 121408:|cFF0000FF(Delve)|r I'll go deeper in and stop the nerubian ritual.
			self:SelectGossipID(121408)
		elseif self:GetGossipID(121508) then -- The Dread Pit, start Delve (Vant)
			-- 121508:|cFF0000FF(Delve)|r I'll take your device and use it to recover the memory gems in the area.
			self:SelectGossipID(121508)
		elseif self:GetGossipID(123392) then -- The Dread Pit, continue Delve (Vant)
			-- 123392:|cFF0000FF(Delve)|r I'll use the modified device to get through the webs up ahead.
			self:SelectGossipID(123392)
		elseif self:GetGossipID(120330) then -- Earthcrawl Mines, start Delve (Foreman Pivk)
			-- 120330:|cFF0000FF(Delve)|r I'll guard the cart and help you rescue your friends.
			self:SelectGossipID(120330)
		elseif self:GetGossipID(120383) then -- Earthcrawl Mines, continue Delve (Foreman Pivk)
			-- 120383:Let's get this cart moving. I'll keep you safe.
			self:SelectGossipID(120383)
		elseif self:GetGossipID(120540) then -- Earthcrawl Mines, start Delve (Lamplighter Rathling)
			-- 120540:|cFF0000FF(Delve)|r I'll get the flamethrower torch and help you find the other Lamplighters.
			self:SelectGossipID(120540)
		elseif self:GetGossipID(120541) then -- Earthcrawl Mines, continue Delve (Lamplighter Rathling)
			-- 120541:|cFF0000FF(Delve)|r This is the part where we're swarmed by nerubians, isn't it?
			self:SelectGossipID(120541)
		elseif self:GetGossipID(121566) then -- The Spiral Weave, start Delve (Weaver's Instructions)
			-- 121566:|cFF0000FF(Delve)|r <Close the scroll and take the Weaver's web grappling hook.>
			self:SelectGossipID(121566)
		end
	end
end

-- Nerubian Lord

function mod:JaggedBarbs(args)
	if self:MobId(args.sourceGUID) == 218103 then -- Nerubian Lord
		self:Message(args.spellId, "orange", CL.frontal_cone)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:LeechingSwarm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Nerubian Darkcaster

function mod:ShadowsOfStrife(args)
	self:Message(args.spellId, "red", CL.casting:format(CL.bomb))
	self:PlaySound(args.spellId, "alert")
end

function mod:ShadowsOfStrifeApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, CL.bomb, nil, "Bomb")
		self:SayCountdown(args.spellId, 8)
	end
end

function mod:ShadowsOfStrifeRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Nerubian Captain / Nerubian Marauder

function mod:WebbedAegis(args)
	local mobId = self:MobId(args.sourceGUID)
	if mobId == 216584 or mobId == 228954 then -- Nerubian Captain, Nerubian Marauder
		self:Message(args.spellId, "red", CL.casting:format(CL.shield))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:WebbedAegisApplied(args)
	local mobId = self:MobId(args.sourceGUID)
	if self:Dispeller("magic", true, args.spellId) and (mobId == 216584 or mobId == 228954) then -- Nerubian Captain, Nerubian Marauder
		if self:Player(args.destFlags) then
			self:TargetMessage(args.spellId, "green", args.destName, CL.shield)
		else
			self:Message(args.spellId, "red", CL.other:format(CL.shield, args.destName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:WideSwipe(args)
		local mobId = self:MobId(args.sourceGUID)
		if args.time - prev > 2 and (mobId == 216584 or mobId == 228954) then -- Nerubian Captain, Nerubian Marauder
			prev = args.time
			self:Message(args.spellId, "purple", CL.frontal_cone)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Chittering Fearmonger

function mod:FearfulShriek(args)
	self:Message(args.spellId, "orange", CL.fear)
	self:PlaySound(args.spellId, "alarm")
end

-- Skittering Swarmer

function mod:SkitterCharge(args)
	if self:MobId(args.sourceGUID) == 208245 then -- Skittering Swarmer
		self:Message(args.spellId, "yellow", CL.charge)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Nerubian Webspinner

function mod:WebLaunch(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
