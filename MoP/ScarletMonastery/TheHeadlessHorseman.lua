--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Headless Horseman", 1004)
if not mod then return end
mod:RegisterEnableMob(
	209640, -- Suzannah
	207927, -- Wicker Man of Embers
	207860, -- Wicker Man of Thorns
	207827, -- Wicker Man of Shadows
	207854, -- Wicker Man of Delusions
	207798, -- Ominous Wicker Man
	211824, -- Pumpkin Shrine
	207438  -- The Headless Horseman
)
mod:SetAllowWin(true)
mod:SetEncounterID(2725)

--------------------------------------------------------------------------------
-- Locals
--

local pumpkinBreathCount = 1
local vineMarchCount = 1
local insidiousCackleCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_headless_horseman = "The Headless Horseman"
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	L.custom_on_autotalk_icon = "ui_chat"
	L.curses = 418990
	L.curses_icon = 418990
	L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_headless_horseman
end

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		-- Normal
		414844, -- Pumpkin Breath
		415047, -- Vine March
		415262, -- Insidious Cackle
		423626, -- Hot Head
		-- Hard Mode
		"curses",
		415864, -- Wicker Man's Shadow
		418228, -- Wicker Man's Protection
	}, {
		[414844] = CL.normal,
		["curses"] = CL.hard,
	}
end

function mod:OnBossEnable()
	-- Normal
	self:Log("SPELL_CAST_START", "PumpkinBreath", 414844)
	self:Log("SPELL_CAST_START", "VineMarch", 415047)
	self:Log("SPELL_CAST_START", "InsidiousCackle", 415262)
	self:Log("SPELL_CAST_START", "HotHead", 423626)

	-- Hard Mode
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "WickerMansCurseApplied", 415629, 415611, 415536, 415575) -- Embers, Thorns, Shadows, Delusions
	self:Log("SPELL_AURA_APPLIED", "WickerMansShadowApplied", 415864)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WickerMansShadowApplied", 415864)
	self:Log("SPELL_AURA_APPLIED", "WickerMansProtectionApplied", 418228)
end

function mod:OnEngage()
	pumpkinBreathCount = 1
	vineMarchCount = 1
	insidiousCackleCount = 1
	self:CDBar(414844, 6.0) -- Pumpkin Breath
	self:CDBar(415047, 20.6) -- Vine March
	self:CDBar(415262, 35.2) -- Insidious Cackle
	self:CDBar(423626, 61.9) -- Hot Head
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Normal

function mod:PumpkinBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	pumpkinBreathCount = pumpkinBreathCount + 1
	if pumpkinBreathCount == 2 then
		self:CDBar(args.spellId, 41.3)
	else -- 3+
		self:CDBar(args.spellId, 54.7)
	end
end

function mod:VineMarch(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	vineMarchCount = vineMarchCount + 1
	self:CDBar(args.spellId, 42.4)
end

function mod:InsidiousCackle(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	insidiousCackleCount = insidiousCackleCount + 1
	if insidiousCackleCount == 2 then
		self:CDBar(args.spellId, 54.6)
	else -- 3+
		self:CDBar(args.spellId, 46.2)
	end
end

function mod:HotHead(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 70.4)
end

-- Hard Mode

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(110383) then
			-- 110383:I accept your curse. (Embers)
			self:SelectGossipID(110383, true)
		elseif self:GetGossipID(110379) then
			-- 110379:I accept your curse. (Thorns)
			self:SelectGossipID(110379, true)
		elseif self:GetGossipID(110372) then
			-- 110372:I accept your curse. (Shadows)
			self:SelectGossipID(110372, true)
		elseif self:GetGossipID(110377) then
			-- 110377:I accept your curse. (Delusions)
			self:SelectGossipID(110377, true)
		elseif self:GetGossipID(111387) then
			-- 111387:I accept all of your curses.
			self:SelectGossipID(111387, true)
		elseif self:GetGossipID(36316) then
			-- 36316:Call the Headless Horseman.
			self:SelectGossipID(36316)
		end
	end
end

function mod:WickerMansCurseApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage("curses", nil, args.spellId, args.spellId)
	end
end

do
	local prev = 0
	function mod:WickerMansShadowApplied(args)
		local amount = args.amount or 1
		local t = args.time
		if self:Me(args.destGUID) and amount < 10 and t - prev > 2 then
			prev = t
			self:StackMessage(args.spellId, "blue", args.destName, amount, 5)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

function mod:WickerMansProtectionApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green")
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end
