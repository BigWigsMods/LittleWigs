
--------------------------------------------------------------------------------
-- TODO List:
-- - We shouldn't start timers which would end in Submerged Phase

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Helya", 1492, 1663)
if not mod then return end
mod:RegisterEnableMob(96759)
mod.engageId = 1824

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.destructor_tentacle = -12364
	L.destructor_tentacle_desc = -12366
	L.destructor_tentacle_icon = "inv_misc_monsterhorn_03"
end

--------------------------------------------------------------------------------
-- Locals
--

local firstTorrent = nil
local afterCorrupted = nil
local tentacleDeaths = 0
local seen = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{197262, "SAY"}, -- Taint of the Sea
		202088, -- Brackwater Barrage
		"destructor_tentacle", -- Destructor Tentacle
		185539, -- Rapid Rupture
		"stages",
		196947, -- Submerged
		198495, -- Torrent
		227233, -- Corrupted Below
	}, {
		[197262] = -12358, -- Phase 1
		[196947] = -12367, -- Phase 2
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TaintOfTheSea", 197262)
	self:Log("SPELL_AURA_APPLIED", "RapidRupture", 185539)
	self:Log("SPELL_AURA_APPLIED", "Submerged", 196947)
	self:Log("SPELL_AURA_REMOVED", "SubmergedRemoved", 196947)
	self:Log("SPELL_CAST_START", "Torrent", 198495)
	self:Log("SPELL_CAST_START", "CorruptedBellow", 227233)
	self:Log("SPELL_CAST_START", "BrackwaterBarrage", 202088)

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

function mod:OnEngage()
	firstTorrent = nil
	afterCorrupted = nil
	tentacleDeaths = 0

	self:CDBar("destructor_tentacle", 26, L.destructor_tentacle, L.destructor_tentacle_icon)
	if not self:Normal() then
		self:CDBar(202088, 15.6) -- Brackwater Barrage
	end

	-- check on IEEU for changes since IEEU fires before tentacle death events, so they don't have a boss token anymore :\
	seen = {}
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckTentacles")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	function mod:CheckTentacles()
		local bosses = {}
		for i = 1, 5 do
			local guid = self:UnitGUID(("boss%d"):format(i))
			if guid then
				bosses[guid] = true
			end
		end
		for guid in next, seen do
			if not bosses[guid] and self:MobId(guid) ~= 96759 then
				tentacleDeaths = tentacleDeaths + 1
				if tentacleDeaths < 7 then
					self:MessageOld("stages", "cyan", "info", CL.mob_remaining:format(self:SpellName(201178), 6 - tentacleDeaths), false) -- 201178 = Tentacle
				end
			end
			seen[guid] = nil
		end
		seen = bosses
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg) -- Destructor Tentacle
	if msg:find("inv_misc_monsterhorn_03", nil, true) then -- |TInterface\\Icons\\inv_misc_monsterhorn_03.blp:20|t A %s emerges!#Destructor Tentacle###Destructor Tentacle
		self:MessageOld("destructor_tentacle", "yellow", self:Tank() and "warning", CL.spawned:format(self:SpellName(L.destructor_tentacle)), L.destructor_tentacle_icon)
		self:CDBar("destructor_tentacle", 26, L.destructor_tentacle, L.destructor_tentacle_icon) -- 25-27, but can be delayed upto 10s by Piercing Tentacle (I think)
	end
end

function mod:TaintOfTheSea(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alert", nil, nil, self:Dispeller("magic"))
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Taint of the Sea")
	end
end

function mod:RapidRupture(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "warning", CL.you:format(args.spellName))
	end
end

function mod:Submerged(args)
	self:StopBar(L.destructor_tentacle) -- Destructor Tentacle
	self:StopBar(198495) -- Torrent
	self:StopBar(227233) -- Corrupted Bellow
	self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")

	self:MessageOld(args.spellId, "cyan", "info")
	self:Bar(args.spellId, 15)
	firstTorrent = true
end

function mod:SubmergedRemoved(args)
	self:MessageOld(args.spellId, "cyan", "info", CL.over:format(args.spellName))
	self:CDBar(198495, 10) -- Torrent
end

function mod:Torrent(args)
	self:CDBar(args.spellId, not afterCorrupted and 11 or 13.5)

	if firstTorrent then
		self:CDBar(196947, 59, nil, "spell_nature_wispsplode") -- Submerged / Intermission phase
	end

	firstTorrent = nil
	afterCorrupted = nil
	self:MessageOld(args.spellId, "red", "warning", CL.casting:format(args.spellName))
end

function mod:CorruptedBellow(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:Bar(args.spellId, 22)
	afterCorrupted = true
end

function mod:BrackwaterBarrage(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:CDBar(args.spellId, 22.2)
end
