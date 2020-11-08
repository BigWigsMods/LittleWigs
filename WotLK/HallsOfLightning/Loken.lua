
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Loken", 602, 600)
if not mod then return end
mod:RegisterEnableMob(28923)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		59835, -- Lightning Nova
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LightningNova", 52960, 59835) -- normal, heroic

	self:Death("Win", 28923)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningNova(args)
	self:MessageOld(59835, "orange", "alert")
	self:Bar(59835, args.spellId == 59835 and 4 or 5)
end

