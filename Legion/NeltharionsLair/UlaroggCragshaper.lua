
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ularogg Cragshaper", 1065, 1665)
if not mod then return end
mod:RegisterEnableMob(91004)
mod.engageId = 1791

--------------------------------------------------------------------------------
-- Locals
--

local totems = {}
local bossGUID = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.totems = "Totems"
	L.bellow = "{193375} (Totems)" -- Bellow of the Deeps (Totems)
	L.bellow_desc = 193375
	L.bellow_icon = 193375
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

local totemMarker = mod:AddMarkerOption(true, "npc", 8, 198564, 8) -- Stance of the Mountain
function mod:GetOptions()
	return {
		198564, -- Stance of the Mountain
		totemMarker,
		{216290, "ICON"}, -- Strike of the Mountain
		"bellow",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "StanceOfTheMountain", 198564)
	self:Log("SPELL_CAST_START", "StrikeOfTheMountain", 216290)
	self:Log("SPELL_CAST_SUCCESS", "StrikeOfTheMountainOver", 216290)
	self:Log("SPELL_CAST_SUCCESS", "FallingDebris", 198717)
	self:Log("SPELL_CAST_START", "BellowOfTheDeeps", 193375)
	self:Log("SPELL_SUMMON", "StanceOfTheMountainSummon", 216249, 198564, 216250, 198565)

	self:Death("StopScanning", 100818)
end

function mod:OnEngage()
	self:Bar(216290, 15) -- Strike of the Mountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StanceOfTheMountain(args)
	if self:GetOption(totemMarker) then
		wipe(totems)
		bossGUID = nil
		self:RegisterTargetEvents("TotemMark")
	end

	self:Message(args.spellId, "Attention", "Long")
	self:CDBar(args.spellId, 97) -- pull:36.6, 97.7
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(216290)
		end
		self:PrimaryIcon(216290, player)
		self:TargetMessage(216290, player, "Important", "Alarm")
	end
	function mod:StrikeOfTheMountain(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 15) -- pull:15.8, 15.8, 47.3, 26.7, 17.0
	end
	function mod:StrikeOfTheMountainOver(args)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:FallingDebris(args)
	-- Falling Debris applies to all totems, but we will only be missing one in the table,
	-- which will always be the boss, since the boss doesn't summon himself in StanceOfTheMountainSummon().
	if not totems[args.sourceGUID] then
		bossGUID = args.sourceGUID
	end
end

function mod:BellowOfTheDeeps(args)
	self:Message("bellow", "Urgent", "Info", CL.incoming:format(L.totems), args.spellId)
	--self:CDBar(args.spellId, 29) -- pull:20.6, 44.9, 31.5, 31.5
end

function mod:StanceOfTheMountainSummon(args)
	totems[args.destGUID] = true
end

function mod:TotemMark(event, unit)
	if bossGUID then
		local guid = UnitGUID(unit)
		if guid == bossGUID then
			SetRaidTarget(unit, 8)
		end
	end
end

function mod:StopScanning(args)
	if args.destGUID == bossGUID then
		self:UnregisterTargetEvents()
		wipe(totems)
		bossGUID = nil
	end
end

