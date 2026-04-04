--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Point Xenas Trash", 2915)
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_arcane_tripwire_autotalk = CL.autotalk
	L.custom_on_arcane_tripwire_autotalk_desc = "|cFFFF0000Requires 25 skill in Midnight Engineering.|r Automatically select the NPC dialog option to disable the Arcane Tripwire."
	L.custom_on_arcane_tripwire_autotalk_icon = mod:GetMenuIcon("SAY")

	L.arcane_tripwire = "Arcane Tripwire"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_arcane_tripwire_autotalk",
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_arcane_tripwire_autotalk") and self:GetGossipID(137133) then
		-- 137133:<You've recycled enough contraptions to recognize the tripwire's bypass.>\r\n[Requires at least 25 skill in Midnight Engineering.]
		self:SelectGossipID(137133)
	end
end
