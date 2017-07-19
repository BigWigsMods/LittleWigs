--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkheart Thicket Trash", 1067)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95771, -- Dreadsoul Ruiner
	95766, -- Crazed Razorbeak
	95779, -- Festerhide Grizzly
	100531, -- Bloodtainted Fury
	113398, -- Bloodtainted Fury
	100527 -- Dreadfire Imp
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
		--[[ Dreadsoul Ruiner ]]--
		200658, -- Star Shower

		--[[ Crazed Razorbeak ]]--
		200768, -- Propelling Charge

		--[[ Festerhide Grizzly ]]--
		200580, -- Maddening Roar
		218759, -- Corruption Pool

		--[[ Bloodtainted Fury ]]--
		201226, -- Blood Assault
		201272, -- Blood Bomb

		--[[ Dreadfire Imp ]]--
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

	--[[ Dreadsoul Ruiner, Dreadfire Imp ]]--
	self:Log("SPELL_CAST_START", "Interrupts", 200658, 201399)

	--[[ Crazed Razorbeak, Festerhide Grizzly ]]--
	self:Log("SPELL_CAST_START", "Casts", 200768, 200580)

	--[[ Bloodtainted Fury ]]--
	self:Log("SPELL_CAST_START", "BloodBombAssault", 201226, 201272) -- Blood Assault, Blood Bomb

	--[[ Festerhide Grizzly ]]--
	self:Log("SPELL_AURA_APPLIED", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_MISSED", "CorruptionPool", 218759)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Dreadsoul Ruiner, Dreadfire Imp
function mod:Interrupts(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

-- Crazed Razorbeak, Festerhide Grizzly, Bloodtainted Fury
function mod:Casts(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Festerhide Grizzly
do
	local prev = 0
	function mod:CorruptionPool(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Warning", CL.underyou:format(args.spellName))
		end
	end
end

-- Bloodtainted Fury
function mod:BloodBombAssault(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end
