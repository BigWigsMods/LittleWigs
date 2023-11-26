--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Arcatraz Trash", 552)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	20868, -- Entropic Eye
	21346, -- Sightless Eye
	20879, -- Eredar Soul-Eater
	20883, -- Spiteful Temptress
	20898 -- Gargantuan Abyssal
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.entropic_eye = "Entropic Eye"
	L.sightless_eye = "Sightless Eye"
	L.soul_eater = "Eredar Soul-Eater"
	L.temptress = "Spiteful Temptress"
	L.abyssal = "Gargantuan Abyssal"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Entropic Eye ]]--
		36700, -- Hex
		--[[ Sightless Eye ]]--
		38815, -- Sightless Touch
		--[[ Eredar Soul-Eater ]]--
		36778, -- Soul Steal
		--[[ Spiteful Temptress ]]--
		36866, -- Domination
		36886, -- Spiteful Fury
		--[[ Gargantuan Abyssal ]]--
		38903, -- Meteor
	}, {
		[36700] = L.entropic_eye,
		[38815] = L.sightless_eye,
		[36778] = L.soul_eater,
		[36866] = L.temptress,
		[38903] = L.abyssal,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_AURA_APPLIED", "Hex", 36700)

	self:Log("SPELL_CAST_START", "SightlessTouch", 36646, 38815) -- normal, heroic

	self:Log("SPELL_AURA_APPLIED", "SoulStealDebuff", 36778)
	self:Log("SPELL_AURA_APPLIED", "SoulStealBuff", 36782)

	self:Log("SPELL_AURA_APPLIED", "Domination", 36866)
	self:Log("SPELL_AURA_APPLIED", "SpitefulFury", 36886)

	self:Log("SPELL_AURA_REMOVED", "DebuffRemoved", 36778, 36866, 36886) -- Soul Steal, Domination, Spiteful Fury

	self:Log("SPELL_CAST_START", "Meteor", 38903)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	-- One of the randomly chosen debuffs that apply to people being hit by Chaos Breath (36677), so there's a chance of multiple people getting it.
	local playerList = mod:NewTargetList()
	function mod:Hex(args)
		if not self:Player(args.destFlags) then return end -- filter out pets
		playerList[#playerList + 1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "orange", "alert", nil, nil, self:Dispeller("magic"))
		end
	end
end

do
	local prev = 0
	function mod:SightlessTouch(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:MessageOld(38815, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
		end
	end
end

function mod:SoulStealDebuff(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 20, args.destName)
	end
end

function mod:SoulStealBuff(args)
	if self:Dispeller("magic", true) and not self:Dispeller("magic") then -- Only show 1 message to those who can dispel both (priests, restoration shamans)
		self:TargetMessageOld(36778, args.destName, "yellow", "alarm", nil, nil, true)
	end
end

function mod:Domination(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning", nil, nil, true)
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:SpitefulFury(args)
	if self:Me(args.destGUID) or self:Tank() or self:Healer() then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "long", nil, nil, true)
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:DebuffRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

do
	local prev = 0
	function mod:Meteor(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:MessageOld(args.spellId, "red", "warning", CL.incoming:format(args.spellName))
		end
		self:Bar(args.spellId, 2)
	end
end
