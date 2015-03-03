
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fleshrender Nok'gar", 987, 1235)
if not mod then return end
mod:RegisterEnableMob(81297, 81305) -- Dreadfang, Fleshrender Nok'gar

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

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
		{164426, "FLASH"}, -- Reckless Provocation
		{164837, "ICON"}, -- Savage Mauling
		164835, -- Bloodletting Howl
		164632, -- Burning Arrows
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "BloodlettingHowl", 164835)
	self:Log("SPELL_AURA_APPLIED", "BurningArrows", 164632)

	self:Log("SPELL_AURA_APPLIED", "SavageMauling", 164837)
	self:Log("SPELL_AURA_REMOVED", "SavageMaulingOver", 164837)

	self:Log("SPELL_AURA_APPLIED", "RecklessProvocation", 164426)
	self:Log("SPELL_CAST_START", "RecklessProvocationInc", 164426)

	self:Death("Deaths", 81297, 81305) -- Dreadfang, Fleshrender Nok'gar
end

function mod:OnEngage()
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BloodlettingHowl(args)
	local id = self:MobId(args.destGUID)
	if id == 81297 or id == 81305 then -- Trash also gain it
		self:TargetMessage(args.spellId, args.destName, "Attention", self:Dispeller("enrage", true) and "Long")
	end
end

function mod:BurningArrows(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.you:format(args.spellName))
	end
end

function mod:SavageMauling(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:TargetBar(args.spellId, 6, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SavageMaulingOver(args)
	self:PrimaryIcon(args.spellId)
end

function mod:RecklessProvocationInc(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.incoming:format(args.spellName))
	self:Flash(args.spellId)
end

function mod:RecklessProvocation(args)
	self:Bar(args.spellId, 5)
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths > 1 then
		self:Win()
	end
end

