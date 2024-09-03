
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vault of the Wardens Trash", 1493)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	96587, -- Felsworn Infester
	98954, -- Felsworn Myrmidon
	99956, -- Fel-Infused Fury
	98533, -- Foul Mother
	96657, -- Blade Dancer Illianna
	99649, -- Dreadlord Mendacius
	102566 -- Grimhorn the Enslaver
)

--------------------------------------------------------------------------------
-- Locals
--

local tormentOnMe = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.infester = "Felsworn Infester"
	L.myrmidon = "Felsworn Myrmidon"
	L.fury = "Fel-Infused Fury"
	L.mother = "Foul Mother"
	L.illianna = "Blade Dancer Illianna"
	L.mendacius = "Dreadlord Mendacius"
	L.grimhorn = "Grimhorn the Enslaver"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Felsworn Infester ]]--
		{193069, "SAY"}, -- Nightmares

		--[[ Felsworn Myrmidon ]]--
		191735, -- Deafening Screech

		--[[ Fel-Infused Fury ]]--
		{196799, "FLASH"}, -- Unleash Fury
		196796, -- Fel Gaze

		--[[ Foul Mother ]]--
		210202, -- Foul Stench
		194071, -- A Mother's Love

		--[[ Blade Dancer Illianna ]]--
		191527, -- Deafening Shout
		193164, -- Gift of the Doomsayer

		--[[ Dreadlord Mendacius ]]--
		196249, -- Meteor

		--[[ Grimhorn the Enslaver ]]--
		{202615, "SAY"}, -- Torment
		202607, -- Anguished Souls
	}, {
		[193069] = L.infester,
		[191735] = L.myrmidon,
		[196799] = L.fury,
		[210202] = L.mother,
		[191527] = L.illianna,
		[196249] = L.mendacius,
		[202615] = L.grimhorn,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[[ Felsworn Infester ]]--
	self:Log("SPELL_CAST_START", "NightmaresCast", 193069)
	self:Log("SPELL_AURA_APPLIED", "NightmaresApplied", 193069)

	--[[ Felsworn Myrmidon ]]--
	self:Log("SPELL_CAST_START", "DeafeningScreech", 191735)

	--[[ Fel-Infused Fury ]]--
	self:Log("SPELL_CAST_START", "UnleashFury", 196799)
	self:Log("SPELL_CAST_START", "FelGaze", 196796)

	--[[ Foul Mother ]]--
	self:Log("SPELL_AURA_APPLIED", "GroundEffectDamage", 210202, 194071) -- Foul Stench, A Mother's Love
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 210202, 194071)
	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 210202, 194071)

	--[[ Blade Dancer Illianna ]]--
	self:Log("SPELL_CAST_START", "DeafeningShout", 191527)
	self:Log("SPELL_AURA_APPLIED", "GiftOfTheDoomsayer", 193164)

	--[[ Dreadlord Mendacius ]]--
	self:Log("SPELL_CAST_START", "Meteor", 196249)

	--[[ Grimhorn the Enslaver ]]--
	self:Log("SPELL_AURA_APPLIED", "Torment", 202615)
	self:Log("SPELL_AURA_REMOVED", "TormentRemoved", 202615)
	self:Log("SPELL_AURA_APPLIED", "AnguishedSouls", 202607) -- Anguished Souls
	self:Log("SPELL_PERIODIC_DAMAGE", "AnguishedSouls", 202607)
	self:Log("SPELL_PERIODIC_MISSED", "AnguishedSouls", 202607)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

--[[ Felsworn Infester ]]--
function mod:NightmaresCast(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "info", CL.casting:format(args.spellName))
end

function mod:NightmaresApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", self:Healer() and "alarm")
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Nightmares")
	end
end

--[[ Felsworn Myrmidon ]]--
function mod:DeafeningScreech(args)
	self:MessageOld(args.spellId, "red", self:Ranged() and "alert", CL.casting:format(args.spellName))
end

--[[ Fel-Infused Fury ]]--
function mod:UnleashFury(args)
	self:MessageOld(args.spellId, "yellow", "alarm", CL.casting:format(args.spellName))
	if self:Interrupter(args.sourceGUID) then
		self:Flash(args.spellId)
	end
end

do
	local prev = 0
	function mod:FelGaze(args)
		local t = GetTime()
		if t-prev > 0.5 then
			prev = t
			self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
		end
	end
end

--[[ Foul Mother ]]--
do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

--[[ Blade Dancer Illianna ]]--
function mod:DeafeningShout(args)
	self:MessageOld(args.spellId, "red", self:Ranged() and "alert", CL.casting:format(args.spellName))
end

function mod:GiftOfTheDoomsayer(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
	end
end

--[[ Dreadlord Mendacius ]]--
function mod:Meteor(args)
	self:MessageOld(args.spellId, "orange", "alarm", CL.incoming:format(args.spellName))
end

--[[ Grimhorn the Enslaver ]]--
function mod:Torment(args)
	if self:Me(args.destGUID) then
		tormentOnMe = true
		self:Say(args.spellId, nil, nil, "Torment")
	end
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:TormentRemoved(args)
	if self:Me(args.destGUID) then
		tormentOnMe = false
	end
end

do
	local prev = 0
	function mod:AnguishedSouls(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			-- Increased throttle if the player can't move due to having Torment
			if t-prev > (tormentOnMe and 6 or 1.5) then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
