--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Hour of Twilight Trash", 940)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	54548, -- Thrall (before first boss trash)
	55779, -- Thrall (first boss arena)
	54972, -- Thrall (before second boss trash)
	54634 -- Thrall (before third boss trash)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly select Thrall's gossip options."
	L.custom_on_autotalk_icon = "ui_chat"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Auto-gossip

function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_autotalk") then
		if self:GetGossipID(38993) then
			-- Thrall: Yes Thrall. (Begin first boss trash)
			self:SelectGossipID(38993)
		elseif self:GetGossipID(39796) then
			-- Thrall: Yes Thrall. (Begin first boss)
			self:SelectGossipID(39796)
		elseif self:GetGossipID(39657) then
			-- Thrall: Lead the way. (Leave first boss area)
			self:SelectGossipID(39657)
		elseif self:GetGossipID(39487) then
			-- Thrall: Yes Thrall, lets do this! (Begin second boss trash)
			self:SelectGossipID(39487)
		elseif self:GetGossipID(39155) then
			-- Thrall: Yes Thrall, lets do this! (Begin third boss trash)
			self:SelectGossipID(39155)
		end
	end
end
