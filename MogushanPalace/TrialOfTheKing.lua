
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the King", 885, 708)
mod:RegisterEnableMob(61444, 61442, 61445) -- Ming, Kuai, Haiyan

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "yell"


end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"bosskill"}
end

function mod:OnBossEnable()
	--self:Log("SPELL_AURA_APPLIED", "BlazingFists", 114807)
	--self:Log("SPELL_CAST_SUCCESS", "FirestormKick", 113764)

	--self:Log("SPELL_DAMAGE", "ScorchedEarthYou", 114465)
	--self:Log("SPELL_MISSED", "ScorchedEarthYou", 114465)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	--self:Death("Win", 59223)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--
--[[
function mod:BlazingFists(_, spellId, _, _, spellName)
	self:Message("fists", spellName, "Urgent", spellId, "Alarm")
	self:Bar("fists", CL["cast"]:format(spellName), 6, spellId)
	self:Bar("fists", spellName, 30, spellId)
end

function mod:ScorchedEarthYou(player, _, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(114460, CL["underyou"]:format(spellName), "Personal", 114460, "Alert")
		self:FlashShake(114460)
	end
end

function mod:FirestormKick(player, spellId, _, _, spellName)
	self:Message("firestorm", spellName, "Attention", spellId, "Info")
	self:Bar("firestorm", CL["cast"]:format(spellName), 6, spellId)
	self:Bar("firestorm", spellName, 25.2, spellId)
end
]]
