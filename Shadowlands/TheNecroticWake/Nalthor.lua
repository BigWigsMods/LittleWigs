
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

	L.casting_on_you = "Casting %s on YOU"
	L.casting_on_other = "Casting %s: %s"
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
	self:Log("SPELL_AURA_APPLIED", "IceboundAegisApplied", 321368, 321754) -- normal/heroic, mythic
	self:Log("SPELL_AURA_REMOVED", "IceboundAegisRemoved", 321368, 321754)
	self:Log("SPELL_CAST_START", "FrozenBinds", 320788)
	self:Log("SPELL_CAST_SUCCESS", "FrozenBindsSuccess", 320788)
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
	local appliedAt = 0
	function mod:IceboundAegisApplied(args)
		appliedAt = args.time

		self:Message(321368, "cyan")
		self:PlaySound(321368, "info")
		self:Bar(321368, 25.5)
	end

	function mod:IceboundAegisRemoved(args)
		self:Message(321368, "green", L.aegis:format(args.spellName, args.time - appliedAt))
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:PersonalMessage(320788, false, L.casting_on_you:format(self:SpellName(320788)))
		elseif not self:CheckOption(320788, "ME_ONLY") then
			self:Message(320788, "cyan", L.casting_on_other:format(self:SpellName(320788), self:ColorName(name)))
		end
		self:PlaySound(320788, "info", nil, name)
	end

	function mod:FrozenBinds(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:FrozenBindsSuccess(args)
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
