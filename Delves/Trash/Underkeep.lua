--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Underkeep Trash", 2690)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	220132, -- Weaver's Agent (The Underkeep gossip NPC)
	220133, -- Weaver's Instructions (The Underkeep gossip NPC)
	219022, -- Ascended Webfriar
	219035, -- Deepwalker Guardian
	219454, -- Crazed Abomination
	219034 -- Web Marauder
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ascended_webfriar = "Ascended Webfriar"
	L.deepwalker_guardian = "Deepwalker Guardian"
	L.crazed_abomination = "Crazed Abomination"
	L.web_marauder = "Web Marauder"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:SetSpellRename(450714, CL.frontal_cone) -- Jagged Barbs (Frontal Cone)
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Ascended Webfriar
		451913, -- Grimweave Orb
		-- Deepwalker Guardian
		450714, -- Jagged Barbs
		450637, -- Leeching Swarm
		-- Crazed Abomination
		{448179, "NAMEPLATE"}, -- Armored Shell
		{448155, "NAMEPLATE"}, -- Shockwave Tremors
		{448161, "DISPEL", "NAMEPLATE"}, -- Enrage
		-- Web Marauder
		453149, -- Gossamer Webbing
	},{
		[451913] = L.ascended_webfriar,
		[450714] = L.deepwalker_guardian,
		[448179] = L.crazed_abomination,
		[453149] = L.web_marauder,
	},{
		[450714] = CL.frontal_cone, -- Jagged Barbs (Frontal Cone)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Ascended Webfriar
	self:Log("SPELL_CAST_START", "GrimweaveOrb", 451913)
	self:Log("SPELL_AURA_APPLIED", "GrimweaveOrbDamage", 452041)
	self:Log("SPELL_AURA_REFRESH", "GrimweaveOrbDamage", 452041)

	-- Deepwalker Guardian
	self:Log("SPELL_CAST_START", "JaggedBarbs", 450714)
	self:Log("SPELL_CAST_START", "LeechingSwarm", 450637)

	-- Crazed Abomination
	self:Log("SPELL_CAST_START", "ArmoredShell", 448179)
	self:Log("SPELL_CAST_START", "ShockwaveTremors", 448155)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 448161)
	self:Death("CrazedAbominationDeath", 219454)

	-- Web Marauder
	self:Log("SPELL_CAST_START", "GossamerWebbing", 453149)

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
		if self:GetGossipID(121502) then -- The Underkeep, start Delve (Weaver's Instructions)
			-- 121502:|cFF0000FF(Delve)|r <Close the scroll and look for the Weaver's special pheromone to help combat these failed experiments.>
			self:SelectGossipID(121502)
		end
	end
end

-- Ascended Webfriar

function mod:GrimweaveOrb(args)
	-- this ability can also be cast by one of the Delve bosses (The Puppetmaster)
	if self:MobId(args.sourceGUID) == 219022 then -- Ascended Webfriar
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
	end
end

do
	local prev = 0
	function mod:GrimweaveOrbDamage(args)
		-- this ability can also be cast by one of the Delve bosses (The Puppetmaster)
		if self:MobId(args.sourceGUID) == 219022 then -- Ascended Webfriar
			if self:Me(args.destGUID) and args.time - prev > 1.5 then
				prev = args.time
				self:PersonalMessage(451913, "near")
				self:PlaySound(451913, "underyou")
			end
		end
	end
end

-- Deepwalker Guardian

function mod:JaggedBarbs(args)
	self:Message(args.spellId, "orange", CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:LeechingSwarm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Crazed Abomination

function mod:ArmoredShell(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 13.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ShockwaveTremors(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 8.5, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Enrage(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.other:format(args.spellName, args.destName))
		self:Nameplate(args.spellId, 23.1, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:CrazedAbominationDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Web Marauder

function mod:GossamerWebbing(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
