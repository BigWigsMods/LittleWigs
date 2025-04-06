--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magister Umbric", 2213)
if not mod then return end
mod:RegisterEnableMob(
	158035, -- Magister Umbric
	233681 -- Magister Umbric (Revisited)
)
mod:SetEncounterID({2377, 3085}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local frozenStormCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.magister_umbric = "Magister Umbric"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		309373, -- Entropic Missiles
		309648, -- Tainted Polymorph
		{309451, "CASTBAR"}, -- Frozen Storm
	}
end

function mod:OnRegister()
	self.displayName = L.magister_umbric
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Entropic Missiles
	self:Log("SPELL_CAST_START", "TaintedPolymorph", 309648)
	self:Log("SPELL_CAST_SUCCESS", "FrozenStorm", 309451)
	self:Log("SPELL_AURA_REMOVED", "FrozenStormRemoved", 309451)
end

function mod:OnEngage()
	frozenStormCount = 1
	self:CDBar(309373, 3.2) -- Entropic Missiles
	self:CDBar(309648, 8.1) -- Tainted Polymorph
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 309035 then -- Entropic Missiles
		-- UNIT_SPELLCAST_SUCCEEDED 309035 fires when the channel starts.
		-- SPELL_CAST_SUCCESS 309373 fires for every tick of the channel.
		self:Message(309373, "orange", CL.casting:format(self:SpellName(309373)))
		self:CDBar(309373, 9.7)
		self:PlaySound(309373, "warning")
	end
end

function mod:TaintedPolymorph(args)
	if self:IsEngaged() then -- also cast by Alleria Windrunner
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 20.7)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FrozenStorm(args)
	if frozenStormCount == 1 then
		self:Message(args.spellId, "cyan", CL.percent:format(66, args.spellName))
	else
		self:Message(args.spellId, "cyan", CL.percent:format(33, args.spellName))
	end
	frozenStormCount = frozenStormCount + 1
	self:CastBar(args.spellId, 30)
	self:PlaySound(args.spellId, "long")
end

function mod:FrozenStormRemoved(args)
	self:StopCastBar(args.spellId)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
