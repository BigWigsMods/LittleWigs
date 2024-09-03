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
local guardiansImagePhase = false

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
		{227592, "SAY"}, -- Frostbite
		227615, -- Inferno Bolt
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
	self:Death("ImageDeath", 114675)
	self:Log("SPELL_CAST_START", "FlameWreathStart", 228269)
	self:Log("SPELL_AURA_APPLIED", "FlameWreathApplied", 228261)
	self:Log("SPELL_CAST_START", "CeaselessWinter", 227779)
	self:Log("SPELL_CAST_SUCCESS", "CeaselessWinterSuccess", 227779)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CeaselessWinterApplied", 227806)
end

function mod:OnEngage()
	guardiansImagePhase = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_POWER_FREQUENT(_, unit)
	if guardiansImagePhase then
		-- Focused Power resumes after Guardian's Image is over
		return
	end

	-- ~30 seconds beween specials, cast at max Mana
	local nextSpecial = 30 * (1 - UnitPower(unit) / UnitPowerMax(unit))
	if nextSpecial > 0 then
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
		self:Say(args.spellId, nil, nil, "Frostbite")
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
			self:GetUnitTarget(printTarget, 1, args.sourceGUID)
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

do
	local addsKilled = 0

	function mod:GuardiansImage(args)
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "long")
		guardiansImagePhase = true
		addsKilled = 0
	end

	function mod:ImageDeath(args)
		addsKilled = addsKilled + 1
		self:Message(228334, "cyan", CL.mob_killed:format(args.destName, addsKilled, 3), false)
		if addsKilled == 3 then
			self:PlaySound(228334, "info")
			guardiansImagePhase = false
		end
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
		self:TargetsMessage(228269, "red", playerList, 2)
		self:PlaySound(228269, "warning", nil, playerList)
		if #playerList == 1 then
			self:Bar(228269, 20)
		end
		if self:Me(args.destGUID) then
			self:Say(228269, nil, nil, "Flame Wreath")
		end
	end
end

function mod:CeaselessWinter(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:CeaselessWinterSuccess(args)
	self:Bar(args.spellId, 20)
end

function mod:CeaselessWinterApplied(args)
	if self:Me(args.destGUID) then
		if args.amount % 2 == 0 then
			-- Starts doing significant damage at 2+ stacks
			self:StackMessage(227779, "blue", args.destName, args.amount, 2)
			self:PlaySound(227779, "warning")
		end
	end
end
