if UnitFactionGroup("player") ~= "Horde" then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sergeant Bainbridge", 1822, 2133)
if not mod then return end
mod:RegisterEnableMob(128649) -- Sergeant Bainbridge
mod:SetEncounterID(2097)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local bombsRemaining = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L["274002_icon"] = "inv_misc_groupneedmore"
end

--------------------------------------------------------------------------------
-- Initialization
--

-- TODO sync this whole module with Lockwood at some point? it'll have to be checked first
-- most changes have not made it to Bainbridge as of aug 6 2024
function mod:GetOptions()
	return {
		274002, -- Call Irontide
		260954, -- Iron Gaze
		261428, -- Hangman's Noose
		260924, -- Steel Tempest
		257585, -- Cannon Barrage
		277965, -- Heavy Ordnance
		279761, -- Heavy Slash
	}, {
		[274002] = "general",
		[279761] = -17762, -- Kul Tiran Vanguard
	}, {
		[274002] = CL.adds, -- Call Irontide (Adds)
		[260954] = CL.fixate, -- Iron Gaze (Fixate)
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4", "boss5")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "CallIrontide", 274002)
	self:Log("SPELL_AURA_APPLIED", "IronGaze", 260954)
	self:Log("SPELL_AURA_REMOVED", "IronGazeRemoved", 260954)
	self:Log("SPELL_AURA_APPLIED", "HangmansNoose", 261428)
	self:Log("SPELL_CAST_START", "SteelTempest", 260924)
	self:Log("SPELL_DAMAGE", "HeavyOrdnanceDamage", 273720, 280933) -- damage to player, damage to add
	self:Log("SPELL_MISSED", "HeavyOrdnanceDamage", 273720) -- missed player
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 277965)
end

function mod:OnEngage()
	bombsRemaining = 0
	self:Bar(257585, 11) -- Cannon Barrage
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Siege of Boralus Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:FirstBossDefeated()
	end
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

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		bombsRemaining = 3
		self:Message(257585, "orange")
		self:PlaySound(257585, "warning")
		self:CDBar(257585, 60)
		self:Bar(277965, 42, CL.count:format(self:SpellName(277965), bombsRemaining)) -- Heavy Ordnance
	end
end

function mod:CallIrontide(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and self:GetHealth(unit) > 33 then -- Spams every second under 33% but doesn't actually spawn adds
		self:Message(args.spellId, "yellow", CL.adds_spawning, L["274002_icon"])
		self:PlaySound(args.spellId, "long")
	end
end

function mod:IronGaze(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
	self:TargetBar(args.spellId, 20, args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:IronGazeRemoved(args)
	self:StopBar(CL.fixate, args.destName)
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
			self:Message(277965, "orange", CL.extra:format(CL.on:format(args.spellName, args.destName), CL.remaining:format(bombsRemaining)))
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
	self:Message(args.spellId, "green", CL.extra:format(CL.onboss:format(args.spellName), CL.remaining:format(bombsRemaining)))
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
end
