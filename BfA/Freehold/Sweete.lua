
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harlan Sweete", 1754, 2095)
if not mod then return end
mod:RegisterEnableMob(126983)
mod.engageId = 2096
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages", -- Loaded Dice
		257278, -- Swiftwind Saber
		{257305, "SAY"}, -- Cannon Barrage
		257316, -- Avast, ye!
		{257314, "SAY", "FLASH"}, -- Black Powder Bomb
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "LoadedDiceAllHands", 257402)
	self:Log("SPELL_CAST_START", "LoadedDiceManOWar", 257458)
	self:Log("SPELL_CAST_SUCCESS", "SwiftwindSaber", 257278)
	self:Log("SPELL_AURA_APPLIED", "CannonBarrage", 257305)
	self:Log("SPELL_CAST_SUCCESS", "Avastye", 257316)
	self:Log("SPELL_AURA_APPLIED", "BlackPowderBomb", 257314)
end

function mod:OnEngage()
	stage = 1
	self:CDBar(257278, 11) -- Swiftwind Saber
	self:CDBar(257305, 20) -- Cannon Barrage
	self:CDBar(257316, 32, CL.next_add) -- Avast, ye!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 257454 then -- Swiftwind Saber with Loaded Dice: All Hands!
		self:Message2(257278, "yellow")
		self:PlaySound(257278, "alert", "watchstep")
		self:CDBar(257278, 15)
	end
end

function mod:LoadedDiceAllHands(args)
	stage = 2
	self:Message2("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info", "stage")
	self:Bar(257278, 10.9) -- Swiftwind Saber
	self:Bar(257305, 17) -- Cannon Barrage
	self:CDBar(257316, 28.5, CL.next_add) -- Avast, ye!
end

function mod:LoadedDiceManOWar(args)
	stage = 3
	self:Message2("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info", "stage")
	self:Bar(257278, 10.9) -- Swiftwind Saber
	self:Bar(257305, 17) -- Cannon Barrage
	self:CDBar(257316, 23.5, CL.next_add) -- Avast, ye!
end

function mod:SwiftwindSaber(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:CDBar(args.spellId, (stage == 1) and 15.8 or 12.2)
end

do
	local onMe, scheduled = nil, nil
	local function warn(self) -- It's either on 1 person or on everyone in the later stage, targetlist warnings are not not needed
		if onMe then
			self:PersonalMessage(257305)
			self:PlaySound(257305, "warning", "moveout")
		else
			self:Message2(257305, "orange") -- Cannon Barrage
			self:PlaySound(257305, "alarm", "watchstep")
		end
		onMe = nil
		scheduled = nil
	end

	function mod:CannonBarrage(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
			onMe = true
		end
		if not scheduled then
			scheduled = self:ScheduleTimer(warn, 0.1, self)
			self:CDBar(args.spellId, 18.2)
		end
	end
end

function mod:Avastye(args)
	self:Message2(args.spellId, "red", CL.add_spawned)
	self:PlaySound(args.spellId, "long", "addincoming")
	self:CDBar(args.spellId, (stage == 3) and 18.2 or 20.6, CL.next_add)
end

function mod:BlackPowderBomb(args)
	if args.sourceGUID ~= args.destGUID then -- The add buffs itself with the same spell id
		self:TargetMessage2(args.spellId, "yellow", args.destName, self:SpellName(244657), args.spellId) -- Fixate
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning", "fixate")
			self:Say(args.spellId, self:SpellName(244657)) -- Fixate
			self:Flash(args.spellId)
		end
	end
end
