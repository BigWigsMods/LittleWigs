--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Den of Nalorakk Trash", 2825)
if not mod then return end
mod.displayName = CL.trash

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.offerings_acquired = "Offerings Acquired"
	L.offerings_acquired_desc = "Show an alert when an offering has been acquired."
	L.offerings_acquired_icon = "inv_misc_coinbag09"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		"offerings_acquired",
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Offerings Acquired
	self:RegisterWidgetEvent(7092, "OfferingsAcquired")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(135009) then -- Interact with Ethereal Pyre to start the dungeon.
			-- 135009:<Meditate on the sound of the flames.>
			self:SelectGossipID(135009)
		elseif self:GetGossipID(135010) then -- Interact with Ethereal Pyre to continue the dungeon.
			-- 135010:<Meditate on the sound of the flames.>
			self:SelectGossipID(135010)
		elseif self:GetGossipID(137694) then -- Warding Incense (Versatility buff)
			-- 137694:<You light the incense, its aroma fortifying the resolve of nearby allies.>\r\n\r\n[Requires at least 25 skill in Midnight Alchemy or Druid Bear Form.]
			self:SelectGossipID(137694)
		end
	end
end

function mod:OfferingsAcquired(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:7092, widgetType:8, text:|TInterface\\ICONS\\inv_misc_coinbag09.blp:20|t Offerings Acquired: 1/6
	self:Message("offerings_acquired", "green", text, false)
	self:PlaySound("offerings_acquired", "info")
end
