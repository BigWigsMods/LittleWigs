--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tussle Tonks", 2097, 2336)
if not mod then return end
-- Enable on trash before boss for warmup
mod:RegisterEnableMob(
	144244, -- The Platinum Pummeler
	145185, -- Gnomercy 4.U.
	151657, -- Bomb Tonk
	151658, -- Strider Tonk
	151659  -- Rocket Tonk
)
mod:SetEncounterID(2257)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local platinumPlatingCount = 1
local platinumPummelCount = 1
local groundPoundCount = 1
local b4ttl3MineCount = 1
local foeFlipperCount = 1
local nextPlatinumPlating = 0
local platinumPlatingOnBoss = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Now this is a statistical anomaly! Our visitors are still alive!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		1216443, -- Electrical Storm
		-- The Platinum Pummeler
		282801, -- Platinum Plating
		1215065, -- Platinum Pummel
		1215102, -- Ground Pound
		-- Gnomercy 4.U.
		{283422, "SAY"}, -- Maximum Thrust
		1216431, -- B.4.T.T.L.3. Mine
		{285152, "SAY"}, -- Foe Flipper
	}, {
		[282801] = -19237, -- The Platium Pummeler
		[283422] = -19236, -- Gnomercy 4.U.
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	-- Staging
	self:Log("SPELL_CAST_SUCCESS", "ElectricalStorm", 1216443)

	-- The Platinum Pummeler
	self:Log("SPELL_CAST_START", "PlatinumPlating", 282801)
	self:Log("SPELL_CAST_SUCCESS", "PlatinumPlatingSuccess", 282801)
	self:Log("SPELL_AURA_REMOVED", "PlatinumPlatingRemoved", 282801)
	self:Log("SPELL_CAST_SUCCESS", "Stunned", 1215194)
	self:Log("SPELL_CAST_START", "PlatinumPummel", 1215065)
	self:Log("SPELL_CAST_SUCCESS", "PlatinumPummelSucccess", 1215065)
	self:Log("SPELL_CAST_START", "GroundPound", 1215102)
	self:Log("SPELL_CAST_SUCCESS", "GroundPoundSucccess", 1215102)
	self:Death("ThePlatinumPummelerDeath", 144244)

	-- Gnomercy 4.U.
	self:Log("SPELL_CAST_START", "MaximumThrust", 283422)
	self:Log("SPELL_CAST_START", "B4TTL3Mine", 1216431)
	self:Log("SPELL_CAST_START", "FoeFlipper", 285152)
	self:Death("Gnomercy4UDeath", 145185)
end

function mod:OnEngage()
	self:SetStage(1)
	platinumPlatingCount = 1
	platinumPummelCount = 1
	groundPoundCount = 1
	b4ttl3MineCount = 1
	foeFlipperCount = 1
	nextPlatinumPlating = 0 -- can't be stunned until after Platinum Plating is cast
	platinumPlatingOnBoss = false
	self:CDBar(285152, 5.8) -- Foe Flipper
	self:CDBar(1215065, 7.2, CL.count:format(self:SpellName(1215065), platinumPummelCount)) -- Platinum Pummel
	self:CDBar(1216431, 12.0) -- B.4.T.T.L.3. Mine
	self:CDBar(1215102, 13.1, CL.count:format(self:SpellName(1215102), groundPoundCount)) -- Ground Pound
	self:CDBar(283422, 35.1) -- Maximum Thrust
	self:CDBar(282801, 38.5, CL.count:format(self:SpellName(282801), platinumPlatingCount)) -- Platinum Plating
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 23, CL.active, "inv_engineering_autohammer")
	end
end

-- Staging

function mod:ElectricalStorm(args)
	-- avoid alerting again when the second boss is defeated
	if self:GetStage() == 1 then
		self:SetStage(2)
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "long")
	end
end

-- The Platinum Pummeler

function mod:PlatinumPlating(args)
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, platinumPlatingCount))
	if not platinumPlatingOnBoss then
		self:StopBar(CL.count:format(args.spellName, platinumPlatingCount))
		platinumPlatingCount = platinumPlatingCount + 1
		-- cast at 100 energy, 35s energy gain + 0.2s delay
		nextPlatinumPlating = args.time + 35.2
		self:CDBar(args.spellId, 35.2, CL.count:format(args.spellName, platinumPlatingCount))
	end
	self:PlaySound(args.spellId, "info")
end

function mod:PlatinumPlatingSuccess(args)
	if platinumPlatingOnBoss then
		-- will recast if boss is stunned during the cast
		self:StopBar(CL.count:format(args.spellName, platinumPlatingCount))
		platinumPlatingCount = platinumPlatingCount + 1
		-- cast at 100 energy, 35s energy gain + 0.2s delay - 1s cast
		nextPlatinumPlating = args.time + 34.2
		self:CDBar(args.spellId, 34.2, CL.count:format(args.spellName, platinumPlatingCount))
	else
		platinumPlatingOnBoss = true
	end
end

function mod:PlatinumPlatingRemoved(args)
	platinumPlatingOnBoss = false
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:Stunned(args)
	if nextPlatinumPlating ~= 0 then -- reload protection
		-- energy gain is paused, resumes 5s after being stunned
		local timeUntilPlatinumPlating = nextPlatinumPlating - args.time
		if timeUntilPlatinumPlating < 0 then
			timeUntilPlatinumPlating = 5
		else
			timeUntilPlatinumPlating = timeUntilPlatinumPlating + 5
		end
		self:CDBar(282801, {timeUntilPlatinumPlating, 40.2}, CL.count:format(self:SpellName(282801), platinumPlatingCount)) -- Platinum Plating
	end
end

function mod:PlatinumPummel(args)
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, platinumPummelCount))
	if not platinumPlatingOnBoss then
		self:StopBar(CL.count:format(args.spellName, platinumPummelCount))
		platinumPummelCount = platinumPummelCount + 1
		self:CDBar(args.spellId, 15.4, CL.count:format(args.spellName, platinumPummelCount))
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:PlatinumPummelSucccess(args)
	if platinumPlatingOnBoss then
		-- will recast if boss is stunned during the cast
		self:StopBar(CL.count:format(args.spellName, platinumPummelCount))
		platinumPummelCount = platinumPummelCount + 1
		self:CDBar(args.spellId, 12.4, CL.count:format(args.spellName, platinumPummelCount))
	end
end

function mod:GroundPound(args)
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, groundPoundCount))
	if not platinumPlatingOnBoss then
		self:StopBar(CL.count:format(args.spellName, groundPoundCount))
		groundPoundCount = groundPoundCount + 1
		self:CDBar(args.spellId, 18.2, CL.count:format(args.spellName, groundPoundCount))
	end
	self:PlaySound(args.spellId, "info")
end

function mod:GroundPoundSucccess(args)
	if platinumPlatingOnBoss then
		-- will recast if boss is stunned during the cast
		self:StopBar(CL.count:format(args.spellName, groundPoundCount))
		groundPoundCount = groundPoundCount + 1
		self:CDBar(args.spellId, 15.2, CL.count:format(args.spellName, groundPoundCount))
	end
end

function mod:ThePlatinumPummelerDeath()
	self:StopBar(CL.count:format(self:SpellName(282801), platinumPlatingCount)) -- Platinum Plating
	self:StopBar(CL.count:format(self:SpellName(1215065), platinumPummelCount)) -- Platinum Pummel
	self:StopBar(CL.count:format(self:SpellName(1215102), groundPoundCount)) -- Ground Pound
end

-- Gnomercy 4.U.

do
	local function printTarget(self, name, guid)
		self:TargetMessage(283422, "orange", name)
		if self:Me(guid) then
			self:Say(283422, nil, nil, "Maximum Thrust")
		end
		self:PlaySound(283422, "alarm", nil, name)
	end

	function mod:MaximumThrust(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 34.8)
	end
end

function mod:B4TTL3Mine(args)
	self:Message(args.spellId, "red")
	b4ttl3MineCount = b4ttl3MineCount + 1
	if b4ttl3MineCount == 2 then
		self:CDBar(args.spellId, 17.0)
	elseif b4ttl3MineCount == 3 then
		self:CDBar(args.spellId, 27.9)
	else -- 4+
		self:CDBar(args.spellId, 34.1)
	end
	self:PlaySound(args.spellId, "long")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(285152, "yellow", name)
		if self:Me(guid) then
			self:Say(285152, nil, nil, "Foe Flipper")
		end
		self:PlaySound(285152, "alert", nil, name)
	end

	function mod:FoeFlipper(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		foeFlipperCount = foeFlipperCount + 1
		if foeFlipperCount % 2 == 0 then
			self:CDBar(args.spellId, 15.0)
		elseif foeFlipperCount == 3 then
			self:CDBar(args.spellId, 28.0)
		else -- odd casts (besides 3)
			self:CDBar(args.spellId, 19.0)
		end
	end
end

function mod:Gnomercy4UDeath()
	self:StopBar(283422) -- Maximum Thrust
	self:StopBar(1216431) -- B.4.T.T.L.3. Mine
	self:StopBar(285152) -- Foe Flipper
end
