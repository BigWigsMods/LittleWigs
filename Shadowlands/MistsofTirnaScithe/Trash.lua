
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Atonement Trash", 2287)
if not mod then return end
mod.displayName = CL.trash
-- mod:RegisterEnableMob(
-- 	128434, -- Feasting Skyscreamer
-- 	128455, -- T'lonja
-- 	127879, -- Shieldbearer of Zul
-- 	122969, -- Zanchuli Witch-Doctor
-- 	129553, -- Dinomancer Kish'o
-- 	132126, -- Gilded Priestess
-- 	122970, -- Shadowblade Stalker
-- 	122973, -- Dazar'ai Confessor
-- 	122972  -- Dazar'ai Augur
-- )

--------------------------------------------------------------------------------
-- Localization
--

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"berserk"
	}
end

function mod:OnBossEnable()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
