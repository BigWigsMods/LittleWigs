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
mod.engageId = 2257

--------------------------------------------------------------------------------
-- Locals
--

local platingStacks = 3

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
		-- General
		"warmup",
		-- The Platinum Pummeler
		282801, -- Platinum Plating
		285020, -- Whirling Edge
		285344, -- Lay Mine
		-- Gnomercy 4.U.
		{285152, "SAY", "FLASH"}, -- Foe Flipper
		{285388, "CASTBAR"}, -- Vent Jets
		{283422, "SAY", "FLASH"}, -- Maximum Thrust
	}, {
		["warmup"] = "general",
		[282801] = -19237,
		[285152] = -19236,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	self:Log("SPELL_AURA_REMOVED", "PlatinumPlatingRemoved", 282801)
	self:Log("SPELL_CAST_START", "WhirlingEdge", 285020)
	self:Log("SPELL_CAST_SUCCESS", "LayMine", 285344)
	self:Log("SPELL_CAST_SUCCESS", "FoeFlipper", 285152)
	self:Log("SPELL_CAST_START", "VentJets", 285388)
	self:Log("SPELL_CAST_SUCCESS", "VentJetsSuccess", 285388)
	self:Log("SPELL_CAST_START", "MaximumThrust", 283422)

	self:Death("PlatinumPummelerDeath", 144244)
	self:Death("GnomercyDeath", 145185)
end

function mod:OnEngage()
	platingStacks = 3
	self:Bar(285020, 8.2) -- Whirling Edge
	self:Bar(285388, 22) -- Vent Jets
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

function mod:PlatinumPlatingRemoved(args)
	-- Manually track stacks since every time a stack is removed, the entire aura is removed and reapplied
	platingStacks = platingStacks - 1
	self:StackMessageOld(args.spellId, args.destName, platingStacks, "green")
	self:PlaySound(args.spellId, "long")
end

function mod:WhirlingEdge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 32.8)
end

function mod:LayMine(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(285152, "yellow", name)
		self:PlaySound(285152, "alert", nil, name)
		if self:Me(guid) then
			self:Say(285152, nil, nil, "Foe Flipper")
			self:Flash(285152)
		end
	end

	function mod:FoeFlipper(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:VentJets(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 43.7)
end

function mod:VentJetsSuccess(args)
	self:CastBar(args.spellId, 10)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(283422, "yellow", name)
		self:PlaySound(283422, "alert", nil, name)
		if self:Me(guid) then
			self:Say(283422, nil, nil, "Maximum Thrust")
			self:Flash(283422)
		end
	end

	function mod:MaximumThrust(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 43.7)
	end
end

function mod:PlatinumPummelerDeath()
	self:StopBar(285020) -- Whirling Edge
end

function mod:GnomercyDeath()
	self:StopBar(285388) -- Vent Jets
	self:StopBar(283422) -- Maximum Thrust
end
