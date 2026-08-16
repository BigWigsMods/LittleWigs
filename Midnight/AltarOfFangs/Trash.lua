--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altar of Fangs Trash", 2993)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1306669}, -- Toxic Breath
	{1294569}, -- Paralyzing Shots
	{1306232, soundOnApplied = "underyou"}, -- Septic Spatter
	{1306550}, -- Blood Sacrifice
	{1294845}, -- Corrosive Fangs
	{1307531, soundOnApplied = "underyou"}, -- Bloodletting
	{1307571}, -- Envenom
	{1308518}, -- Laced Edge
	{1297422}, -- Deadly Venom
	{1308865, soundOnApplied = "alert"}, -- Infest
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
