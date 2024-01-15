--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kin-Tara", 2285, 2399)
if not mod then return end
mod:RegisterEnableMob(162059, 163077) -- Kin-Tara, Azules
mod:SetEncounterID(2357)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{320966, "TANK_HEALER"}, -- Overhead Slash
		{327481, "DISPEL"}, -- Dark Lance
		{321009, "ICON", "SAY", "SAY_COUNTDOWN", "CASTBAR"}, -- Charged Spear
		324368, -- Attenuated Barrage
		331251, -- Deep Connection
	}, {
		["stages"] = CL.general,
		[320966] = -21637, -- Kin-Tara
		[324368] = -21639, -- Azules
		[331251] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "OverheadSlash", 320966)
	self:Log("SPELL_CAST_SUCCESS", "DarkLanceSuccess", 327481)
	self:Log("SPELL_AURA_APPLIED", "DarkLanceApplied", 327481)
	self:Log("SPELL_CAST_START", "AttenuatedBarrage", 324368)

	self:Log("SPELL_AURA_APPLIED", "DeepConnection", 331251)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DeepConnection", 331251)

	self:Log("SPELL_AURA_APPLIED", "IonizedPlasma", 324662) -- Periodic damage from Charged Spear
	self:Log("SPELL_PERIODIC_DAMAGE", "IonizedPlasma", 324662)
	self:Log("SPELL_PERIODIC_MISSED", "IonizedPlasma", 324662)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2") -- Charged Spear

	-- Stage detection
	if self:Mythic() then
		self:Log("SPELL_AURA_APPLIED", "IntermissionOver", 331249) -- Deep Connection
		self:Log("SPELL_AURA_REMOVED", "Intermission", 331249)
	else
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	end
end

function mod:OnEngage()
	self:Bar(327481, 9.7) -- Dark Lance

	if not self:Mythic() then
		-- Call it manually because there's no Deep Connection on Normal and Heroic:
		self:IntermissionOver()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function startTimers(self, offset)
		self:StopBar(324368) -- Attenuated Barrage
		self:StopBar(320966) -- Overhead Slash
		self:StopBar(327481) -- Dark Lance

		self:CDBar(321009, 3.6 + offset) -- Charged Spear (timers are very inconsistent for this one)
		self:CDBar("stages", 22 + offset, CL.over:format(CL.intermission), "inv_sword_01")
	end

	function mod:Intermission()
		startTimers(self, 0)
	end

	function mod:CHAT_MSG_MONSTER_YELL(_, _, source, _, _, target)
		if source == target then -- Intermission (or a wipe, or someone with the same name on koKR where it doesn't have a hyphen)
			startTimers(self, -0.2)
			self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1") -- Power resets to 0 at the end of the intermission
		end
	end
end

function mod:IntermissionOver()
	self:StopBar(321009) -- Charged Spear

	self:Bar(324368, 6) -- Attenuated Barrage
	self:CDBar(320966, 7.3) -- Overhead Slash
	self:Bar("stages", 30.3, CL.intermission, "inv_icon_wing06a")
end

function mod:UNIT_POWER_FREQUENT(event, unit, powerType)
	if powerType == "ENERGY" and UnitPower(unit, 3) == 0 then -- ENERGY = 3
		self:UnregisterUnitEvent(event, unit)
		self:IntermissionOver()
	end
end

function mod:OverheadSlash(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 9.7)
end

function mod:DarkLanceSuccess(args)
	self:CDBar(args.spellId, 51.4)
end

do
	local playerList = mod:NewTargetList()
	function mod:DarkLanceApplied(args)
		if self:Dispeller("magic", nil, args.spellId) then
			playerList[#playerList+1] = args.destName
			self:TargetsMessageOld(args.spellId, "orange", playerList, 2)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		elseif self:Me(args.destGUID) then
			self:PersonalMessage(args.spellId)
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Charged Spear:
do
	-- UNIT_SPELLCAST_SUCCEEDED happens 1.2s before the real cast,
	-- CHAT_MSG_RAID_BOSS_EMOTE - happens 1.0s before.
	--
	-- The cast itself is 0.5s long, so an early warning helps quite a bit.
	--
	-- When she starts flying, she clears her current target.
	-- The sequence for this ability is:
	-- -1.21s UNIT_TARGET -> a player (sometimes this one is missing)
	-- -1.20s UNIT_SPELLCAST_SUCCEEDED (321088)
	-- -1.17s UNIT_TARGET -> empty target
	-- -1.00s CHAT_MSG_RAID_BOSS_EMOTE
	-- +0.00s SPELL_CAST_START + UNIT_SPELLCAST_START (321009)
	-- +0.00s UNIT_TARGET -> a player
	-- +0.50s SPELL_CAST_SUCCESS + UNIT_SPELLCAST_SUCCEEDED (321009)
	-- +1.50s UNIT_SPELLCAST_SUCCEEDED (324662)
	local function printTarget(self, destName, offset)
		self:TargetMessage(321009, "yellow", destName)
		self:PlaySound(321009, "alert", nil, destName)
		self:CastBar(321009, 2.7 + offset) -- Targetting + actual cast + travel time (it's constant)
		self:CDBar(321009, 10.9 + offset)
		self:PrimaryIcon(321009, destName)

		local guid = self:UnitGUID(destName)
		if self:Me(guid) then
			self:Say(321009, nil, nil, "Charged Spear")
			self:SayCountdown(321009, 2.7 + offset, nil, 2)
		end
	end

	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
		if spellId == 321088 then -- Charged Spear (targetting)
			local destName = self:UnitName(unit.."target")
			if destName and not self:Tanking(unit, destName) then
				printTarget(self, destName, 0)
			else
				self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
			end
		elseif spellId == 321009 then -- Charged Spear (thrown)
			self:UnregisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
		elseif spellId == 324662 then -- Ionized Plasma (Charged Spear landed)
			self:PrimaryIcon(321009)
		end
	end

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(event, _, _, _, _, destName)
		self:UnregisterEvent(event)
		printTarget(self, destName, -0.2)
	end
end

do
	local prev = 0
	function mod:IonizedPlasma(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(321009, "underyou", args.spellName, args.spellId)
				self:PlaySound(321009, "underyou")
			end
		end
	end
end

do
	local prev = 0
	function mod:AttenuatedBarrage(args)
		local t = args.time
		if t - prev > 5 then -- 3 casts, long cooldown, repeat
			prev = t
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "long")
			self:CDBar(args.spellId, 11) -- depends on how long it takes for Azules to move to a new location
		end
	end
end

function mod:DeepConnection(args)
	local stacks = args.amount or 1
	if self:Me(args.destGUID) and stacks % 2 == 1 then
		self:StackMessageOld(args.spellId, args.destName, stacks, "red")
		self:PlaySound(args.spellId, stacks > 4 and "warning" or "alert")
	end
end
