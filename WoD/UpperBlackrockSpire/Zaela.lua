
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Zaela", 995, 1234)
if not mod then return end
mod:RegisterEnableMob(77120)
--BOSS_KILL#1762#Warlord Zaela

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{155721, "ICON", "FLASH"}, -- Black Iron Cyclone
		"stages",
	}
end

function mod:VerifyEnable()
	local _, x = UnitPosition("player")
	if x > -240 then
		return true
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "BlackIronCycloneCast", 155721)
	self:Log("SPELL_AURA_APPLIED", "BlackIronCyclone", 155721)
	self:Log("SPELL_AURA_REMOVED", "BlackIronCycloneOver", 155721)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	self:Death("Win", 77120)
end

function mod:OnEngage()
	self:CDBar(155721, 12.5) -- Black Iron Cyclone // 16.1 // 17.1 XXX
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function bossTarget(self, name, guid)
		self:TargetMessage(155721, name, "Attention", "Alert")
		self:PrimaryIcon(155721, name)
		if self:Me(guid) then
			self:Flash(155721)
		end
	end
	function mod:BlackIronCycloneCast(args)
		self:GetBossTarget(bossTarget, 0.3, args.sourceGUID)
		self:CDBar(args.spellId, 19) -- 18-21
	end
end

function mod:BlackIronCyclone(args)
	self:TargetBar(args.spellId, 4.5, args.destName, 33786, args.spellId) -- 33786 = "Cyclone"
end

function mod:BlackIronCycloneOver(args)
	self:PrimaryIcon(args.spellId)
end

function mod:UNIT_TARGETABLE_CHANGED(unit)
	if UnitCanAttack("player", unit) then
		self:Message("stages", "Important", "Info", CL.incoming:format(self.displayName), "achievement_character_orc_female")
	else
		self:Message("stages", "Important", "Info", ("60%% - %s"):format(CL.intermission), "achievement_character_orc_female")
		self:DelayedMessage("stages", 1, "Important", self:SpellName(-10741), "achievement_character_orc_male") -- Black Iron Wyrm Riders
		self:Bar("stages", 28, CL.intermission, "achievement_character_orc_female")
		self:StopBar(155721) -- Black Iron Cyclone
	end
end

