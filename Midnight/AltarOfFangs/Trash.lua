--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altar of Fangs Trash", 2993)
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Localization
--

mod:SetDefaultLocale({
	custom_on_mixture_autotalk = CL.autotalk,
	custom_on_mixture_autotalk_desc = "|cFFFF0000Requires 25 skill in Midnight Cooking or Midnight Alchemy.|r Automatically select the NPC dialog option to gain the 'Mutating Elixir' buff.\n\n|T136242:16|tMutating Elixir\n{1310012}",
	custom_on_mixture_autotalk_icon = mod:GetMenuIcon("SAY"),
})

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1310012] = {1310012}, -- Mutating Elixir
})

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1306669, header = 261554, soundOnAppliedDose = "none", tip = CL.debuffHitByCastNote:format(mod:SpellName(1306668))}, -- Toxic Breath (Twinfang Harrower)
	{1294569, dispel = "magic", mechanic = "snared", soundOnAppliedDose = "none", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1294567))}, -- Paralyzing Shots (Twinfang Harrower)
	{1306232, header = 261550, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Septic Spatter (Venom Leech)
	{1306550, header = 270306, soundOnAppliedDose = "none", tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1306517))}, -- Blood Sacrifice (Ritual Chieftain)
	{1294845, header = 262011, soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1294845))}, -- Corrosive Fangs (Rattling Writhe)
	{1307531, header = 261552, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Bloodletting (Bloodletter)
	{1307571, header = 261557, dispel = "poison", soundOnAppliedDose = "none", tip = CL.debuffFailureInterruptNote:format(mod:SpellName(1289426))}, -- Envenom (High Evolutionist)
	{1308518, header = 271453, tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1308512))}, -- Laced Edge (Blade of the Altar)
	{1297422, header = mod:SpellName(1297422), tip = CL.debuffUnderYouNote}, -- Deadly Venom (environmental)
	{1308865, header = 261573, soundOnApplied = "alert", tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1308864))}, -- Infest (Ascendant Serpent)
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
