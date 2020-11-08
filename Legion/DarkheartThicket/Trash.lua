--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkheart Thicket Trash", 1466)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95771, -- Dreadsoul Ruiner
	101679, -- Dreadsoul Poisoner
	95766, -- Crazed Razorbeak
	95779, -- Festerhide Grizzly
	100531, -- Bloodtainted Fury
	113398, -- Bloodtainted Fury
	100527 -- Dreadfire Imp
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ruiner = "Dreadsoul Ruiner"
	L.poisoner = "Dreadsoul Poisoner"
	L.razorbeak = "Crazed Razorbeak"
	L.grizzly = "Festerhide Grizzly"
	L.fury = "Bloodtainted Fury"
	L.imp = "Dreadfire Imp"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Dreadsoul Ruiner ]]--
		200658, -- Star Shower

		--[[ Dreadsoul Poisoner ]]--
		{200684, "SAY", "SAY_COUNTDOWN"}, -- Nightmare Toxin

		--[[ Crazed Razorbeak ]]--
		200768, -- Propelling Charge

		--[[ Festerhide Grizzly ]]--
		200580, -- Maddening Roar
		218759, -- Corruption Pool

		--[[ Bloodtainted Fury ]]--
		201226, -- Blood Assault
		201272, -- Blood Bomb
		225562, -- Blood Metamorphosis

		--[[ Dreadfire Imp ]]--
		201399, -- Dread Inferno
	}, {
		[200658] = L.ruiner,
		[200684] = L.poisoner,
		[200768] = L.razorbeak,
		[200580] = L.grizzly,
		[201226] = L.fury,
		[201399] = L.imp,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[[ Dreadsoul Ruiner, Dreadfire Imp ]]--
	self:Log("SPELL_CAST_START", "Interrupts", 200658, 201399) -- Star Shower, Dread Inferno

	--[[ Dreadsoul Poisoner ]]--
	self:Log("SPELL_AURA_APPLIED", "NightmareToxinApplied", 200684)
	self:Log("SPELL_AURA_REMOVED", "NightmareToxinRemoved", 200684)

	--[[ Crazed Razorbeak, Festerhide Grizzly ]]--
	self:Log("SPELL_CAST_START", "Casts", 200768, 200580, 201226, 225562) -- Propelling Charge, Maddening Roar, Blood Assault, Blood Metamorphosis

	--[[ Bloodtainted Fury ]]--
	self:Log("SPELL_CAST_SUCCESS", "BloodBomb", 201272)

	--[[ Festerhide Grizzly ]]--
	self:Log("SPELL_AURA_APPLIED", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_MISSED", "CorruptionPool", 218759)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevTable = {}
	-- Dreadsoul Ruiner, Dreadfire Imp
	function mod:Interrupts(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
		end
	end

	-- Crazed Razorbeak, Festerhide Grizzly, Bloodtainted Fury
	function mod:Casts(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
		end
	end
end

function mod:NightmareToxinApplied(args)
	if self:Me(args.destGUID) and self:MythicPlus() then -- avoid spamming in trivial difficulties
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 3, nil, 2)
	end
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert", nil, nil, self:Dispeller("poison"))
	self:TargetBar(args.spellId, 3, args.destName)
end

function mod:NightmareToxinRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
	self:StopBar(args.spellId, args.destName)
end

-- Festerhide Grizzly
do
	local prev = 0
	function mod:CorruptionPool(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "warning", CL.underyou:format(args.spellName))
			end
		end
	end
end

-- Bloodtainted Fury
function mod:BloodBomb(args)
	self:MessageOld(args.spellId, "orange", "alert")
end
