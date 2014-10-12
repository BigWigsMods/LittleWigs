
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Commander Tharbek", 995, 1228)
if not mod then return end
mod:RegisterEnableMob(79912, 80098) -- Commander Tharbek, Ironbarb Skyreaver

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
		161833, -- Noxious Spit
		162090, -- Imbued Iron Axe
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "NoxiousSpit", 161833)
	self:Log("SPELL_CAST_SUCCESS", "ImbuedIronAxe", 162090)

	self:Death("Win", 79912)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NoxiousSpit(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

function mod:ImbuedIronAxe(args)
	self:Message(args.spellId, "Attention", "Info")
end

