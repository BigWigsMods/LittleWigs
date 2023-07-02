--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Decatriarch Wratheye", 2520, 2474)
if not mod then return end
mod:RegisterEnableMob(186121) -- Decatriarch Wratheye
mod:SetEncounterID(2569)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local rotburstTotemCount = 1
local decaystrikeCount = 1
local lastRotburstTotemCD = 15.5

--------------------------------------------------------------------------------
-- Initialization
--

local totemMarker = mod:AddMarkerOption(true, "npc", 8, 373944, 8) -- Rotburst Totem
function mod:GetOptions()
	return {
		373960, -- Decaying Strength
		373944, -- Rotburst Totem
		totemMarker,
		376170, -- Choking Rotcloud
		{373917, "TANK_HEALER"}, -- Decaystrike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DecayingStrength", 373960)
	self:Log("SPELL_CAST_START", "RotburstTotem", 373942)
	self:Log("SPELL_SUMMON", "RotburstTotemSummon", 373944)
	self:Log("SPELL_CAST_START", "ChokingRotcloud", 376170)
	self:Log("SPELL_CAST_START", "Decaystrike", 373912)
end

function mod:OnEngage()
	rotburstTotemCount = 1
	decaystrikeCount = 1
	lastRotburstTotemCD = 15.5
	self:CDBar(376170, 5.8) -- Choking Rotcloud
	self:CDBar(373917, 10.6) -- Decaystrike
	self:CDBar(373944, 15.5, CL.count:format(self:SpellName(373944), rotburstTotemCount)) -- Rotburst Totem
	-- 40s energy gain, ~.1s delay
	self:CDBar(373960, 40.1) -- Decaying Strength
end

function mod:VerifyEnable(unit)
	-- encounter ends at 5% HP remaining
	return self:GetHealth(unit) > 5
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DecayingStrength(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	-- 4s cast + 40s energy gain + .9s delay
	self:CDBar(373960, 44.9) -- Decaying Strength
end

function mod:RotburstTotem(args)
	self:StopBar(CL.count:format(args.spellName, rotburstTotemCount))
	self:Message(373944, "yellow", CL.count:format(args.spellName, rotburstTotemCount))
	self:PlaySound(373944, "warning")
	rotburstTotemCount = rotburstTotemCount + 1
	if rotburstTotemCount % 2 == 0 then
		lastRotburstTotemCD = 17.8
		self:CDBar(373944, 17.8, CL.count:format(args.spellName, rotburstTotemCount)) -- 17.8 to 18.2
	else
		lastRotburstTotemCD = 26.7
		self:CDBar(373944, 26.7, CL.count:format(args.spellName, rotburstTotemCount)) -- 26.7 to 27.1
	end
end

do
	local totemGUID = nil

	function mod:RotburstTotemSummon(args)
		-- register events to auto-mark totem
		if self:GetOption(totemMarker) then
			totemGUID = args.destGUID
			self:RegisterTargetEvents("MarkTotem")
		end
	end

	function mod:MarkTotem(_, unit, guid)
		if totemGUID == guid then
			totemGUID = nil
			self:CustomIcon(totemMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:ChokingRotcloud(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 42.5)
end

function mod:Decaystrike(args)
	self:Message(373917, "purple")
	self:PlaySound(373917, "alert")
	decaystrikeCount = decaystrikeCount + 1
	if decaystrikeCount % 2 == 0 then
		self:CDBar(373917, 19.4)
	else
		self:CDBar(373917, 25.5)
	end
	-- Rotburst Totem follows this at a minimum of 3.62s later
	if self:BarTimeLeft(CL.count:format(self:SpellName(373944), rotburstTotemCount)) < 3.62 then -- Rotburst Totem
		self:CDBar(373944, {3.62, lastRotburstTotemCD}, CL.count:format(self:SpellName(373944), rotburstTotemCount))
	end
end
