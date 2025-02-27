--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goblin Delve Trash", {2664, 2680, 2681, 2690, 2826}) -- Fungal Folly, Earthcrawl Mines, Kriegval's Rest, The Underkeep, Sidestreet Sluice
if not mod then return end
mod:RegisterEnableMob(
	234212, -- Exterminator Janx (Earthcrawl Mines gossip NPC)
	216846, -- Maklin Drillstab (Earthcrawl Mines gossip NPC)
	234496, -- Gila Crosswires (Fungal Folly gossip NPC)
	234530, -- Balga Wicksfix (Kriegval's Rest gossip NPC)
	234680, -- Madam Goya (The Underkeep gossip NPC)
	231908, -- Bopper Bot
	231906, -- Aerial Support Bot
	231910, -- Masked Freelancer
	231909, -- Underpaid Brute
	231925 -- Drill Sergeant
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
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.goblin_trash
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
	}, {
		[473684] = L.bopper_bot,
		[473550] = L.aerial_support_bot,
		[474001] = L.masked_freelancer,
		[473972] = L.underpaid_brute,
		[474004] = L.drill_sergeant,
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

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Zekvir Rares", true)
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
		elseif self:GetGossipID(131318) then -- The Underkeep, start delve (Madam Goya)
			-- 131318:|cFF0000FF(Delve)|r I'll stop the Darkfuse and gather the Black Blood you need.
			self:SelectGossipID(131318)
		end
	end
end

-- Bopper Bot

function mod:Cogstorm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Aerial Support Bot

function mod:RocketBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Masked Freelancer

function mod:BatheInBlood(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
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
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Overtime(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
