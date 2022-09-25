if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brackenhide Hollow Trash", 2520)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	185529 -- Bracken Warscourge
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bracken_warscourge = "Bracken Warscourge"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Bracken Warscourge
		367500, -- Hideous Cackle
	}, {
		[367500] = L.bracken_warscourge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HideousCackle", 367500)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Bracken Warscourge

function mod:HideousCackle(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
