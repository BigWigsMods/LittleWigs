--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Eye of Azshara Trash", 1046)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	91783, -- Hatecoil Stormweaver
	98173, -- Mystic Ssa'veh
	95861, -- Hatecoil Oracle
	91790, -- Mak'rana Siltwalker
	97173, -- Restless Tides
	97171, -- Hatecoil Arcanist
	100248 -- Ritualist Lesha
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.stormweaver = "Hatecoil Stormweaver"
	L.oracle = "Hatecoil Oracle"
	L.siltwalker = "Mak'rana Siltwalker"
	L.tides = "Restless Tides"
	L.arcanist = "Hatecoil Arcanist"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Hatecoil Stormweaver & Mystic Ssa'veh ]]--
		196870, -- Storm
		195109, -- Arc Lightning

		--[[ Hatecoil Oracle ]]--
		195046, -- Rejuvenating Waters

		--[[ Mak'rana Siltwalker ]]--
		196127, -- Spray Sand

		--[[ Restless Tides ]]--
		195284, -- Undertow

		--[[ Hatecoil Arcanist & Ritualist Lesha ]]--
		196027 -- Aqua Spout
	}, {
		[196870] = L.stormweaver,
		[195046] = L.oracle,
		[196127] = L.siltwalker,
		[195284] = L.tides,
		[196027] = L.arcanist
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Storm", 196870)
	self:Log("SPELL_CAST_START", "ArcLightning", 195109)
	self:Log("SPELL_CAST_START", "RejuvenatingWaters", 195046)
	self:Log("SPELL_CAST_START", "SpraySand", 196127)
	self:Log("SPELL_CAST_START", "Undertow", 195284)
	self:Log("SPELL_CAST_START", "AquaSpout", 196027)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hatecoil Stormweaver
function mod:Storm(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

function mod:ArcLightning(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
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

-- Hatecoil Arcanist

function mod:AquaSpout(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
end
