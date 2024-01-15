--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mailroom Mayhem", 2441, 2436)
if not mod then return end
mod:RegisterEnableMob(175646) -- P.O.S.T. Master
mod:SetEncounterID(2424)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.delivery_portal = "Delivery Portal"
	L.delivery_portal_desc = "Shows a timer for when the Delivery Portal will change locations."
	L.delivery_portal_icon = "spell_arcane_portaldalarancrater"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"delivery_portal",
		346286, -- Hazardous Liquids
		346742, -- Fan Mail
		{346962, "SAY", "SAY_COUNTDOWN"}, -- Money Order
		346947, -- Unstable Goods
		346296, -- Instability
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_SUCCESS", "HazardousLiquids", 346286)
	self:Log("SPELL_CAST_START", "FanMail", 346742)
	self:Log("SPELL_AURA_APPLIED", "MoneyOrderApplied", 346962)
	self:Log("SPELL_AURA_REMOVED", "MoneyOrderRemoved", 346962)
	self:Log("SPELL_CAST_SUCCESS", "UnstableGoods", 346947)
	self:Log("SPELL_AURA_APPLIED", "InstabilityApplied", 346296)
	self:Log("SPELL_AURA_REMOVED", "InstabilityRemoved", 346296)
end

function mod:OnEngage()
	self:Bar(346286, 6) -- Hazardous Liquids
	self:Bar(346742, 16) -- Fan Mail
	self:Bar(346962, 22.8) -- Money Order
	self:Bar(346947, 30.1) -- Unstable Goods
	self:Bar("delivery_portal", 35, L.delivery_portal, L.delivery_portal_icon) -- Delivery Portal
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Delivery Portals
do
	local function deliveryPortalSpawned()
		mod:Message("delivery_portal", "cyan", CL.spawned:format(L.delivery_portal), L.delivery_portal_icon)
		mod:PlaySound("delivery_portal", "info")
		mod:Bar("delivery_portal", 30, L.delivery_portal, L.delivery_portal_icon)
	end

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
		-- emotes that don't have the unstable goods spell ID must be for delivery portals
		if self:IsEngaged() and not msg:find("346947", nil, true) then
			-- portal spawns 5 seconds after the emote, then lasts for 30 seconds
			self:Bar("delivery_portal", 5, CL.spawning:format(L.delivery_portal), L.delivery_portal_icon)
			self:ScheduleTimer(deliveryPortalSpawned, 5)
		end
	end
end

function mod:HazardousLiquids(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 52.2)
end

function mod:FanMail(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 25.5)
end

function mod:MoneyOrderApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:Bar(args.spellId, 50.5)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId, nil, nil, "Money Order")
		self:YellCountdown(args.spellId, 7)
	end
end

function mod:MoneyOrderRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelYellCountdown(args.spellId)
	end
end

do
	local instabilityCount = 0
	local unstableGoodsContainer = {}
	local barText

	local function updateInstabilityBar(spellId, currentTime)
		if instabilityCount > 0 then
			-- calculate duration based on the minimum time until a bomb explodes
			local duration = 30
			for _, expirationTime in pairs(unstableGoodsContainer) do
				duration = min(expirationTime - currentTime, duration)
			end

			-- stop any previous bar
			if barText then
				mod:StopBar(barText)
			end

			-- show new bar with updated duration
			barText = CL.count:format(CL.explosion, instabilityCount)
			mod:Bar(spellId, {duration, 30}, barText)
		else
			-- the last bomb has been delivered (or... it exploded)
			mod:Message(spellId, "green", CL.over:format(mod:SpellName(346947))) -- Unstable Goods
			mod:PlaySound(spellId, "info")
			mod:StopBar(barText)
			barText = nil
		end
	end

	function mod:UnstableGoods(args)
		instabilityCount = 0
		unstableGoodsContainer = {}
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "long")
		self:Bar(args.spellId, 52.2)
	end

	function mod:InstabilityApplied(args)
		-- this event is fired twice for some reason, don't track duplicates
		if not unstableGoodsContainer[args.sourceGUID] then
			instabilityCount = instabilityCount + 1
			-- bombs explode after 30 seconds
			unstableGoodsContainer[args.sourceGUID] = args.time + 30
			updateInstabilityBar(args.spellId, args.time)
		end
	end

	function mod:InstabilityRemoved(args)
		instabilityCount = instabilityCount - 1
		unstableGoodsContainer[args.sourceGUID] = nil
		updateInstabilityBar(args.spellId, args.time)
	end
end
