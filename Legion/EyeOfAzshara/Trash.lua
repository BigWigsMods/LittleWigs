--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Eye of Azshara Trash", 1456)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	100216, -- Hatecoil Wrangler
	91783, -- Hatecoil Stormweaver
	91782, -- Hatecoil Crusher
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
	L.wrangler = "Hatecoil Wrangler"
	L.stormweaver = "Hatecoil Stormweaver"
	L.crusher = "Hatecoil Crusher"
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
		--[[ Hatecoil Wrangler ]]--
		225089, -- Lightning Prod

		--[[ Hatecoil Stormweaver & Mystic Ssa'veh ]]--
		196870, -- Storm
		195109, -- Arc Lightning

		--[[ Hatecoil Crusher ]]--
		195129, -- Thundering Stomp

		--[[ Hatecoil Oracle ]]--
		195046, -- Rejuvenating Waters

		--[[ Mak'rana Siltwalker ]]--
		196127, -- Spray Sand

		--[[ Restless Tides ]]--
		195284, -- Undertow

		--[[ Hatecoil Arcanist & Ritualist Lesha ]]--
		196027, -- Aqua Spout
		197105, -- Polymorph: Fish
	}, {
		[225089] = L.wrangler,
		[196870] = L.stormweaver,
		[195129] = L.crusher,
		[195046] = L.oracle,
		[196127] = L.siltwalker,
		[195284] = L.tides,
		[196027] = L.arcanist
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "LightningProd", 225089)
	self:Log("SPELL_CAST_START", "Storm", 196870)
	self:Log("SPELL_CAST_START", "ArcLightning", 195109)
	self:Log("SPELL_CAST_START", "ThunderingStomp", 195129)
	self:Log("SPELL_CAST_START", "RejuvenatingWaters", 195046)
	self:Log("SPELL_CAST_START", "SpraySand", 196127)
	self:Log("SPELL_CAST_START", "Undertow", 195284)
	self:Log("SPELL_CAST_START", "AquaSpout", 196027)
	self:Log("SPELL_AURA_APPLIED", "PolymorphFish", 197105)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hatecoil Wrangler
function mod:LightningProd(args)
	self:MessageOld(args.spellId, "orange", "warning", CL.casting:format(args.spellName))
end

-- Hatecoil Stormweaver
function mod:Storm(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.casting:format(args.spellName))
end

function mod:ArcLightning(args)
	self:MessageOld(args.spellId, "yellow", "alarm", CL.casting:format(args.spellName))
end

-- Hatecoil Crusher
function mod:ThunderingStomp(args)
	self:MessageOld(args.spellId, "red", self:Interrupter() and "warning" or "info", CL.casting:format(args.spellName))
end

-- Hatecoil Oracle
function mod:RejuvenatingWaters(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
end

-- Mak'rana Siltwalker
function mod:SpraySand(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.casting:format(args.spellName))
end

-- Restless Tides
function mod:Undertow(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.casting:format(args.spellName))
end

-- Hatecoil Arcanist

function mod:AquaSpout(args)
	self:MessageOld(args.spellId, "yellow", "alarm", CL.casting:format(args.spellName))
end

function mod:PolymorphFish(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "info", self:SpellName(118), nil, true) -- 118 is Polymorph, which is shorter than "Polymorph: Fish"
	end
end
