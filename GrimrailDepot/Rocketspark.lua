
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Rocketspark and Borka", 993, 1138)
mod:RegisterEnableMob(77816, 77803) -- Borka, Rocketspark

--------------------------------------------------------------------------------
-- Locals
--

local deathCount = 0

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
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	--self:Log("SPELL_CAST_START", "HolyShield", 153002)
	--self:Log("SPELL_CAST_START", "ConsecratedLight", 153006)

	self:Death("Deaths", 74787, 7803) -- Borka, Rocketspark
end

function mod:OnEngage()
	deathCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Deaths()
	deathCount = deathCount + 1
	if deathCount > 1 then
		self:Win()
	end
end

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

