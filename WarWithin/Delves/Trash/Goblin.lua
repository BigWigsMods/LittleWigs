--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goblin Delve Trash", {2664, 2680, 2681, 2684, 2685, 2686, 2688, 2689, 2690, 2826}) -- Fungal Folly, Earthcrawl Mines, Kriegval's Rest, The Dread Pit, Skittering Breach, Nightfall Sanctum, Spiral Weave, Tek-Rethan Abyss, The Underkeep, Sidestreet Sluice
if not mod then return end
mod:RegisterEnableMob(
	234212, -- Exterminator Janx (Earthcrawl Mines gossip NPC)
	216846, -- Maklin Drillstab (Earthcrawl Mines gossip NPC)
	234496, -- Gila Crosswires (Fungal Folly gossip NPC)
	234530, -- Balga Wicksfix (Kriegval's Rest gossip NPC)
	235090, -- Prospera Cogwail (The Dread Pit gossip NPC)
	235269, -- Lamplighter Kaerter (Skittering Breach gossip NPC)
	234012, -- Nimsi Loosefire (Nightfall Sanctum gossip NPC)
	235083, -- Nerubian Scout (Spiral Weave gossip NPC)
	235439, -- Pamsy (Tek-Rethan Abyss gossip NPC)
	234680, -- Madam Goya (The Underkeep gossip NPC)
	231908, -- Bopper Bot
	231906, -- Aerial Support Bot
	231910, -- Masked Freelancer
	231909, -- Underpaid Brute
	234903, -- Pea-brained Hauler
	231925, -- Drill Sergeant
	235129, -- Mechanized Reinforcement
	231904, -- Punchy Thug
	235489, -- Snorkel Goon
	231905, -- Flinging Flicker
	235292, -- Flinging Flicker
	235295, -- Flinging Flicker
	235298, -- Flinging Flicker
	235635, -- Aquatic Wrench
	231928, -- Bomb Bot
	241969 -- Rad Rat
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
	L.rad_rat = "Rad Rat"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.goblin_trash
	self:SetSpellRename(474001, CL.enrage) -- Bathe in Blood (Enrage)
	self:SetSpellRename(473972, CL.charge) -- Reckless Charge (Charge)
	self:SetSpellRename(473541, CL.frontal_cone) -- Flurry of Punches (Frontal Cone)
	self:SetSpellRename(473537, CL.knockback) -- Uppercut (Knockback)
	self:SetSpellRename(472842, CL.fixate) -- Destroy (Fixate)

	-- Obedient-ish Predator (231930)
	self:SetSpellRename(473533, CL.enrage) -- Ferocious Howl (Enrage)
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Bopper Bot
		{473684, "NAMEPLATE"}, -- Cogstorm
		-- Aerial Support Bot
		{473550, "NAMEPLATE"}, -- Rocket Barrage
		-- Masked Freelancer
		474001, -- Bathe in Blood
		473995, -- Bloodbath
		-- Underpaid Brute
		{473972, "NAMEPLATE"}, -- Reckless Charge
		-- Drill Sergeant
		474004, -- Drill Quake
		1213656, -- Overtime
		-- Punchy Thug
		{473541, "NAMEPLATE"}, -- Flurry of Punches
		{473537, "NAMEPLATE"}, -- Uppercut
		-- Flinging Flicker
		473696, -- Molotov Cocktail
		-- Bomb Bot
		{472842, "ME_ONLY"}, -- Destroy
		-- Rad Rat
		1237160, -- Radiation Pool
	},{
		[473684] = L.bopper_bot,
		[473550] = L.aerial_support_bot,
		[474001] = L.masked_freelancer,
		[473972] = L.underpaid_brute,
		[474004] = L.drill_sergeant,
		[473541] = L.punchy_thug,
		[473696] = L.flinging_flicker,
		[472842] = L.bomb_bot,
		[1237160] = L.rad_rat,
	},{
		[474001] = CL.enrage, -- Bathe in Blood (Enrage)
		[473972] = CL.charge, -- Reckless Charge (Charge)
		[473541] = CL.frontal_cone, -- Flurry of Punches (Frontal Cone)
		[473537] = CL.knockback, -- Uppercut (Knockback)
		[472842] = CL.fixate, -- Destroy (Fixate)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Bopper Bot
	self:RegisterEngageMob("BopperBotEngaged", 231908)
	self:Log("SPELL_CAST_START", "Cogstorm", 473684)
	self:Log("SPELL_CAST_SUCCESS", "CogstormSuccess", 473684)
	self:Death("BopperBotDeath", 231908)

	-- Aerial Support Bot
	self:RegisterEngageMob("AerialSupportBotEngaged", 231906)
	self:Log("SPELL_CAST_START", "RocketBarrage", 473550)
	self:Log("SPELL_CAST_SUCCESS", "RocketBarrageSuccess", 473550)
	self:Death("AerialSupportBotDeath", 231906)

	-- Masked Freelancer
	self:Log("SPELL_CAST_START", "BatheInBlood", 474001)
	self:Log("SPELL_CAST_START", "Bloodbath", 473995)

	-- Underpaid Brute
	self:RegisterEngageMob("UnderpaidBruteEngaged", 231909, 234903) -- Underpaid Brute, Pea-brained Hauler
	self:Log("SPELL_CAST_START", "RecklessCharge", 473972)
	self:Death("UnderpaidBruteDeath", 231909)

	-- Drill Sergeant
	self:Log("SPELL_CAST_START", "DrillQuake", 474004)
	self:Log("SPELL_CAST_START", "Overtime", 1213656)

	-- Punchy Thug
	self:RegisterEngageMob("PunchyThugEngaged", 231904)
	self:Log("SPELL_CAST_START", "FlurryOfPunches", 473541)
	self:Log("SPELL_CAST_SUCCESS", "FlurryOfPunchesSuccess", 473541)
	self:Log("SPELL_CAST_START", "Uppercut", 473537)
	self:Log("SPELL_CAST_SUCCESS", "UppercutSuccess", 473537)
	self:Death("PunchyThugDeath", 231904)

	-- Flinging Flicker
	self:Log("SPELL_CAST_START", "MolotovCocktail", 473696)

	-- Bomb Bot
	self:Log("SPELL_CAST_SUCCESS", "Destroy", 472842)

	-- Rad Rat
	self:Log("SPELL_PERIODIC_DAMAGE", "RadiationPoolDamage", 1237160)
	self:Log("SPELL_PERIODIC_MISSED", "RadiationPoolDamage", 1237160)

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Ky'veza Rares", true)
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
		elseif self:GetGossipID(125516) then -- Nightfall Sanctum, start delve (Nimsi Loosefire)
			-- 125516:|cFF0000FF(Delve)|r I'll recover your weapons.
			self:SelectGossipID(125516)
		elseif self:GetGossipID(131402) then -- Spiral Weave, start delve (Nerubian Scout)
			-- 131402:|cFF0000FF(Delve)|r I'll clear out these greedy goblins.
			self:SelectGossipID(131402)
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

function mod:BopperBotEngaged(guid)
	self:Nameplate(473684, 12, guid) -- Cogstorm
end

function mod:Cogstorm(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then -- RP fights in Skittering Breach
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:CogstormSuccess(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then -- RP fights in Skittering Breach
		self:Nameplate(args.spellId, 21.1, args.sourceGUID)
	end
end

function mod:BopperBotDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Aerial Support Bot

function mod:AerialSupportBotEngaged(guid)
	self:Nameplate(473550, 7.3, guid) -- Rocket Barrage
end

function mod:RocketBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:RocketBarrageSuccess(args)
	self:Nameplate(args.spellId, 18.7, args.sourceGUID)
end

function mod:AerialSupportBotDeath(args)
	self:ClearNameplate(args.destGUID)
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

function mod:UnderpaidBruteEngaged(guid)
	self:Nameplate(473972, 31.2, guid) -- Reckless Charge
end

function mod:RecklessCharge(args)
	self:Nameplate(args.spellId, 36.5, args.sourceGUID)
	self:Message(args.spellId, "yellow", CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

function mod:UnderpaidBruteDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Drill Sergeant

do
	local prev = 0
	function mod:DrillQuake(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) and args.time - prev > 2 then -- RP fights in Skittering Breach
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:Overtime(args)
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) and args.time - prev > 2 then -- RP fights in Skittering Breach
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Punchy Thug

function mod:PunchyThugEngaged(guid)
	self:Nameplate(473541, 3.6, guid) -- Flurry of Punches
	self:Nameplate(473537, 14.5, guid) -- Uppercut
end

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

function mod:FlurryOfPunchesSuccess(args)
	self:Nameplate(args.spellId, 10.8, args.sourceGUID)
end

do
	local prev = 0
	function mod:Uppercut(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange", CL.knockback)
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:UppercutSuccess(args)
	--self:Nameplate(args.spellId, ?, args.sourceGUID)
	self:StopNameplate(args.spellId, args.sourceGUID)
end

function mod:PunchyThugDeath(args)
	self:ClearNameplate(args.destGUID)
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
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Rad Rat

do
	local prev = 0
	function mod:RadiationPoolDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then -- 2s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end
