--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidscar Arena Trash", 2923)
if not mod then return end
mod:SetTrashModule(true)

--------------------------------------------------------------------------------
-- Auras
--

mod:SetAuraData({
	{1267894, header = 243988, dispel = "bleed", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1267894))}, -- Savage Leap (Feral Saberon)
	{1298899, header = 238883, soundOnAppliedDose = "none", tip = CL.debuffFailureInterruptNote:format(mod:SpellName(1298899))}, -- Demoralizing Shout (Dominated Brawler)
	{1249712, header = 243996, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Venomous Spit (Lost Sethrak)
	{1298922, header = 267545, tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1298933))}, -- Savage Smash (Aegyra the Unyielding)
	{1298917, tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1298908))}, -- Champion's Spear (Aegyra the Unyielding)
	{1299210, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Aftershock (Aegyra the Unyielding)
	{1299133, header = 267546, dispel = "bleed", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1299133))}, -- Ferocious Leap (Raj'kess the Spellstorm)
	{1299913, header = 252072, soundOnApplied = "alarm", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1299913))}, -- Null Eruption (Voidtouched Magi)
	{1234833, header = 244260, soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Ravenous Swarm (Chitigoth)
	{1250043, header = 243983, dispel = "magic", soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1250043))}, -- Melt Armor (Sycophantic Tarasek)
	{1249238, header = 249461, dispel = "magic", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1249238))}, -- Fire Spit (Abducted Drakonid)
	{1249621, header = 249590, tip = CL.debuffFailureInterruptNote:format(mod:SpellName(1249621))}, -- Violent Sand (Angry Krolusk)
	{1233535, header = 243835, soundOnAppliedDose = "none", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1233535))}, -- Shred Defense (Savage Shredclaw)
	{1233398, header = 243766, soundOnApplied = "warning", tip = CL.debuffFailureInterruptNote:format(mod:SpellName(1233398))}, -- Mad Shriek (Kilivore Screamer)
	{1310309, header = 252053, tip = CL.debuffTargetedNote:format(mod:SpellName(1310309))}, -- Macestorm (Brutal Overseer)
	{1289258, header = 263228, dispel = "poison", soundOnAppliedDose = "none", tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1289258))}, -- Corrosive Essence (Agitated Voidscythe)
	{1311778, dispel = "bleed", tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1311778))}, -- Rip and Slice (Agitated Voidscythe)
	{458835, header = mod:SpellName(458835), soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Toxic Sludge (environmental)
	{456057, header = mod:SpellName(456057), soundOnApplied = "underyou", tip = CL.debuffUnderYouNote}, -- Vile Putrescence (environmental)
	{1300138, header = 245950, tip = CL.debuffPossibleAfterCastNote:format(mod:SpellName(1300138))}, -- Void Beam (Watchful Harrower)
	{1252406, header = 268184, tip = CL.debuffGroupAfterCastNote:format(mod:SpellName(1252406))}, -- Dreadbellow (Devouring Brutalizer)
	{1300243, tip = CL.debuffTankAfterCastNote:format(mod:SpellName(1300243))}, -- Brutalize (Devouring Brutalizer)
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	}
end
