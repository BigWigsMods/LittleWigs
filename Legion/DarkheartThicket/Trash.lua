--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkheart Thicket Trash", 1067)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95771,  -- Dreadsoul Ruiner
	95766,  -- Crazed Razorbeak
	95779,  -- Festerhide Grizzly
	100531, -- Bloodtainted Fury
	113398, -- Bloodtainted Fury
	100527  -- Dreadfire Imp
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.ruiner = "Dreadsoul Ruiner"
	L.razorbeak = "Crazed Razorbeak"
	L.grizzly = "Festerhide Grizzly"
	L.fury = "Bloodtainted Fury"
	L.imp = "Dreadfire Imp"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Dreadsoul Ruiner
		200658, -- Star Shower

		-- Crazed Razorbeak
		200768, -- Propelling Charge

		-- Festerhide Grizzly
		200580, -- Maddening Roar

		-- Bloodtainted Fury
		201226, -- Blood Assault
		201272, -- Blood Bomb

		-- Dreadfire Imp
		201399, -- Dread Inferno
	}, {
		[200658] = L.ruiner,
		[200768] = L.razorbeak,
		[200580] = L.grizzly,
		[201226] = L.fury,
		[201399] = L.imp,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	-- Dreadsoul Ruiner
	self:Log("SPELL_CAST_START", "StarShower", 200658)

	-- Crazed Razorbeak
	self:Log("SPELL_CAST_START", "PropellingCharge", 200768)

	-- Festerhide Grizzly
	self:Log("SPELL_CAST_START", "MaddeningRoar", 200580)

	-- Bloodtainted Fury
	self:Log("SPELL_CAST_START", "BloodAssault", 201226)
	self:Log("SPELL_CAST_SUCCESS", "BloodBomb", 201272)

	-- Dreadfire Imp
	self:Log("SPELL_CAST_START", "DreadInferno", 201399)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dreadsoul Ruiner
function mod:StarShower(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

-- Crazed Razorbeak
function mod:PropellingCharge(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Bloodtainted Fury
function mod:BloodAssault(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Bloodtainted Fury
function mod:BloodBomb(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Dreadfire Imp
function mod:DreadInferno(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end