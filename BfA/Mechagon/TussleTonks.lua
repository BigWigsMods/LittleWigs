local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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

local platingStacks = 3 -- XXX remove when 11.1 is live
local platinumPlatingCount = 1
local platinumPummelCount = 1
local groundPoundCount = 1
local b4ttl3MineCount = 1
local foeFlipperCount = 1

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

if isElevenDotOne then -- XXX remove this check when 11.1 is live
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
else -- XXX remove this block when 11.1 is live
	function mod:GetOptions()
		return {
			"warmup",
			-- The Platinum Pummeler
			282801, -- Platinum Plating
			285020, -- Whirling Edge
			285344, -- Lay Mine
			-- Gnomercy 4.U.
			{285152, "SAY"}, -- Foe Flipper
			{285388, "CASTBAR"}, -- Vent Jets
			{283422, "SAY"}, -- Maximum Thrust
		}, {
			[282801] = -19237, -- The Platium Pummeler
			[285152] = -19236, -- Gnomercy 4.U.
		}
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	if isElevenDotOne then
		-- Staging
		self:Log("SPELL_CAST_SUCCESS", "ElectricalStorm", 1216443)

		-- The Platinum Pummeler
		self:Log("SPELL_CAST_START", "PlatinumPlating", 282801)
		self:Log("SPELL_CAST_START", "PlatinumPummel", 1215065)
	end
	self:Log("SPELL_AURA_REMOVED", "PlatinumPlatingRemoved", 282801)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "GroundPound", 1215102)
	else -- XXX remove block when 11.1 is live
		self:Log("SPELL_CAST_START", "WhirlingEdge", 285020)
		self:Log("SPELL_CAST_SUCCESS", "LayMine", 285344)
	end
	self:Death("ThePlatinumPummelerDeath", 144244)

	-- Gnomercy 4.U.
	self:Log("SPELL_CAST_START", "MaximumThrust", 283422)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "B4TTL3Mine", 1216431)
		self:Log("SPELL_CAST_START", "FoeFlipper", 285152) -- TODO targeting spell 285150 is hidden
	else -- XXX remove block when 11.1 is live
		self:Log("SPELL_CAST_START", "VentJets", 285388)
		self:Log("SPELL_CAST_SUCCESS", "VentJetsSuccess", 285388)
		self:Log("SPELL_CAST_SUCCESS", "FoeFlipper", 285152)
	end
	self:Death("Gnomercy4UDeath", 145185)
end

function mod:OnEngage()
	self:SetStage(1)
	platinumPlatingCount = 1
	platinumPummelCount = 1
	groundPoundCount = 1
	b4ttl3MineCount = 1
	foeFlipperCount = 1
	if isElevenDotOne then
		self:CDBar(285152, 5.8) -- Foe Flipper
		self:CDBar(1215065, 7.2, CL.count:format(self:SpellName(1215065), platinumPummelCount)) -- Platinum Pummel
		self:CDBar(1216431, 12.0) -- B.4.T.T.L.3. Mine
		self:CDBar(1215102, 13.1, CL.count:format(self:SpellName(1215102), groundPoundCount)) -- Ground Pound
		self:CDBar(283422, 35.1) -- Maximum Thrust
		self:CDBar(282801, 38.5, CL.count:format(self:SpellName(282801), platinumPlatingCount)) -- Platinum Plating
	else -- XXX remove block when 11.1 is live
		platingStacks = 3
		self:CDBar(285020, 8.2) -- Whirling Edge
		self:CDBar(285388, 22) -- Vent Jets
	end
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
	self:StopBar(CL.count:format(args.spellName, platinumPlatingCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, platinumPlatingCount))
	-- TODO handle boss being stunned during cast
	platinumPlatingCount = platinumPlatingCount + 1
	if self:Mythic() then
		self:CDBar(args.spellId, 40.5, CL.count:format(args.spellName, platinumPlatingCount))
	else
		self:CDBar(args.spellId, 36.4, CL.count:format(args.spellName, platinumPlatingCount))
	end
	self:PlaySound(args.spellId, "info")
end

function mod:PlatinumPlatingRemoved(args)
	if isElevenDotOne then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	else -- XXX remove block when 11.1 is live
		-- Manually track stacks since every time a stack is removed, the entire aura is removed and reapplied
		platingStacks = platingStacks - 1
		self:StackMessageOld(args.spellId, args.destName, platingStacks, "green")
		self:PlaySound(args.spellId, "long")
	end
end

function mod:PlatinumPummel(args)
	self:StopBar(CL.count:format(args.spellName, platinumPummelCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, platinumPummelCount))
	-- TODO handle boss being stunned during cast
	platinumPummelCount = platinumPummelCount + 1
	self:CDBar(args.spellId, 15.1, CL.count:format(args.spellName, platinumPummelCount))
	self:PlaySound(args.spellId, "alarm")
end

function mod:GroundPound(args)
	self:StopBar(CL.count:format(args.spellName, groundPoundCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, groundPoundCount))
	-- TODO handle boss being stunned during cast
	groundPoundCount = groundPoundCount + 1
	self:CDBar(args.spellId, 18.2, CL.count:format(args.spellName, groundPoundCount))
	self:PlaySound(args.spellId, "info")
end

function mod:WhirlingEdge(args) -- XXX remove when 11.1 is live
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 32.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:LayMine(args) -- XXX remove when 11.1 is live
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

function mod:ThePlatinumPummelerDeath()
	if isElevenDotOne then
		self:StopBar(CL.count:format(self:SpellName(282801), platinumPlatingCount)) -- Platinum Plating
		self:StopBar(CL.count:format(self:SpellName(1215065), platinumPummelCount)) -- Platinum Pummel
		self:StopBar(CL.count:format(self:SpellName(1215102), groundPoundCount)) -- Ground Pound
	else -- XXX remove block when 11.1 is live
		self:StopBar(285020) -- Whirling Edge
	end
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
		self:CDBar(args.spellId, 34.8)
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
			self:CDBar(args.spellId, 15.8)
		elseif foeFlipperCount == 3 then
			self:CDBar(args.spellId, 28.0)
		else -- odd casts (besides 3)
			self:CDBar(args.spellId, 19.4)
		end
	end
end

function mod:VentJets(args) -- XXX remove when 11.1 is live
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 43.7)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VentJetsSuccess(args) -- XXX remove when 11.1 is live
	self:CastBar(args.spellId, 10)
end

function mod:Gnomercy4UDeath()
	self:StopBar(283422) -- Maximum Thrust
	if isElevenDotOne then
		self:StopBar(1216431) -- B.4.T.T.L.3. Mine
		self:StopBar(285152) -- Foe Flipper
	else -- XXX remove block when 11.1 is live
		self:StopBar(285388) -- Vent Jets
	end
end
