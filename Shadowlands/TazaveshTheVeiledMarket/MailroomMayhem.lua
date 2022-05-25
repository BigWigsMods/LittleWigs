
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mailroom Mayhem", 2441, 2436)
if not mod then return end
mod:RegisterEnableMob(175646) -- P.O.S.T. Master
mod:SetEncounterID(2424)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local instabilityCount = 0
local unstableGoodsContainer = {}

--------------------------------------------------------------------------------
-- Localization
--

L.delivery_portal = "Delivery Portal"
L.delivery_portal_desc = "Shows a timer for when the Delivery Portal will change locations."
L.delivery_portal_icon = "spell_arcane_portaldalarancrater"

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
	self:RegisterEvent("RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_SUCCESS", "HazardousLiquids", 346286)
	self:Log("SPELL_CAST_START", "FanMail", 346742)
	self:Log("SPELL_AURA_APPLIED", "MoneyOrderApplied", 346962)
	self:Log("SPELL_AURA_REMOVED", "MoneyOrderRemoved", 346962)
	self:Log("SPELL_CAST_SUCCESS", "UnstableGoods", 346947)
	self:Log("SPELL_AURA_APPLIED", "InstabilityApplied", 346296)
	self:Log("SPELL_AURA_REMOVED", "InstabilityRemoved", 346296)
end

function mod:OnEngage()
	instabilityCount = 0
	unstableGoodsContainer = {}
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
function mod:RAID_BOSS_EMOTE(_, msg)
	 -- Emotes that don't have the unstable goods icon must be for delivery portals
	if not msg:find("spell_Mage_Flameorb", nil, true) then
		self:Message("delivery_portal", "cyan", msg, L.delivery_portal_icon)
		self:PlaySound("delivery_portal", "info")
		self:Bar("delivery_portal", 35, L.delivery_portal, L.delivery_portal_icon)
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
		self:Yell(args.spellId)
		self:YellCountdown(args.spellId, 7)
	end
end

function mod:MoneyOrderRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelYellCountdown(args.spellId)
	end
end

function mod:UnstableGoods(args)
	instabilityCount = 0
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 52.2)
end

function mod:InstabilityApplied(args)
	if not unstableGoodsContainer[args.sourceGUID] then
		instabilityCount = instabilityCount + 1
		local barText = CL.count:format(CL.explosion, instabilityCount)
		self:Bar(args.spellId, 30, barText)
		unstableGoodsContainer[args.sourceGUID] = barText
	end
end

function mod:InstabilityRemoved(args)
	self:StopBar(unstableGoodsContainer[args.sourceGUID])
	unstableGoodsContainer[args.sourceGUID] = nil
end
