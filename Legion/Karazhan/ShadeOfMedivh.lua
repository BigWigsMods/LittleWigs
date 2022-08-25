--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shade of Medivh", 1651, 1817)
if not mod then return end
mod:RegisterEnableMob(114350)
mod:SetEncounterID(1965)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local frostbiteTarget = nil
local addsKilled = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.focused_power = -14036
	L.focused_power_icon = "ability_mage_greaterinvisibility"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{227592, "SAY"}, -- Frostbite
		{227615, "SAY"}, -- Inferno Bolt
		227628, -- Piercing Missiles
		"focused_power",
		228334, -- Guardian's Image
		{228269, "SAY"}, -- Flame Wreath
		227779, -- Ceaseless Winter
	}, {
		["focused_power"] = -14036,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1")
	self:Log("SPELL_CAST_START", "Frostbite", 227592)
	self:Log("SPELL_AURA_APPLIED", "FrostbiteApplied", 227592)
	self:Log("SPELL_AURA_REMOVED", "FrostbiteRemoved", 227592)
	self:Log("SPELL_CAST_START", "InfernoBolt", 227615)
	self:Log("SPELL_CAST_SUCCESS", "PiercingMissiles", 227628)
	self:Log("SPELL_CAST_START", "GuardiansImage", 228334)
	self:Log("SPELL_CAST_START", "FlameWreathStart", 228269)
	self:Log("SPELL_AURA_APPLIED", "FlameWreathApplied", 228261)
	self:Log("SPELL_CAST_START", "CeaselessWinter", 227779)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CeaselessWinterApplied", 227806)
	self:Death("ImageDeath", 114675)
end

function mod:OnEngage()
	addsKilled = 1 -- this variable is being reset at SPELL_CAST_START of Guardian's Image, comparing against it in UNIT_POWER to avoid introducing a new variable
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_POWER_FREQUENT(_, unit)
	local nextSpecial = (100 - (UnitPower(unit) / (UnitPowerMax(unit)) * 100)) / 3.3
	if nextSpecial > 0 and addsKilled ~= 0 then -- doesn't work like that while Guardian's Image is active
		local spellName = self:SpellName(L.focused_power)
		if math.abs(nextSpecial - self:BarTimeLeft(spellName)) > 1 then
			self:Bar("focused_power", nextSpecial, spellName, L.focused_power_icon)
		end
	end
end

function mod:Frostbite(args)
	self:Message(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:FrostbiteApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
	frostbiteTarget = args.destName
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:FrostbiteRemoved()
	frostbiteTarget = nil
end

do
	local function printTarget(self, _, guid)
		if self:Me(guid) then
			local text = CL.you:format(self:SpellName(227615)) .. (frostbiteTarget and " - " .. CL.on:format(self:SpellName(227592), self:ColorName(frostbiteTarget)) or "")
			self:Message(227615, "orange", text)
			self:PlaySound(227615, "alert")
		else
			self:Message(227615, "red")
		end
	end

	function mod:InfernoBolt(args)
		if frostbiteTarget then
			self:GetBossTarget(printTarget, 1, args.sourceGUID)
		else
			self:Message(args.spellId, "red")
		end
	end
end

function mod:PiercingMissiles(args)
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:GuardiansImage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	addsKilled = 0
end

function mod:ImageDeath(args)
	addsKilled = addsKilled + 1
	self:Message("stages", "cyan", CL.mob_killed:format(args.destName, addsKilled, 3), false)
	if addsKilled == 3 then
		self:PlaySound("stages", "long")
	end
end

do
	local playerList = {}

	function mod:FlameWreathStart(args)
		playerList = {}
		self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
		self:PlaySound(args.spellId, "long")
	end

	function mod:FlameWreathApplied(args)
		playerList[#playerList+1] = args.destName
		self:NewTargetsMessage(228269, "red", playerList, 2)
		self:PlaySound(228269, "warning", nil, playerList)
		self:Bar(228269, 20)
		if self:Me(args.destGUID) then
			self:Say(228269)
		end
	end
end

function mod:CeaselessWinter(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 20)
end

function mod:CeaselessWinterApplied(args)
	if self:Me(args.destGUID) then
		if args.amount % 2 == 0 then
			-- Starts doing significant damage at 2+ stacks
			self:NewStackMessage(227779, "blue", args.destName, args.amount, 2)
			self:PlaySound(227779, "warning")
		end
	end
end
