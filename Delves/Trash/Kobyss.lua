--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kobyss Delve Trash", {2687, 2689}) -- The Sinkhole, Tek-Rethan Abyss
if not mod then return end
mod:RegisterEnableMob(
	210759, -- Brann Bronzebeard
	228903, -- Brann Bronzebeard
	220565, -- Raen Dawncavalyr (The Sinkhole gossip NPC)
	214628, -- Partially-Chewed Goblin (Tek-Rethan Abyss gossip NPC)
	214625, -- Kobyss Necromancer
	220710, -- Leviathan Manipulator
	214338, -- Kobyss Spearfisher
	214251, -- Kobyss Witherer
	214551, -- Wandering Gutter
	216325 -- Crazed Predator
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kobyss_trash = "Kobyss Trash"

	L.kobyss_necromancer = "Kobyss Necromancer"
	L.kobyss_spearfisher = "Kobyss Spearfisher"
	L.kobyss_witherer = "Kobyss Witherer"
	L.wandering_gutter = "Wandering Gutter"
	L.crazed_predator = "Crazed Predator"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.kobyss_trash
end

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Kobyss Necromancer / Leviathan Manipulator
		455932, -- Defiling Breath
		445252, -- Necrotic End
		-- Kobyss Spearfisher
		430037, -- Spearfish
		-- Kobyss Witherer
		440622, -- Curse of the Depths
		-- Wandering Gutter
		445492, -- Serrated Cleave
		445407, -- Bloodthirsty
		-- Crazed Predator
		445774, -- Thrashing Frenzy
	}, {
		[455932] = L.kobyss_necromancer,
		[430037] = L.kobyss_spearfisher,
		[440622] = L.kobyss_witherer,
		[445492] = L.wandering_gutter,
		[445774] = L.crazed_predator,
	}, {
		[445407] = CL.fixate, -- Bloodthirsty (Fixate)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Kobyss Necromancer / Leviathan Manipulator
	self:Log("SPELL_CAST_START", "DefilingBreath", 455932)
	self:Log("SPELL_CAST_SUCCESS", "NecroticEnd", 445252)

	-- Kobyss Spearfisher
	self:Log("SPELL_CAST_START", "Spearfish", 430037)

	-- Kobyss Witherer
	self:Log("SPELL_CAST_START", "CurseOfTheDepths", 440622)

	-- Wandering Gutter
	self:Log("SPELL_CAST_START", "SerratedCleave", 445492)
	self:Log("SPELL_AURA_APPLIED", "Bloodthirsty", 445407)

	-- Crazed Predator
	self:Log("SPELL_CAST_START", "ThrashingFrenzy", 445774)
end

function mod:VerifyEnable(_, mobId)
	-- enable if the mob is not Brann, or if we're in Tek-Rathan Abyss.
	-- Brann enablement is needed in The Sinkhole because the gossip mob is dead.
	return (mobId ~= 210759 and mobId ~= 228903) or select(8, GetInstanceInfo()) == 2689
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	local info = self:GetWidgetInfo("delve", 6183)
	local level = info and tonumber(info.tierText)
	if (not level or level > 3) and self:GetOption(autotalk) then
		if self:GetGossipID(121578) then -- The Sinkhole, start Delve (Raen Dawncavalyr)
			-- 121578:|cFF0000FF(Delve)|r I'll take your special boots and recover missing relics from the kobyss.
			self:SelectGossipID(121578)
		elseif self:GetGossipID(120132) then -- Tek-Rethan Abyss, start Delve (Partially-Chewed Goblin)
			-- 120132:|cFF0000FF(Delve)|r <Take the instruction manual and find the repair kits.>
			self:SelectGossipID(120132)
		end
	end
end

-- Kobyss Necromancer

do
	local prev = 0
	function mod:DefilingBreath(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:NecroticEnd(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Kobyss Spearfisher

function mod:Spearfish(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Kobyss Witherer

function mod:CurseOfTheDepths(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Wandering Gutter

function mod:SerratedCleave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Bloodthirsty(args)
	self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Crazed Predator

function mod:ThrashingFrenzy(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
