if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Underkeep Trash", 2690)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	219022, -- Ascended Webfriar
	219035 -- Deepwalker Guardian
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ascended_webfriar = "Ascended Webfriar"
	L.deepwalker_guardian = "Deepwalker Guardian"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ascended Webfriar
		451913, -- Grimweave Orb
		-- Deepwalker Guardian
		450714, -- Jagged Barbs
		450637, -- Leeching Swarm
	}, {
		[450714] = L.deepwalker_guardian,
	}
end

function mod:OnBossEnable()
	-- Ascended Webfriar
	-- TODO there no SPELL_CAST_START, which would happen ~2s? earlier
	self:Log("SPELL_SUMMON", "GrimweaveOrb", 451913)

	-- Deepwalker Guardian
	self:Log("SPELL_CAST_START", "JaggedBarbs", 450714)
	self:RegisterEvent("UNIT_SPELLCAST_START")
	--self:Log("SPELL_CAST_START", "LeechingSwarm", 450637) -- TODO no CLEU
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ascended Webfriar

function mod:GrimweaveOrb(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Deepwalker Guardian

function mod:JaggedBarbs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_START(_, unit, castGUID, spellId)
		if spellId == 450637 and castGUID ~= prev then -- Leeching Swarm
			prev = castGUID
			self:Message(spellId, "yellow")
			self:PlaySound(spellId, "info")
		end
	end
end
