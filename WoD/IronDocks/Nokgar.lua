--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fleshrender Nok'gar", 1195, 1235)
if not mod then return end
mod:RegisterEnableMob(81297, 81305) -- Dreadfang, Fleshrender Nok'gar
mod:SetEncounterID(1749)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{164426, "FLASH"}, -- Reckless Provocation
		164632, -- Burning Arrows
		{164837, "ICON"}, -- Savage Mauling
		164835, -- Bloodletting Howl
	}, {
		["stages"] = "general",
		[164837] = -10437, -- Dreadfang
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BloodlettingHowl", 164835)
	self:Log("SPELL_AURA_APPLIED", "BurningArrows", 164632)

	self:Log("SPELL_AURA_APPLIED", "SavageMauling", 164837)
	self:Log("SPELL_AURA_REMOVED", "SavageMaulingOver", 164837)

	self:Log("SPELL_AURA_APPLIED", "RecklessProvocation", 164426)
	self:Log("SPELL_AURA_REMOVED", "RecklessProvocationOver", 164426)
	self:Log("SPELL_CAST_START", "RecklessProvocationInc", 164426)
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss2")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:Message("stages", "cyan", CL.stage:format(1))
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BloodlettingHowl(args)
	self:Message(args.spellId, "yellow")
	if self:Dispeller("enrage", true) then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:BurningArrows(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "blue", CL.you:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:SavageMauling(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SavageMaulingOver(args)
	self:PrimaryIcon(args.spellId)
end

function mod:RecklessProvocationInc(args)
	self:CDBar(args.spellId, 42.6)
	self:Message(args.spellId, "orange", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:Flash(args.spellId)
end

function mod:RecklessProvocation(args)
	self:Bar(args.spellId, 5, CL.onboss:format(args.spellName))
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:RecklessProvocationOver(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		self:Message("stages", "yellow", CL.soon:format(CL.stage:format(2)))
		self:PlaySound("stages", "info")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 175755 then -- Dismount
		self:Message("stages", "cyan", CL.stage:format(2))
		self:PlaySound("stages", "long")
		self:CDBar(164426, 16) -- Reckless Provocation
	end
end
