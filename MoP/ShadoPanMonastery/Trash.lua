--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shado-Pan Monastery Trash", 959)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	56765, -- Destroying Sha
	58803, -- Residual Hatred
	58807, -- Vestige of Hatred
	58810, -- Fragment of Hatred
	58794  -- Slain Shado-Pan Defender
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.destroying_sha = "Destroying Sha"
	L.slain_shado_pan_defender = "Slain Shado-Pan Defender"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Destroying Sha
		106942, -- Shadows of Destruction
		-- Slain Shado-Pan Defender
		111690, -- Purification Ritual
	}, {
		[106942] = L.destroying_sha,
		[111690] = L.slain_shado_pan_defender,
	}
end

function mod:OnBossEnable()
	-- Destroying Sha
	self:Log("SPELL_CAST_SUCCESS", "ShadowsOfDestruction", 106942)

	-- Slain Shado-Pan Defender
	self:Log("SPELL_CAST_SUCCESS", "PurificationRitual", 111690)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Destroying Sha

do
	local prev = 0
	function mod:ShadowsOfDestruction(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Slain Shado-Pan Defender

function mod:PurificationRitual(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end
