--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goblin Delve Trash", {2664, 2680, 2681, 2684, 2685, 2689, 2690, 2826}) -- Fungal Folly, Earthcrawl Mines, Kriegval's Rest, The Dread Pit, Skittering Breach, Tek-Rethan Abyss, The Underkeep, Sidestreet Sluice
if not mod then return end
mod:RegisterEnableMob(
	234212, -- Exterminator Janx (Earthcrawl Mines gossip NPC)
	216846, -- Maklin Drillstab (Earthcrawl Mines gossip NPC)
	234496, -- Gila Crosswires (Fungal Folly gossip NPC)
	234530, -- Balga Wicksfix (Kriegval's Rest gossip NPC)
	235090, -- Prospera Cogwail (The Dread Pit gossip NPC)
	235269, -- Lamplighter Kaerter (Skittering Breach gossip NPC)
	235439, -- Pamsy (Tek-Rethan Abyss gossip NPC)
	234680, -- Madam Goya (The Underkeep gossip NPC)
	231908, -- Bopper Bot
	231906, -- Aerial Support Bot
	231910, -- Masked Freelancer
	231909, -- Underpaid Brute
	231925, -- Drill Sergeant
	231904, -- Punchy Thug
	235489, -- Snorkel Goon
	231905, -- Flinging Flicker
	235292, -- Flinging Flicker
	235295, -- Flinging Flicker
	235298, -- Flinging Flicker
	235635, -- Aquatic Wrench
	231928 -- Bomb Bot
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.goblin_trash = "Goblin Trash"

	L.bopper_bot = "Bopper Bot"
	L.aerial_support_bot = "Aerial Support Bot"
	L.masked_freelancer = "Masked Freelancer"
	L.underpaid_brute = "Underpaid Brute"
	L.drill_sergeant = "Drill Sergeant"
	L.punchy_thug = "Punchy Thug"
	L.flinging_flicker = "Flinging Flicker"
	L.bomb_bot = "Bomb Bot"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.goblin_trash
	self:SetSpellRename(474001, CL.enrage) -- Bathe in Blood (Enrage)
	self:SetSpellRename(473541, CL.frontal_cone) -- Flurry of Punches (Frontal Cone)
	self:SetSpellRename(472842, CL.fixate) -- Destroy (Fixate)
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Bopper Bot
		473684, -- Cogstorm
		-- Aerial Support Bot
		473550, -- Rocket Barrage
		-- Masked Freelancer
		474001, -- Bathe in Blood
		473995, -- Bloodbath
		-- Underpaid Brute
		473972, -- Reckless Charge
		-- Drill Sergeant
		474004, -- Drill Quake
		1213656, -- Overtime
		-- Punchy Thug
		473541, -- Flurry of Punches
		-- Flinging Flicker
		473696, -- Molotov Cocktail
		-- Bomb Bot
		{472842, "ME_ONLY"}, -- Destroy
	},{
		[473684] = L.bopper_bot,
		[473550] = L.aerial_support_bot,
		[474001] = L.masked_freelancer,
		[473972] = L.underpaid_brute,
		[474004] = L.drill_sergeant,
		[473541] = L.punchy_thug,
		[473696] = L.flinging_flicker,
		[472842] = L.bomb_bot,
	},{
		[474001] = CL.enrage, -- Bathe in Blood (Enrage)
		[473541] = CL.frontal_cone, -- Flurry of Punches (Frontal Cone)
		[472842] = CL.fixate, -- Destroy (Fixate)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Bopper Bot
	self:Log("SPELL_CAST_START", "Cogstorm", 473684)

	-- Aerial Support Bot
	self:Log("SPELL_CAST_START", "RocketBarrage", 473550)

	-- Masked Freelancer
	self:Log("SPELL_CAST_START", "BatheInBlood", 474001)
	self:Log("SPELL_CAST_START", "Bloodbath", 473995)

	-- Underpaid Brute
	self:Log("SPELL_CAST_START", "RecklessCharge", 473972)

	-- Drill Sergeant
	self:Log("SPELL_CAST_START", "DrillQuake", 474004)
	self:Log("SPELL_CAST_START", "Overtime", 1213656)

	-- Punchy Thug
	self:Log("SPELL_CAST_START", "FlurryOfPunches", 473541)

	-- Flinging Flicker
	self:Log("SPELL_CAST_START", "MolotovCocktail", 473696)

	-- Bomb Bot
	self:Log("SPELL_CAST_SUCCESS", "Destroy", 472842)

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Underpin Rares", true)
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
		if self:GetGossipID(131267) then -- Fungal Folly, start delve (Gila Crosswires)
			-- 131267:|cFF0000FF(Delve)|r I'll get the batteries back and make those drills operational again.
			self:SelectGossipID(131267)
		elseif self:GetGossipID(131152) then -- Earthcrawl Mines, start delve (Exterminator Janx)
			-- 131152:|cFF0000FF(Delve)|r I'll get the gadget and will help your friends.
			self:SelectGossipID(131152)
		elseif self:GetGossipID(120551) then -- Earthcrawl Mines, start delve (Maklin Drillstab)
			-- 120551:Instant treasure? I'm in, let's go into your mole machine.
			self:SelectGossipID(120551)
		elseif self:GetGossipID(120553) then -- Earthcrawl Mines, continue delve (Maklin Drillstab)
			-- 120553:I'll track down where the treasure was taken.
			self:SelectGossipID(120553)
		elseif self:GetGossipID(131312) then -- Kriegval's Rest, start delve (Balga Wicksfix)
			-- 131312:|cFF0000FF(Delve)|r Let's get those candles purified and teach those goblins a lesson.
			self:SelectGossipID(131312)
		elseif self:GetGossipID(131401) then -- The Dread Pit, start delve (Prospera Cogwail)
			-- 131401:|cFF0000FF(Delve)|r I'll see what I can do to disrupt their camp!
			self:SelectGossipID(131401)
		elseif self:GetGossipID(131427) then -- Skittering Breach, start delve (Lamplighter Kaerter)
			-- 131427:|cFF0000FF(Delve)|r I'll eliminate any dangers here. Then re-seal the relics for everyone's safety.
			self:SelectGossipID(131427)
		elseif self:GetGossipID(131474) then -- Tek-Rethan Abyss, start delve (Pamsy)
			-- 131474:|cFF0000FF(Delve)|r I'll rescue your crew and put a stop to Gallywix's operation here.
			self:SelectGossipID(131474)
		elseif self:GetGossipID(131318) then -- The Underkeep, start delve (Madam Goya)
			-- 131318:|cFF0000FF(Delve)|r I'll stop the Darkfuse and gather the Black Blood you need.
			self:SelectGossipID(131318)
		end
	end
end

-- Bopper Bot

function mod:Cogstorm(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then -- RP fights in Skittering Breach
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Aerial Support Bot

function mod:RocketBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Masked Freelancer

function mod:BatheInBlood(args)
	self:Message(args.spellId, "red", CL.casting:format(CL.enrage))
	self:PlaySound(args.spellId, "alert")
end

function mod:Bloodbath(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Underpaid Brute

function mod:RecklessCharge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Drill Sergeant

function mod:DrillQuake(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then -- RP fights in Skittering Breach
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Overtime(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then -- RP fights in Skittering Breach
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
	end
end

-- Punchy Thug

do
	local prev = 0
	function mod:FlurryOfPunches(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red", CL.frontal_cone)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Flinging Flicker

do
	local prev = 0
	function mod:MolotovCocktail(args)
		-- also cast by a Gold Elemental mob, Gold Shaman
		if args.time - prev > 2 and self:MobId(args.sourceGUID) ~= 234932 then -- Gold Shaman
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Bomb Bot

do
	local prev = 0
	function mod:Destroy(args)
		self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
		if args.time - prev > 2 then
			prev = args.time
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end
