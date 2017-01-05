--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Eye of Azshara Trash", 1046)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	91783, -- Hatecoil Stormweaver
	95861, -- Hatecoil Oracle
	91790, -- Mak'rana Siltwalker
	97173 -- Restless Tides
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.stormweaver = "Hatecoil Stormweaver"
	L.oracle = "Hatecoil Oracle"
	L.siltwalker = "Mak'rana Siltwalker"
	L.tides = "Restless Tides"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Hatecoil Stormweaver ]]--
		196870, -- Storm

		--[[ Hatecoil Oracle ]]--
		195046, -- Rejuvenating Waters

		--[[ Mak'rana Siltwalker ]]--
		196127, -- Spray Sand

		--[[ Restless Tides ]]--
		195284 -- Undertow
	}, {
		[196870] = L.stormweaver,
		[195046] = L.oracle,
		[196127] = L.siltwalker,
		[195284] = L.tides
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Storm", 196870)
	self:Log("SPELL_CAST_START", "RejuvenatingWaters", 195046)
	self:Log("SPELL_CAST_START", "SpraySand", 196127)
	self:Log("SPELL_CAST_START", "Undertow", 195284)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hatecoil Stormweaver
function mod:Storm(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

-- Hatecoil Oracle
function mod:RejuvenatingWaters(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

-- Mak'rana Siltwalker
function mod:SpraySand(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

-- Restless Tides
function mod:Undertow(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end
