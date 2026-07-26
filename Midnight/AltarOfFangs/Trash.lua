if not BigWigsLoader.isNext then return end -- XXX 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altar of Fangs Trash", 2993)
if not mod then return end
mod:SetTrashModule(true)
mod:SetPrivateAuraSounds({
	{1306232, sound = "underyou"}, -- Septic Spatter
	{1307531, sound = "underyou"}, -- Bloodletting
	{1297422, sound = "none"}, -- Deadly Venom
	{1308865, sound = "alert"}, -- Infest
})

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_mixture_autotalk = CL.autotalk
	L.custom_on_mixture_autotalk_desc = "|cFFFF0000Requires 25 skill in Midnight Cooking or Midnight Alchemy.|r Automatically select the NPC dialog option to gain the 'Mutating Elixir' buff.\n\n|T136242:16|tMutating Elixir\n{1310012}"
	L.custom_on_mixture_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1310012] = {1310012}, -- Mutating Elixir
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_mixture_autotalk",
		1310012, -- Mutating Elixir
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_mixture_autotalk") and self:GetGossipID(141730) then
		-- 141730:<Carefully complete the mixture.> \r\n[Requires at least 25 skill in Midnight Cooking or Midnight Alchemy.]
		self:SelectGossipID(141730)
		self:Message(1310012, "green", CL.on_group:format(self:SpellName(1310012)))
		self:PlaySound(1310012, "info")
	end
end
