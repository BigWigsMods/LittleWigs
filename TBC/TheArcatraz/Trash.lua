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
		{38903, "PROXIMITY"}, -- Meteor
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

	self:Log("SPELL_AURA_APPLIED", "Hex", 38903)

	self:Log("SPELL_CAST_START", "SightlessTouch", 36646, 38815) -- normal, heroic

	self:Log("SPELL_AURA_APPLIED", "SoulStealDebuff", 36778)
	self:Log("SPELL_AURA_APPLIED", "SoulStealBuff", 36782)

	self:Log("SPELL_AURA_APPLIED", "Domination", 36866)
	self:Log("SPELL_AURA_APPLIED", "SpitefulFury", 36886)

	self:Log("SPELL_AURA_REMOVED", "DebuffRemoved", 36778, 36866, 36886) -- Soul Steal, Domination, Spiteful Fury

	self:Log("SPELL_CAST_START", "Meteor", 38903)
	self:Log("SPELL_CAST_SUCCESS", "MeteorSuccess", 38903)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	-- One of the randomly chosen debuffs that apply to people being hit by Chaos Breath (36677), so there's a chance of multiple people getting it.
	local playerList = mod:NewTargetList()
	function mod:Hex(args)
		playerList[#playerList + 1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Urgent", "Alert", nil, nil, self:Dispeller("magic"))
		end
	end
end

do
	local prev = 0
	function mod:SightlessTouch(args)
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:Message(38815, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
		end
	end
end

function mod:SoulStealDebuff(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm", nil, nil, true)
		self:TargetBar(args.spellId, 20, args.destName)
	end
end

function mod:SoulStealBuff(args)
	if self:Dispeller("magic", true) and not self:Dispeller("magic") then -- Only show 1 message to those who can dispel both (priests, restoration shamans)
		self:TargetMessage(36778, args.destName, "Attention", "Alarm", nil, nil, true)
	end
end

function mod:Domination(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Warning", nil, nil, true)
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:SpitefulFury(args)
	if self:Me(args.destGUID) or self:Tank() or self:Healer() then
		self:TargetMessage(args.spellId, args.destName, "Urgent", "Long", nil, nil, true)
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:DebuffRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

do
	local prev, meteorsGoingOff = 0, 0
	function mod:Meteor(args)
		meteorsGoingOff = meteorsGoingOff + 1 -- just in case both Abyssals are pulled
		if meteorsGoingOff == 1 then
			self:OpenProximity(args.spellId, 10) -- not possible to detect its target, no helpful visual circle either
		end

		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
		end
		self:Bar(args.spellId, 2)
	end

	function mod:MeteorSuccess(args)
		meteorsGoingOff = meteorsGoingOff - 1
		if meteorsGoingOff == 0 then
			self:CloseProximity(args.spellId)
		end
	end
end
