if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kobyss Delve Trash", {2687, 2689}) -- The Sinkhole, Tek-Rethan Abyss
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	210759, -- Brann Bronzebeard
	214628, -- Partially-Chewed Goblin (Tek-Rethan Abyss gossip NPC)
	214625, -- Kobyss Necromancer
	214338, -- Kobyss Spearfisher
	214551 -- Wandering Gutter
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kobyss_necromancer = "Kobyss Necromancer"
	L.kobyss_spearfisher = "Kobyss Spearfisher"
	L.wandering_gutter = "Wandering Gutter"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Kobyss Necromancer
		455932, -- Defiling Breath
		445252, -- Necrotic End
		-- Kobyss Spearfisher
		430037, -- Spearfish
		-- Wandering Gutter
		445492, -- Serrated Cleave
		445407, -- Bloodthirsty
	}, {
		[455932] = L.kobyss_necromancer,
		[430037] = L.kobyss_spearfisher,
		[445492] = L.wandering_gutter,
	}, {
		[445407] = CL.fixate, -- Bloodthirsty (Fixate)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Kobyss Necromancer
	self:Log("SPELL_CAST_START", "DefilingBreath", 455932)
	self:Log("SPELL_CAST_SUCCESS", "NecroticEnd", 445252)

	-- Kobyss Spearfisher
	self:Log("SPELL_CAST_START", "Spearfish", 430037)

	-- Wandering Gutter
	self:Log("SPELL_CAST_START", "SerratedCleave", 445492)
	self:Log("SPELL_AURA_APPLIED", "Bloodthirsty", 445407)
end

function mod:VerifyEnable(_, mobId, mapId)
	-- enable if the mob is not Brann, or if we're in Tek-Rathan Abyss.
	-- Brann enablement is needed in The Sinkhole because the gossip mob is dead.
	return mobId ~= 210759 or select(8, GetInstanceInfo()) == 2689
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(120132) then -- Tek-Rethan Abyss, start Delve
			-- 120132:|cFF0000FF(Delve)|r <Take the instruction manual and find the repair kits.>
			self:SelectGossipID(120132)
		end
	end
end

-- Kobyss Necromancer

function mod:DefilingBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:NecroticEnd(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Kobyss Spearfisher

function mod:Spearfish(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
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
