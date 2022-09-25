if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Brackenhide Hollow Trash", 2520)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	185529, -- Bracken Warscourge
	187033  -- Stinkbreath
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bracken_warscourge = "Bracken Warscourge"
	L.stinkbreath = "Stinkbreath"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Bracken Warscourge
		367500, -- Hideous Cackle
		-- Stinkbreath
		388060, -- Stink Breath
	}, {
		[367500] = L.bracken_warscourge,
		[388060] = L.stinkbreath,
	}
end

function mod:OnBossEnable()
	-- Bracken Warscourge
	self:Log("SPELL_CAST_START", "HideousCackle", 367500)

	-- Stinkbreath
	self:Log("SPELL_CAST_START", "StinkBreath", 388060)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Bracken Warscourge

function mod:HideousCackle(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

-- Bracken Stinkbreath

function mod:StinkBreath(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end
