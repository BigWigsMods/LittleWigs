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
		346329, -- Spilled Liquids
		346742, -- Fan Mail
		{346962, "SAY", "SAY_COUNTDOWN"}, -- Money Order
		346947, -- Unstable Goods
		346296, -- Instability
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "HazardousLiquids", 346286)
	self:Log("SPELL_PERIODIC_DAMAGE", "SpilledLiquidsDamage", 346329)
	self:Log("SPELL_PERIODIC_MISSED", "SpilledLiquidsDamage", 346329)
	self:Log("SPELL_CAST_START", "FanMail", 346742)
	self:Log("SPELL_CAST_SUCCESS", "MoneyOrder", 346962)
	self:Log("SPELL_AURA_APPLIED", "MoneyOrderApplied", 346962)
	self:Log("SPELL_AURA_REMOVED", "MoneyOrderRemoved", 346962)
	self:Log("SPELL_CAST_SUCCESS", "UnstableGoods", 346947)
	self:Log("SPELL_AURA_APPLIED", "InstabilityApplied", 346296)
	self:Log("SPELL_AURA_REMOVED", "InstabilityRemoved", 346296)
end

function mod:OnEngage()
	self:CDBar(346286, 8.0) -- Hazardous Liquids
	self:CDBar(346742, 15.6) -- Fan Mail
	self:CDBar(346962, 22.8) -- Money Order
	self:CDBar(346947, 37.0) -- Unstable Goods
	self:CDBar("delivery_portal", 37.5, L.delivery_portal, L.delivery_portal_icon) -- Delivery Portal
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Delivery Portals
do
	local function deliveryPortalSpawned()
		mod:Message("delivery_portal", "cyan", CL.spawned:format(L.delivery_portal), L.delivery_portal_icon)
		mod:CDBar("delivery_portal", 43.5, L.delivery_portal, L.delivery_portal_icon)
		mod:PlaySound("delivery_portal", "info")
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
		if spellId == 1242877 then -- Activated Portal
			-- portal spawns 5 seconds after this cast, then lasts for 30 seconds
			self:CDBar("delivery_portal", {5, 43.5}, L.delivery_portal, L.delivery_portal_icon)
			self:ScheduleTimer(deliveryPortalSpawned, 5)
		end
	end
end

function mod:HazardousLiquids(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 43.5)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:SpilledLiquidsDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then -- 1s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:FanMail(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 42.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:MoneyOrder(args)
	self:CDBar(args.spellId, 43.5)
end

function mod:MoneyOrderApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId, nil, nil, "Money Order")
		self:YellCountdown(args.spellId, 7)
	end
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
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
				duration = math.min(expirationTime - currentTime, duration)
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
			mod:StopBar(barText)
			barText = nil
			mod:PlaySound(spellId, "info")
		end
	end

	function mod:UnstableGoods(args)
		instabilityCount = 0
		unstableGoodsContainer = {}
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 43.5)
		self:PlaySound(args.spellId, "long")
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
