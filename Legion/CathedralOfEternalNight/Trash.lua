
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cathedral of Eternal Night Trash", 1146)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	119952, -- Felguard Destroyer
	119923, -- Helblaze Soulmender
	118703, -- Felborne Botanist
	118714, -- Hellblaze Temptress
	118713, -- Felstrider Orbcaster
	120713 -- Wa'glur
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.felguard = "Felguard Destroyer"
	L.soulmender = "Helblaze Soulmender"
	L.temptress = "Hellblaze Temptress"
	L.hulk = "Vileshard Hulk"
	L.orbcaster = "Felstrider Orbcaster"
	L.waglur = "Wa'glur"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Felguard Destroyer
		241598, -- Shadow Wall
		-- Helblaze Soulmender
		238543, -- Demonic Mending
		-- Felborne Botanist
		237565, -- Blistering Rain
		-- Hellblaze Temptress
		237391, -- Alluring Aroma
		-- Felstrider Orbcaster
		239320, -- Felblaze Orb
		-- Wa'glur
		241772, -- Unearthy Howl
	}, {
		[241598] = L.felguard,
		[238543] = L.soulmender,
		[237565] = L.temptress,
		[237391] = L.hulk,
		[239320] = L.orbcaster,
		[241772] = L.waglur,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "ShadowWall", 241598) -- Shadow Wall
	self:Log("SPELL_CAST_START", "DemonicMending", 238543) -- Demonic Mending
	self:Log("SPELL_CAST_START", "BlisteringRain", 237565) -- Blistering Rain
	self:Log("SPELL_CAST_START", "AlluringAroma", 237391) -- Alluring Aroma
	self:Log("SPELL_CAST_START", "FelblazeOrb", 239320) -- Felblaze Orb
	self:Log("SPELL_CAST_START", "UnearthyHowl", 241772) -- Unearthy Howl
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Felguard Destroyer
function mod:ShadowWall(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

-- Helblaze Soulmender
function mod:DemonicMending(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Felborne Botanist
function mod:BlisteringRain(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

-- Hellblaze Temptress
function mod:AlluringAroma(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Felstrider Orbcaster
function mod:FelblazeOrb(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Wa'glur
function mod:UnearthyHowl(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end
