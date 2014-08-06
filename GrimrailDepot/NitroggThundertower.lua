
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 993, 1163)
mod:RegisterEnableMob(79545)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"bosskill",
	}
end

function mod:OnBossEnable()
	--self:Log("SPELL_CAST_START", "HolyShield", 153002)
	--self:Log("SPELL_CAST_START", "ConsecratedLight", 153006)

	self:Death("Win", 79545)
end

--------------------------------------------------------------------------------
-- Event Handlers
--
--[[
function mod:HolyShield(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 47)
	self:Bar(153006, 7)
end

function mod:ConsecratedLight(args)
	self:Message(args.spellId, "Important", "Alert")
	self:Bar(args.spellId, 9, CL.cast:format(args.spellName))
end]]

