if not BigWigsLoader.isRetail then return end -- Midnight+
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pit of Saron Trash", 658)
if not mod then return end
mod.displayName = CL.trash

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.quarry_camps_liberated = "Quarry Camps Liberated"
	L.quarry_camps_liberated_desc = "Show an alert when a quarry camp has been liberated."
	L.quarry_camps_liberated_icon = "inv_axe_2h_6miningpick"
end

--------------------------------------------------------------------------------
-- Locals
--

local lastText

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		"quarry_camps_liberated",
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Snitches Interrogated
	self:RegisterWidgetEvent(7520, "QuarryCampsLiberated", true)
end

function mod:OnBossDisable()
    lastText = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(136624) then -- Alliance Captive, Liberate Quarry Camp
			-- 136624:We've cleared the way.
			self:SelectGossipID(136624)
		elseif self:GetGossipID(136271) then -- Alliance Captive, Liberate Quarry Camp
			-- 136271:We've cleared the way.
			self:SelectGossipID(136271)
		elseif self:GetGossipID(136316) then -- Alliance Captive, Liberate Quarry Camp
			-- 136316:We've cleared the way.
			self:SelectGossipID(136316)
		elseif self:GetGossipID(136280) then -- Alliance Captive, Liberate Quarry Camp
			-- 136280:We've cleared the way.
			self:SelectGossipID(136280)
		elseif self:GetGossipID(136301) then -- Alliance Captive, Liberate Quarry Camp
			-- 136301:We've cleared the way.
			self:SelectGossipID(136301)
		elseif self:GetGossipID(138618) then -- Alliance Captive, Liberate Quarry Camp
			-- 138618:We've cleared the way.
			self:SelectGossipID(138618)
		end
	end
end

function mod:QuarryCampsLiberated(_, text)
    -- [UPDATE_UI_WIDGET] widgetID:7520, widgetType:8, widgetSetID:1, text:Quarry Camps Liberated: 1/6, tooltip:Save captive soldiers before confronting Scourgelord Tyrannus.
    if text ~= lastText then
        lastText = text
        self:Message("quarry_camps_liberated", "green", text, L.quarry_camps_liberated_icon)
        self:PlaySound("quarry_camps_liberated", "info")
    end
end
