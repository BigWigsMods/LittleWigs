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
		1216790, -- Forward Charge
		1216794, -- Alpha Cannon
		-- Treasure Crab
		1214246, -- Crushing Pinch
		1214238, -- Harden Shell
		-- Malfunctioning Pummeler
		1216805, -- Zap!
		1216806, -- There's the Door
		-- Underpin's Adoring Fan
		1217361, -- Worthless Adorations
		1217326, -- Take a Selfie!
		-- Underpin's Well-Connected Friend
		433045, -- Backstab
		1217418, -- Call My Agent
		1217449, -- Call My Broker
		1217452, -- Call My Mother
		1217510, -- Speed Dialing
		-- Underpin's Explosive Ally
		1218061, -- Gold Fuse
		1218017, -- Crab-a-bomb Barrage
		1218039, -- Woven-in Grenades
		-- Underpin's Bodyguard's Intern
		1213497, -- Me Go Mad
		1220869, -- Bonebreaker
		-- Aggressively Lost Hobgoblin
		1217301, -- Heedless Charge
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
	self:Log("SPELL_CAST_START", "ForwardCharge", 1216790)
	self:Log("SPELL_CAST_START", "AlphaCannon", 1216794)
	self:Death("HoveringMenaceDeath", 236886)

	-- Treasure Crab
	self:Log("SPELL_CAST_START", "CrushingPinch", 1214246)
	self:Log("SPELL_CAST_START", "HardenShell", 1214238)
	self:Death("TreasureCrabDeath", 236892)

	-- Malfunctioning Pummeler
	self:Log("SPELL_CAST_START", "Zap", 1216805)
	self:Log("SPELL_INTERRUPT", "ZapInterrupt", 1216805)
	self:Log("SPELL_CAST_SUCCESS", "ZapSuccess", 1216805)
	self:Log("SPELL_CAST_START", "TheresTheDoor", 1216806)
	self:Log("SPELL_CAST_SUCCESS", "TheresTheDoorSuccess", 1216806)
	self:Death("MalfunctioningPummelerDeath", 236895)

	-- Underpin's Adoring Fan
	self:Log("SPELL_CAST_START", "WorthlessAdorations", 1217361)
	self:Log("SPELL_CAST_SUCCESS", "WorthlessAdorationsSuccess", 1217361)
	self:Log("SPELL_CAST_START", "TakeASelfie", 1217326)
	self:Log("SPELL_INTERRUPT", "TakeASelfieInterrupt", 1217326)
	self:Log("SPELL_CAST_SUCCESS", "TakeASelfieSuccess", 1217326)
	self:Death("UnderpinsAdoringFanDeath", 234900)

	-- Underpin's Well-Connected Friend
	self:Log("SPELL_CAST_START", "Backstab", 433045)
	self:Log("SPELL_CAST_START", "SpeedDialing", 1217418, 1217449, 1217452, 1217510) -- Call My Agent, Call My Broker, Call My Mother, Speed Dialing
	self:Log("SPELL_CAST_SUCCESS", "CallMyAgentSuccess", 1217418)
	self:Log("SPELL_CAST_SUCCESS", "CallMyBrokerSuccess", 1217449)
	self:Log("SPELL_CAST_SUCCESS", "CallMyMotherSuccess", 1217452)
	self:Log("SPELL_CAST_SUCCESS", "SpeedDialingSuccess", 1217510)
	self:Death("UnderpinsWellConnectedFriendDeath", 234901)

	-- Underpin's Explosive Ally
	self:Log("SPELL_CAST_START", "GoldFuse", 1218061)
	self:Log("SPELL_CAST_SUCCESS", "CrabABombBarrage", 1218017)
	self:Death("UnderpinsExplosiveAllyDeath", 234902)

	-- Underpin's Bodyguard's Intern
	self:Log("SPELL_CAST_START", "MeGoMad", 1213497)
	self:Log("SPELL_CAST_START", "Bonebreaker", 1220869)
	self:Death("UnderpinsBodyguardsInternDeath", 234904)

	-- Aggressively Lost Hobgoblin
	self:Log("SPELL_CAST_START", "HeedlessCharge", 1217301)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hovering Menace

do
	local timer

	function mod:ForwardCharge(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 15.0)
		timer = self:ScheduleTimer("HoveringMenaceDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:AlphaCannon(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 22.3)
		timer = self:ScheduleTimer("HoveringMenaceDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:HoveringMenaceDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1216790) -- Foward Charge
		self:StopBar(1216794) -- Alpha Cannon
	end
end

-- Treasure Crab

do
	local timer

	function mod:CrushingPinch(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 8.5)
		timer = self:ScheduleTimer("TreasureCrabDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:HardenShell(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 30.4)
		timer = self:ScheduleTimer("TreasureCrabDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:TreasureCrabDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1214246) -- Crushing Pinch
		self:StopBar(1214238) -- Harden Shell
	end
end

-- Malfunctioning Pummeler

do
	local timer

	function mod:Zap(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		timer = self:ScheduleTimer("MalfunctioningPummelerDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:ZapInterrupt(args)
		self:CDBar(1216805, 19.0)
	end

	function mod:ZapSuccess(args)
		self:CDBar(args.spellId, 19.0)
	end

	function mod:TheresTheDoor(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		timer = self:ScheduleTimer("MalfunctioningPummelerDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:TheresTheDoorSuccess(args)
		self:CDBar(args.spellId, 8.1)
	end

	function mod:MalfunctioningPummelerDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1216805) -- Zap!
		self:StopBar(1216806) -- There's the Door
	end
end

-- Underpin's Adoring Fan

do
	local timer

	function mod:WorthlessAdorations(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		timer = self:ScheduleTimer("UnderpinsAdoringFanDeath", 30)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:WorthlessAdorationsSuccess(args)
		self:CDBar(args.spellId, 13.1)
	end

	function mod:TakeASelfie(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		timer = self:ScheduleTimer("UnderpinsAdoringFanDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:TakeASelfieInterrupt(args)
		self:CDBar(1217326, 13.5)
	end

	function mod:TakeASelfieSuccess(args)
		self:CDBar(args.spellId, 13.5)
	end

	function mod:UnderpinsAdoringFanDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1217361) -- Worthless Adorations
		self:StopBar(1217326) -- Take a Selfie!
	end
end

-- Underpin's Well-Connected Friend

do
	local timer

	function mod:Backstab(args)
		-- only cast if behind the target
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
		timer = self:ScheduleTimer("UnderpinsWellConnectedFriendDeath", 30)
		self:PlaySound(args.spellId, "info")
	end

	function mod:CallMyAgentSuccess(args)
		--self:StopBar(args.spellId)
		self:CDBar(1217449, 9.1) -- Call My Broker
	end

	function mod:CallMyBrokerSuccess(args)
		self:StopBar(args.spellId)
		self:CDBar(1217452, 9.1) -- Call My Mother
	end

	function mod:CallMyMotherSuccess(args)
		self:StopBar(args.spellId)
		self:CDBar(1217510, 10.3) -- Speed Dialing
	end

	function mod:SpeedDialingSuccess(args)
		self:CDBar(1217510, 10.6) -- Speed Dialing
	end

	function mod:UnderpinsWellConnectedFriendDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1217449) -- Call My Broker
		self:StopBar(1217452) -- Call My Mother
		self:StopBar(1217510) -- Speed Dialing
	end
end

-- Underpin's Explosive Ally

function mod:GoldFuse(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:CrabABombBarrage(args)
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

	function mod:MeGoMad(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 36.5) -- TODO probably move to success?
		timer = self:ScheduleTimer("UnderpinsBodyguardsInternDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:Bonebreaker(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 9.7) -- TODO probably move to success?
		timer = self:ScheduleTimer("UnderpinsBodyguardsInternDeath", 30)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:UnderpinsBodyguardsInternDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1213497) -- Me Go Mad
		self:StopBar(1220869) -- Bonebreaker
	end
end

-- Aggressively Lost Hobgoblin

do
	local prev = 0
	function mod:HeedlessCharge(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
