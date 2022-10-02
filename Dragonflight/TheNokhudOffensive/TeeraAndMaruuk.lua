if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Teera And Maruuk", 2516, 2478)
if not mod then return end
mod:RegisterEnableMob(
	186339, -- Teera
	186338  -- Maruuk
)
mod:SetEncounterID(2581)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		392198, -- Ancestral Bond
		-- Teera
		382670, -- Gale Arrow
		384808, -- Guardian Wind (or Repel 386547?)
		385434, -- Spirit Leap
		-- Maruuk
		385339, -- Earthsplitter
		386063, -- Frightful Roar
		{382836, "TANK_HEALER"}, -- Brutalize
	}, {
		[392198] = CL.general,
		[382670] = -25552, -- Teera
		[385339] = -25546, -- Maruuk
	}
end

function mod:OnBossEnable()

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

