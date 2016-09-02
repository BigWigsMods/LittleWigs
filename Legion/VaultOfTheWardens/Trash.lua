
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vault of the Wardens Trash", 1045)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	96587, -- Felsworn Infester
	99649, -- Dreadlord Mendacius
	102566 -- Grimhorn the Enslaver
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.infester = "Felsworn Infester"
	L.mendacius = "Dreadlord Mendacius"
	L.grimhorn = "Grimhorn the Enslaver"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Felsworn Infester ]]--
		{193069, "SAY"}, -- Nightmares

		--[[ Dreadlord Mendacius ]]--
		{196249, "FLASH"}, -- Meteor

		--[[ Grimhorn the Enslaver ]]--
		{202615, "SAY"}, -- Torment
	}, {
		[193069] = L.infester,
		[196249] = L.mendacius,
		[202615] = L.grimhorn,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[[ Felsworn Infester ]]--
	self:Log("SPELL_CAST_START", "NightmaresCast", 193069)
	self:Log("SPELL_AURA_APPLIED", "NightmaresApplied", 193069)

	--[[ Dreadlord Mendacius ]]--
	self:Log("SPELL_CAST_START", "Meteor", 196249)

	--[[ Grimhorn the Enslaver ]]--
	self:Log("SPELL_AURA_APPLIED", "Torment", 202615)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

--[[ Felsworn Infester ]]--
function mod:NightmaresCast(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Info", CL.casting:format(args.spellName))
end

function mod:NightmaresApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", self:Healer() and "Alarm")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

--[[ Dreadlord Mendacius ]]--
function mod:Meteor(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.incoming:format(args.spellName))
end

--[[ Grimhorn the Enslaver ]]--
function mod:Torment(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	self:TargetBar(args.spellId, args.destName, 6)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end
