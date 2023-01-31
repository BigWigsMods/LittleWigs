if UnitFactionGroup("player") ~= "Horde" then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sergeant Bainbridge", 1822, 2133)
if not mod then return end
mod:RegisterEnableMob(128649) -- Sergeant Bainbridge
mod.engageId = 2097
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local bombsRemaining = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = 274002
	L.adds_icon = "inv_misc_groupneedmore"
	L.remaining = "%s on %s, %d remaining"
	L.remaining_boss = "%s on BOSS, %d remaining"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"adds",
		{260954, "FLASH"}, -- Iron Gaze
		261428, -- Hangman's Noose
		260924, -- Steel Tempest
		257585, -- Cannon Barrage
		277965, -- Heavy Ordnance
		279761, -- Heavy Slash
	}, {
		["adds"] = "general",
		[279761] = -17762, -- Kul Tiran Vanguard
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4", "boss5")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "IronGaze", 260954)
	self:Log("SPELL_AURA_REMOVED", "IronGazeRemoved", 260954)
	self:Log("SPELL_AURA_APPLIED", "HangmansNoose", 261428)
	self:Log("SPELL_CAST_START", "SteelTempest", 260924)
	self:Log("SPELL_DAMAGE", "HeavyOrdnanceDamage", 273720, 280933) -- Damage to player, damage to add
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 277965)
end

function mod:OnEngage()
	bombsRemaining = 0
	self:Bar(257585, 11) -- Cannon Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, _, _, spellId)
	if spellId == 279761 then -- Heavy Slash
		self:Message(spellId, "orange")
		self:PlaySound(spellId, "alert")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		bombsRemaining = 3
		self:Message(257585, "orange")
		self:PlaySound(257585, "warning")
		self:CDBar(257585, 60)
		self:Bar(277965, 42, CL.count:format(self:SpellName(277965), bombsRemaining)) -- Heavy Ordnance
	elseif spellId == 274002 then -- Call Adds
		local hp = self:GetHealth(unit)
		if hp > 33 then -- Spams every second under 33% but doesn't actually spawn adds
			self:Message("adds", "yellow", CL.incoming:format(CL.adds), false)
			self:PlaySound("adds", "long")
		end
	end
end

function mod:IronGaze(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 20, args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Flash(args.spellId)
	end
end

function mod:IronGazeRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:HangmansNoose(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SteelTempest(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:HeavyOrdnanceDamage(args)
		local t = args.time
		if t ~= prev then
			prev = t
			local barText = CL.count:format(args.spellName, bombsRemaining)
			bombsRemaining = bombsRemaining - 1
			local timer = self:BarTimeLeft(barText)
			self:StopBar(barText)
			if bombsRemaining > 0 then
				self:Bar(277965, timer, CL.count:format(args.spellName, bombsRemaining))
			end
			self:Message(277965, "orange", L.remaining:format(args.spellName, args.destName, bombsRemaining))
			self:PlaySound(277965, "info")
		end
	end
end

function mod:HeavyOrdnanceApplied(args)
	local barText = CL.count:format(args.spellName, bombsRemaining)
	bombsRemaining = bombsRemaining - 1
	local timer = self:BarTimeLeft(barText)
	self:StopBar(barText)
	if bombsRemaining > 0 then
		self:Bar(args.spellId, timer, CL.count:format(args.spellName, bombsRemaining))
	end
	self:Message(args.spellId, "green", L.remaining_boss:format(args.spellName, bombsRemaining))
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
end
