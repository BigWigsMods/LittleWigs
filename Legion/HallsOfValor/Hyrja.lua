
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hyrja", 1041, 1486)
if not mod then return end
mod:RegisterEnableMob(95833)
--mod.engageId = 1806 -- Fires when you attack the 2 mobs prior to the boss...

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200901, -- Eye of the Storm
		192307, -- Sanctify
		{192048, "ICON", "FLASH", "PROXIMITY"}, -- Expel Light
		192018, -- Shield of Light
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "EyeOfTheStormOrSanctify", 200901, 192307) -- Eye of the Storm, Sanctify
	self:Log("SPELL_CAST_START", "ShieldOfLight", 192018)

	self:Log("SPELL_AURA_APPLIED", "ExpelLight", 192048)
	self:Log("SPELL_AURA_REMOVED", "ExpelLightRemoved", 192048)

	self:Death("Win", 95833)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EyeOfTheStormOrSanctify(args)
	self:Message(args.spellId, "Urgent", "Long")
end

function mod:ShieldOfLight(args)
	self:Message(args.spellId, "Important", "Alert")
	--self:Bar(args.spellId, 30) -- pull:10.3, 21.8, 30.4 / pull:26.7, 30.4, 30.3
end

function mod:ExpelLight(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm", nil, nil, true)
	self:TargetBar(args.spellId, 3, args.destName)
	if self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 8)
		self:Flash(args.spellId)
	else
		self:OpenProximity(args.spellId, 8, args.destName)
	end
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:ExpelLightRemoved(args)
	self:CloseProximity(args.spellId)
	self:PrimaryIcon(args.spellId)
end

