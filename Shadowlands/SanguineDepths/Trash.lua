
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sanguine Depths Trash", 2284)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	162057, -- Chamber Sentinel
	171799, -- Depths Warden
	171448, -- Dreadful Huntmaster
	162133, -- General Kaal
	162040, -- Grand Overseer
	171376, -- Head Custodian Javlin
	162047, -- Insatiable Brute
	162038, -- Regal Mistdancer
	171805, -- Research Scribe
	162049, -- Vestige of Doubt
	162039 -- Wicked Oppressor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.chamber_sentinel = "Chamber Sentinel"
	L.depths_warden = "Depths Warden"
	L.dreadful_huntmaster = "Dreadful Huntmaster"
	L.general_kaal = "General Kaal"
	L.grand_overseer = "Grand Overseer"
	L.head_custodian_javlin = "Head Custodian Javlin"
	L.insatiable_brute = "Insatiable Brute"
	L.regal_mistdancer = "Regal Mistdancer"
	L.research_scribe = "Research Scribe"
	L.vestige_of_doubt = "Vestige of Doubt"
	L.wicked_oppressor = "Wicked Oppressor"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Chamber Sentinel
		328170, -- Craggy Fracture
		322429, -- Severing Slice
		322433, -- Stoneskin
		-- Depths Warden
		335305, -- Barbed Shackles
		{335308, "TANK_HEALER"}, -- Crushing Strike
		-- Dreadful Huntmaster
		334558, -- Volatile Trap
		-- General Kaal
		327811, -- Blink Step
		324103, -- Gloom Squall
		324089, -- Z'rali's Essence
		324086, -- Shining Radiance
		-- Grand Overseer
		326827, -- Dread Bindings
		-- Head Custodian Javlin
		334329, -- Sweeping Slash
		{334326, "TANK_HEALER"}, -- Bludgeoning Bash
		-- Insatiable Brute
		{321178, "TANK_HEALER"}, -- Slam
		334918, -- Umbral Crash
		-- Regal Mistdancer
		320991, -- Echoing Thrust
		-- Research Scribe
		334377, -- Explosive Vellum
		-- Vestige of Doubt
		322169, -- Growing Mistrust
		-- Wicked Oppressor
		321038, -- Wrack Soul
		326836, -- Curse of Suppression
	}, {
		[328170] = L.chamber_sentinel,
		[335305] = L.depths_warden,
		[334558] = L.dreadful_huntmaster,
		[327811] = L.general_kaal,
		[326827] = L.grand_overseer,
		[334329] = L.head_custodian_javlin,
		[321178] = L.insatiable_brute,
		[320991] = L.regal_mistdancer,
		[334377] = L.research_scribe,
		[322169] = L.vestige_of_doubt,
		[321038] = L.wicked_oppressor,
	}
end

function mod:OnBossEnable()
		-- Chamber Sentinel
		self:Log("SPELL_CAST_", "CraggyFracture", 328170) -- Craggy Fracture
		self:Log("SPELL_CAST_", "SeveringSlice", 322429) -- Severing Slice
		self:Log("SPELL_CAST_", "Stoneskin", 322433) -- Stoneskin
		-- Depths Warden
		self:Log("SPELL_CAST_", "BarbedShackles", 335305) -- Barbed Shackles
		self:Log("SPELL_CAST_", "CrushingStrike", 335308) -- Crushing Strike
		-- Dreadful Huntmaster
		self:Log("SPELL_CAST_", "VolatileTrap", 334558) -- Volatile Trap
		-- General Kaal
		self:Log("SPELL_CAST_", "BlinkStep", 327811) -- Blink Step
		self:Log("SPELL_CAST_", "GloomSquall", 324103) -- Gloom Squall
		self:Log("SPELL_CAST_", "ZralisEssence", 324089) -- Z'rali's Essence
		self:Log("SPELL_CAST_", "ShiningRadiance", 324086) -- Shining Radiance
		-- Grand Overseer
		self:Log("SPELL_CAST_", "DreadBindings", 326827) -- Dread Bindings
		-- Head Custodian Javlin
		self:Log("SPELL_CAST_", "SweepingSlash", 334329) -- Sweeping Slash
		self:Log("SPELL_CAST_", "BludgeoningBash", 334326) -- Bludgeoning Bash
		-- Insatiable Brute
		self:Log("SPELL_CAST_", "Slam", 321178) -- Slam
		self:Log("SPELL_CAST_", "UmbralCrash", 334918) -- Umbral Crash
		-- Regal Mistdancer
		self:Log("SPELL_CAST_", "EchoingThrust", 320991) -- Echoing Thrust
		-- Research Scribe
		self:Log("SPELL_CAST_", "ExplosiveVellum", 334377) -- Explosive Vellum
		-- Vestige of Doubt
		self:Log("SPELL_CAST_", "GrowingMistrust", 322169) -- Growing Mistrust
		-- Wicked Oppressor
		self:Log("SPELL_CAST_", "WrackSoul", 321038) -- Wrack Soul
		self:Log("SPELL_CAST_", "CurseOfSuppression", 326836) -- Curse of Suppression
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Chamber Sentinel

-- Depths Warden

-- Dreadful Huntmaster

-- General Kaal

-- Grand Overseer

-- Head Custodian Javlin

-- Insatiable Brute

-- Regal Mistdancer

-- Research Scribe

-- Vestige of Doubt

-- Wicked Oppressor

