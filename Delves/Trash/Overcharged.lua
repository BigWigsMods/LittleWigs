--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overcharged Trash", {2664, 2679, 2680, 2681, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2815, 2826}) -- All Delves
if not mod then return end
mod:RegisterEnableMob(
	240018, -- Overcharged Pylon
	242054, -- Titanic Storm Crystal
	239412, -- Awakened Defensive Construct
	241433, -- Awakened Attendant
	239445, -- Awakened Defense Matrix
	236838 -- Overcharged Bot
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overcharged_trash = "Overcharged Trash"

	L.awakened_defensive_construct = "Awakened Defensive Construct"
	L.awakened_defense_matrix = "Awakened Defense Matrix"
	L.overcharged_bot = "Overcharged Bot"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.overcharged_trash
end

function mod:GetOptions()
	return {
		-- Awakened Defensive Construct
		{1227345, "NAMEPLATE"}, -- Adamant Defense
		{1239731, "NAMEPLATE"}, -- Golem Smash
		-- Awakened Defense Matrix
		{1227334, "NAMEPLATE"}, -- Maintenance
		-- Overcharged Bot
		{455380, "NAMEPLATE"}, -- Sprocket Punch
		{455613, "NAMEPLATE"}, -- Crankshaft Assault
		{1220472, "NAMEPLATE"}, -- Overcharge
		{1220665, "NAMEPLATE"}, -- Overcharged Slam
	},{
		[1227345] = L.awakened_defensive_construct,
		[1227334] = L.awakened_defense_matrix,
		[455380] = L.overcharged_bot,
	}
end

function mod:OnBossEnable()
	-- Awakened Defensive Construct
	self:RegisterEngageMob("AwakenedDefensiveConstructEngaged", 239412)
	self:Log("SPELL_CAST_START", "AdamantDefense", 1227345)
	self:Log("SPELL_CAST_START", "GolemSmash", 1239731)
	self:Death("AwakenedDefensiveConstructDeath", 239412)

	-- Awakened Defense Matrix
	self:Log("SPELL_CAST_START", "Maintenance", 1227334)
	self:Death("AwakenedDefenseMatrixDeath", 239445)

	-- Overcharged Bot
	self:RegisterEngageMob("OverchargedBotEngaged", 236838)
	self:Log("SPELL_CAST_START", "SprocketPunch", 455380)
	self:Log("SPELL_CAST_START", "CrankshaftAssault", 455613)
	self:Log("SPELL_CAST_START", "Overcharge", 1220472)
	self:Log("SPELL_CAST_START", "OverchargedSlam", 1220665)
	self:Death("OverchargedBotDeath", 236838)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Awakened Defensive Construct

function mod:AwakenedDefensiveConstructEngaged(guid)
	self:Nameplate(1227345, 5.6, guid) -- Adamant Defense
	self:Nameplate(1239731, 6.4, guid) -- Golem Smash
end

function mod:AdamantDefense(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 25.5, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:GolemSmash(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 19.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:AwakenedDefensiveConstructDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Awakened Defense Matrix

function mod:Maintenance(args)
	-- not cast until ~75% HP
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 23.1, args.sourceGUID) -- cooldown on cast start
	self:PlaySound(args.spellId, "warning")
end

function mod:AwakenedDefenseMatrixDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Overcharged Bot

do
	local timer

	function mod:OverchargedBotEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(455380, 3.4) -- Sprocket Punch
		self:Nameplate(455380, 3.4, guid) -- Sprocket Punch
		self:CDBar(1220472, 5.8) -- Overcharge
		self:Nameplate(1220472, 5.8, guid) -- Overcharge
		self:CDBar(455613, 8.1) -- Crankshaft Assault
		self:Nameplate(455613, 8.1, guid) -- Crankshaft Assault
		self:CDBar(1220665, 19.0) -- Overcharged Slam
		self:Nameplate(1220665, 19.0, guid) -- Overcharged Slam
		timer = self:ScheduleTimer("OverchargedBotDeath", 20, nil, guid)
	end

	function mod:SprocketPunch(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 8.5)
		self:Nameplate(args.spellId, 8.5, args.sourceGUID)
		timer = self:ScheduleTimer("OverchargedBotDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:CrankshaftAssault(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 20.6)
		self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		timer = self:ScheduleTimer("OverchargedBotDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "long")
	end

	function mod:Overcharge(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 18.2)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		timer = self:ScheduleTimer("OverchargedBotDeath", 30, nil, args.sourceGUID)
		if self:Interrupter() then
			self:PlaySound(args.spellId, "warning")
		end
	end

	function mod:OverchargedSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 20.7)
		self:Nameplate(args.spellId, 20.7, args.sourceGUID)
		timer = self:ScheduleTimer("OverchargedBotDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:OverchargedBotDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(455380) -- Sprocket Punch
		self:StopBar(455613) -- Crankshaft Assault
		self:StopBar(1220472) -- Overcharge
		self:StopBar(1220665) -- Overcharged Slam
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end
