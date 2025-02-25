if select(4, GetBuildInfo()) < 110100 then return end -- XXX only load in Season 2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Underpin Rares", {2664, 2679, 2680, 2681, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2815, 2826}) -- All Delves
if not mod then return end
mod:RegisterEnableMob(
	-- TWW Season 2, standard rares
	236886, -- Hovering Menace
	236892, -- Treasure Crab
	236895, -- Malfunctioning Pummeler
	-- TWW Season 2, Underpin rares
	234900, -- Underpin's Adoring Fan
	234901, -- Underpin's Well-Connected Friend
	234902, -- Underpin's Explosive Ally
	234904, -- Underpin's Bodyguard's Intern
	234905 -- Aggressively Lost Hobgoblin
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rares = "Underpin Rares"

	L.hovering_menace = "Hovering Menace"
	L.treasure_crab = "Treasure Crab"
	L.malfunctioning_pummeler = "Malfunctioning Pummeler"
	L.underpins_adoring_fan = "Underpin's Adoring Fan"
	L.underpins_well_connected_friend = "Underpin's Well-Connected Friend"
	L.underpins_explosive_ally = "Underpin's Explosive Ally"
	L.underpins_bodyguards_intern = "Underpin's Bodyguard's Intern"
	L.aggressively_lost_hobgoblin = "Aggressively Lost Hobgoblin"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.rares
end

function mod:GetOptions()
	return {
		-- Hovering Menace
		{1216790, "NAMEPLATE"}, -- Forward Charge
		{1216794, "NAMEPLATE"}, -- Alpha Cannon
		-- Treasure Crab
		{1214246, "NAMEPLATE"}, -- Crushing Pinch
		{1214238, "NAMEPLATE"}, -- Harden Shell
		-- Malfunctioning Pummeler
		{1216805, "NAMEPLATE"}, -- Zap!
		{1216806, "NAMEPLATE"}, -- There's the Door
		-- Underpin's Adoring Fan
		{1217361, "NAMEPLATE"}, -- Worthless Adorations
		{1217326, "NAMEPLATE"}, -- Take a Selfie!
		-- Underpin's Well-Connected Friend
		433045, -- Backstab
		{1217418, "NAMEPLATE"}, -- Call My Agent
		{1217449, "NAMEPLATE"}, -- Call My Broker
		{1217452, "NAMEPLATE"}, -- Call My Mother
		{1217510, "NAMEPLATE"}, -- Speed Dialing
		-- Underpin's Explosive Ally
		{1218061, "NAMEPLATE"}, -- Gold Fuse
		{1218017, "NAMEPLATE"}, -- Crab-a-bomb Barrage
		1218039, -- Woven-in Grenades
		-- Underpin's Bodyguard's Intern
		{1213497, "NAMEPLATE"}, -- Me Go Mad
		{1220869, "NAMEPLATE"}, -- Bonebreaker
		-- Aggressively Lost Hobgoblin
		{1217301, "NAMEPLATE"}, -- Heedless Charge
	}, {
		[1216790] = L.hovering_menace,
		[1214246] = L.treasure_crab,
		[1216805] = L.malfunctioning_pummeler,
		[1217361] = L.underpins_adoring_fan,
		[433045] = L.underpins_well_connected_friend,
		[1218061] = L.underpins_explosive_ally,
		[1213497] = L.underpins_bodyguards_intern,
		[1217301] = L.aggressively_lost_hobgoblin,
	}
end

function mod:OnBossEnable()
	-- TODO Treasure Wraith is the only Season 1 rare to carry over to Season 2, when Season 1 is
	-- over Treasure Wraith should be copied to this module so the Zekvir Rares module can be disconnected.

	-- Hovering Menace
	self:RegisterEngageMob("HoveringMenaceEngaged", 236886)
	self:Log("SPELL_CAST_START", "ForwardCharge", 1216790)
	self:Log("SPELL_CAST_SUCCESS", "ForwardChargeSuccess", 1216790)
	self:Log("SPELL_CAST_START", "AlphaCannon", 1216794)
	self:Log("SPELL_INTERRUPT", "AlphaCannonInterrupt", 1216794)
	self:Log("SPELL_CAST_SUCCESS", "AlphaCannonSuccess", 1216794)
	self:Death("HoveringMenaceDeath", 236886)

	-- Treasure Crab
	self:RegisterEngageMob("TreasureCrabEngaged", 236892)
	self:Log("SPELL_CAST_START", "CrushingPinch", 1214246)
	self:Log("SPELL_CAST_SUCCESS", "CrushingPinchSuccess", 1214246)
	self:Log("SPELL_CAST_START", "HardenShell", 1214238)
	self:Log("SPELL_INTERRUPT", "HardenShellInterrupt", 1214238)
	self:Log("SPELL_CAST_SUCCESS", "HardenShellSuccess", 1214238)
	self:Death("TreasureCrabDeath", 236892)

	-- Malfunctioning Pummeler
	self:RegisterEngageMob("MalfunctioningPummelerEngaged", 236895)
	self:Log("SPELL_CAST_START", "Zap", 1216805)
	self:Log("SPELL_INTERRUPT", "ZapInterrupt", 1216805)
	self:Log("SPELL_CAST_SUCCESS", "ZapSuccess", 1216805)
	self:Log("SPELL_CAST_START", "TheresTheDoor", 1216806)
	self:Log("SPELL_CAST_SUCCESS", "TheresTheDoorSuccess", 1216806)
	self:Death("MalfunctioningPummelerDeath", 236895)

	-- Underpin's Adoring Fan
	self:RegisterEngageMob("UnderpinsAdoringFanEngaged", 234900)
	self:Log("SPELL_CAST_START", "WorthlessAdorations", 1217361)
	self:Log("SPELL_CAST_SUCCESS", "WorthlessAdorationsSuccess", 1217361)
	self:Log("SPELL_CAST_START", "TakeASelfie", 1217326)
	self:Log("SPELL_CAST_SUCCESS", "TakeASelfieSuccess", 1217326)
	self:Death("UnderpinsAdoringFanDeath", 234900)

	-- Underpin's Well-Connected Friend
	self:RegisterEngageMob("UnderpinsWellConnectedFriendEngaged", 234901)
	self:Log("SPELL_CAST_START", "Backstab", 433045)
	self:Log("SPELL_CAST_START", "SpeedDialing", 1217418, 1217449, 1217452, 1217510) -- Call My Agent, Call My Broker, Call My Mother, Speed Dialing
	self:Log("SPELL_CAST_SUCCESS", "CallMyAgentSuccess", 1217418)
	self:Log("SPELL_CAST_SUCCESS", "CallMyBrokerSuccess", 1217449)
	self:Log("SPELL_CAST_SUCCESS", "CallMyMotherSuccess", 1217452)
	self:Log("SPELL_CAST_SUCCESS", "SpeedDialingSuccess", 1217510)
	self:Death("UnderpinsWellConnectedFriendDeath", 234901)

	-- Underpin's Explosive Ally
	self:RegisterEngageMob("UnderpinsExplosiveAllyEngaged", 234902)
	self:Log("SPELL_CAST_START", "GoldFuse", 1218061)
	self:Log("SPELL_INTERRUPT", "GoldFuseInterrupt", 1218061)
	self:Log("SPELL_CAST_SUCCESS", "GoldFuseSuccess", 1218061)
	self:Log("SPELL_CAST_SUCCESS", "CrabABombBarrage", 1218017)
	self:Death("UnderpinsExplosiveAllyDeath", 234902)

	-- Underpin's Bodyguard's Intern
	self:RegisterEngageMob("UnderpinsBodyguardsInternEngaged", 234904)
	self:Log("SPELL_CAST_START", "MeGoMad", 1213497)
	self:Log("SPELL_CAST_SUCCESS", "MeGoMadSuccess", 1213497)
	self:Log("SPELL_CAST_START", "Bonebreaker", 1220869)
	self:Log("SPELL_CAST_SUCCESS", "BonebreakerSuccess", 1220869)
	self:Death("UnderpinsBodyguardsInternDeath", 234904)

	-- Aggressively Lost Hobgoblin
	self:RegisterEngageMob("AggressivelyLostHobgoblinEngaged", 234905)
	self:Log("SPELL_CAST_START", "HeedlessCharge", 1217301)
	self:Death("AggressivelyLostHobgoblinDeath", 234905)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hovering Menace

do
	local timer

	function mod:HoveringMenaceEngaged(guid)
		self:CDBar(1216790, 2.9) -- Forward Charge
		self:Nameplate(1216790, 2.9, guid) -- Forward Charge
		self:CDBar(1216794, 6.4) -- Alpha Cannon
		self:Nameplate(1216794, 6.4, guid) -- Alpha Cannon
		timer = self:ScheduleTimer("HoveringMenaceDeath", 30)
	end

	function mod:ForwardCharge(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("HoveringMenaceDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:ForwardChargeSuccess(args)
		self:CDBar(args.spellId, 13.3)
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
	end

	function mod:AlphaCannon(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("HoveringMenaceDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:AlphaCannonInterrupt(args)
		self:CDBar(1216794, 20.3)
		self:Nameplate(1216794, 20.3, args.destGUID)
	end

	function mod:AlphaCannonSuccess(args)
		self:CDBar(args.spellId, 20.3)
		self:Nameplate(args.spellId, 20.3, args.sourceGUID)
	end

	function mod:HoveringMenaceDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1216790) -- Forward Charge
		self:StopBar(1216794) -- Alpha Cannon
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Treasure Crab

do
	local timer

	function mod:TreasureCrabEngaged(guid)
		self:CDBar(1214246, 3.2) -- Crushing Pinch
		self:Nameplate(1214246, 3.2, guid) -- Crushing Pinch
		self:CDBar(1214238, 8.1) -- Harden Shell
		self:Nameplate(1214238, 8.1, guid) -- Harden Shell
		timer = self:ScheduleTimer("TreasureCrabDeath", 30)
	end

	function mod:CrushingPinch(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("TreasureCrabDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:CrushingPinchSuccess(args)
		self:CDBar(args.spellId, 7.0)
		self:Nameplate(args.spellId, 7.0, args.sourceGUID)
	end

	function mod:HardenShell(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("TreasureCrabDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:HardenShellInterrupt(args)
		self:CDBar(1214238, 30.9)
		self:Nameplate(1214238, 30.9, args.destGUID)
	end

	function mod:HardenShellSuccess(args)
		self:CDBar(args.spellId, 30.9)
		self:Nameplate(args.spellId, 30.9, args.sourceGUID)
	end

	function mod:TreasureCrabDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1214246) -- Crushing Pinch
		self:StopBar(1214238) -- Harden Shell
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Malfunctioning Pummeler

do
	local timer

	function mod:MalfunctioningPummelerEngaged(guid)
		self:CDBar(1216805, 5.5) -- Zap!
		self:Nameplate(1216805, 5.5, guid) -- Zap!
		self:CDBar(1216806, 9.5) -- There's the Door
		self:Nameplate(1216806, 9.5, guid) -- There's the Door
		timer = self:ScheduleTimer("MalfunctioningPummelerDeath", 30)
	end

	function mod:Zap(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("MalfunctioningPummelerDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:ZapInterrupt(args)
		self:CDBar(1216805, 18.7)
		self:Nameplate(1216805, 18.7, args.destGUID)
	end

	function mod:ZapSuccess(args)
		self:CDBar(args.spellId, 18.7)
		self:Nameplate(args.spellId, 18.7, args.sourceGUID)
	end

	function mod:TheresTheDoor(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("MalfunctioningPummelerDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:TheresTheDoorSuccess(args)
		self:CDBar(args.spellId, 8.1)
		self:Nameplate(args.spellId, 8.1, args.sourceGUID)
	end

	function mod:MalfunctioningPummelerDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1216805) -- Zap!
		self:StopBar(1216806) -- There's the Door
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Underpin's Adoring Fan

do
	local timer

	function mod:UnderpinsAdoringFanEngaged(guid)
		self:CDBar(1217361, 3.0) -- Worthless Adorations
		self:Nameplate(1217361, 3.0, guid) -- Worthless Adorations
		self:CDBar(1217326, 9.3) -- Take a Selfie!
		self:Nameplate(1217326, 9.3, guid) -- Take a Selfie!
		timer = self:ScheduleTimer("UnderpinsAdoringFanDeath", 30)
	end

	function mod:WorthlessAdorations(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("UnderpinsAdoringFanDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:WorthlessAdorationsSuccess(args)
		self:CDBar(args.spellId, 13.1)
		self:Nameplate(args.spellId, 13.1, args.sourceGUID)
	end

	function mod:TakeASelfie(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("UnderpinsAdoringFanDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:TakeASelfieSuccess(args)
		self:CDBar(args.spellId, 13.4)
		self:Nameplate(args.spellId, 13.4, args.sourceGUID)
	end

	function mod:UnderpinsAdoringFanDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1217361) -- Worthless Adorations
		self:StopBar(1217326) -- Take a Selfie!
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Underpin's Well-Connected Friend

do
	local timer

	function mod:UnderpinsWellConnectedFriendEngaged(guid)
		self:ClearNameplate(guid) -- wipe protection
		self:CDBar(1217418, 4.7) -- Call My Agent
		self:Nameplate(1217418, 4.7, guid) -- Call My Agent
		timer = self:ScheduleTimer("UnderpinsWellConnectedFriendDeath", 30)
	end

	function mod:Backstab(args)
		-- has no cooldown, only cast if behind the target
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		timer = self:ScheduleTimer("UnderpinsWellConnectedFriendDeath", 30)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:SpeedDialing(args) -- Call My Agent, Call My Broker, Call My Mother, or Speed Dialing
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("UnderpinsWellConnectedFriendDeath", 30)
		self:PlaySound(args.spellId, "info")
	end

	function mod:CallMyAgentSuccess(args)
		self:StopBar(args.spellId)
		self:StopNameplate(args.spellId, args.sourceGUID)
		self:CDBar(1217449, 9.1) -- Call My Broker
		self:Nameplate(1217449, 9.1, args.sourceGUID) -- Call My Broker
	end

	function mod:CallMyBrokerSuccess(args)
		self:StopBar(args.spellId)
		self:StopNameplate(args.spellId, args.sourceGUID)
		self:CDBar(1217452, 9.1) -- Call My Mother
		self:Nameplate(1217452, 9.1, args.sourceGUID) -- Call My Mother
	end

	function mod:CallMyMotherSuccess(args)
		self:StopBar(args.spellId)
		self:StopNameplate(args.spellId, args.sourceGUID)
		self:CDBar(1217510, 9.1) -- Speed Dialing
		self:Nameplate(1217510, 9.1, args.sourceGUID) -- Speed Dialing
	end

	function mod:SpeedDialingSuccess(args)
		self:CDBar(args.spellId, 10.6) -- Speed Dialing
		self:Nameplate(args.spellId, 10.6, args.sourceGUID)
	end

	function mod:UnderpinsWellConnectedFriendDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1217418) -- Call My Agent
		self:StopBar(1217449) -- Call My Broker
		self:StopBar(1217452) -- Call My Mother
		self:StopBar(1217510) -- Speed Dialing
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Underpin's Explosive Ally

function mod:UnderpinsExplosiveAllyEngaged(guid)
	self:Nameplate(1218061, 4.2, guid) -- Gold Fuse
	self:Nameplate(1218017, 7.4, guid) -- Crab-a-Bomb Barrage
end

function mod:GoldFuse(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:GoldFuseInterrupt(args)
	self:Nameplate(1218061, 13.6, args.destGUID)
end

function mod:GoldFuseSuccess(args)
	self:Nameplate(args.spellId, 13.6, args.sourceGUID)
end

do
	local prev = 0
	function mod:CrabABombBarrage(args)
		self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:UnderpinsExplosiveAllyDeath(args)
		self:ClearNameplate(args.destGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(1218039, "yellow") -- Woven-in Grenades
			self:PlaySound(1218039, "alarm") -- Woven-in Grenades
		end
	end
end

-- Underpin's Bodyguard's Intern

do
	local timer

	function mod:UnderpinsBodyguardsInternEngaged(guid)
		self:CDBar(1220869, 2.5) -- Bonebreaker
		self:Nameplate(1220869, 2.5, guid) -- Bonebreaker
		self:CDBar(1213497, 9.8) -- Me Go Mad
		self:Nameplate(1213497, 9.8, guid) -- Me Go Mad
		timer = self:ScheduleTimer("UnderpinsBodyguardsInternDeath", 30)
	end

	function mod:MeGoMad(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("UnderpinsBodyguardsInternDeath", 30)
		self:PlaySound(args.spellId, "info")
	end

	function mod:MeGoMadSuccess(args)
		self:CDBar(args.spellId, 31.3)
		self:Nameplate(args.spellId, 31.3, args.sourceGUID)
	end

	function mod:Bonebreaker(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		timer = self:ScheduleTimer("UnderpinsBodyguardsInternDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:BonebreakerSuccess(args)
		self:CDBar(args.spellId, 8.2)
		self:Nameplate(args.spellId, 8.2, args.sourceGUID)
	end

	function mod:UnderpinsBodyguardsInternDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1213497) -- Me Go Mad
		self:StopBar(1220869) -- Bonebreaker
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Aggressively Lost Hobgoblin

function mod:AggressivelyLostHobgoblinEngaged(guid)
	self:Nameplate(1217301, 3.6, guid) -- Heedless Charge
end

do
	local prev = 0
	function mod:HeedlessCharge(args)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:AggressivelyLostHobgoblinDeath(args)
	self:ClearNameplate(args.destGUID)
end
