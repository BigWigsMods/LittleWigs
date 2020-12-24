
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nalthor the Rimebinder", 2286, 2396)
if not mod then return end
mod:RegisterEnableMob(162693) -- Nalthor the Rimebinder
mod.engageId = 2390
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.aegis = "%s removed after %.1f seconds!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320772, -- Comet Storm
		321368, -- Icebound Aegis
		{320788, "SAY"}, -- Frozen Binds
		321894, -- Dark Exile
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CometStorm", 320772)
	self:Log("SPELL_AURA_APPLIED", "IceboundAegisApplied", 321368)
	self:Log("SPELL_AURA_REMOVED", "IceboundAegisRemoved", 321368)
	self:Log("SPELL_CAST_SUCCESS", "FrozenBinds", 320788)
	self:Log("SPELL_CAST_SUCCESS", "DarkExile", 321894)
end

function mod:OnEngage()
	self:CDBar(320788, 8) -- Frozen Binds
	self:CDBar(321368, 13) -- Icebound Aegis
	self:CDBar(320772, 18) -- Comet Storm
	self:CDBar(321894, 26) -- Dark Exile
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CometStorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 6) -- 2s Cast, 4s Channel
	self:Bar(args.spellId, 25.5)
end

do
	local seconds = 0
	function mod:IceboundAegisApplied(args)
		seconds = args.time
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		self:Bar(args.spellId, 25.5)
	end

	function mod:IceboundAegisRemoved(args)
		seconds = math.floor((args.time - seconds) * 100)/100
		self:Message(args.spellId, "green", L.aegis:format(args.spellName, seconds))
	end
end

function mod:FrozenBinds(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:Bar(args.spellId, 25.5)
end

function mod:DarkExile(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:CDBar(args.spellId, 35)
end
