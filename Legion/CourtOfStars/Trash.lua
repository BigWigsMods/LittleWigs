--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Court of Stars Trash", 1087)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	104270, -- Guardian Construct
	104278, -- Felbound Enforcer
	104300 -- Shadow Mistress
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.Construct = "Guardian Construct"
	L.Enforcer = "Felbound Enforcer"
	L.Mistress = "Shadow Mistress"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		225100, -- Charging Station (Guardian Construct)
		209495, -- Charged Smash (Guardian Construct)
		209512, -- Disrupting Energy (Guardian Construct)
		{209413, "SAY", "FLASH"}, -- Suppress (Guardian Construct)
		211464, -- Fel Detonation (Felbound Enforcer)
		{211473, "SAY", "FLASH"}, -- Shadow Slash (Shadow Mistress)
	}, {
		[225100] = L.Construct,
		[211464] = L.Enforcer,
		[211473] = L.Mistress,
}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	-- Charging Station
	self:Log("SPELL_CAST_START", "AlertCasts", 225100)
	-- Fel Detonation, Suppress, Charged Smash
	self:Log("SPELL_CAST_START", "AlarmCasts", 211464, 209413, 209495)
	-- Disrupting Energy
	self:Log("SPELL_AURA_APPLIED", "PeriodicDamage", 209512)
	self:Log("SPELL_PERIODIC_DAMAGE", "PeriodicDamage", 209512)
	self:Log("SPELL_PERIODIC_MISSED", "PeriodicDamage", 209512)
	-- Shadow Slash, Suppress
	self:Log("SPELL_AURA_APPLIED", "DispellableDebuffs", 211473, 209413)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local prevTable = {}
local function throttleMessages(key)
	local t = GetTime()
	if t-(prevTable[key] or 0) > 1.5 then
		prevTable[key] = t
		return false
	else
		return true
	end
end

function mod:AlertCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

function mod:AlarmCasts(args)
	if throttleMessages(args.spellId) then return end
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Warning", CL.underyou:format(args.spellName))
		end
	end
end

function mod:DispellableDebuffs(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", not throttleMessages(args.spellId) and "Alert", nil, nil, self:Dispeller("magic"))
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end


