--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nalthor the Rimebinder", 2286, 2396)
if not mod then return end
mod:RegisterEnableMob(162693) -- Nalthor the Rimebinder
mod:SetEncounterID(2390)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320772, -- Comet Storm
		321368, -- Icebound Aegis
		{320788, "ICON", "SAY"}, -- Frozen Binds
		321894, -- Dark Exile
		-- Mythic
		{328181, "ME_ONLY", "SAY_COUNTDOWN"}, -- Frigid Cold
	}, {
		[328181] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CometStorm", 320772)
	self:Log("SPELL_AURA_APPLIED", "IceboundAegisApplied", 321368, 321754) -- Normal/Heroic, Mythic
	self:Log("SPELL_AURA_REMOVED", "IceboundAegisRemoved", 321368, 321754) -- Normal/Heroic, Mythic
	self:Log("SPELL_CAST_START", "FrozenBinds", 320788)
	self:Log("SPELL_AURA_APPLIED", "FrozenBindsApplied", 320788)
	self:Log("SPELL_AURA_REMOVED", "FrozenBindsRemoved", 320788)
	self:Log("SPELL_MISSED", "FrozenBindsRemoved", 320788) -- Anti-Magic Shell, Blessing of Freedom, immunities, etc.
	self:Log("SPELL_CAST_SUCCESS", "DarkExile", 321894)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "ChampionsBoonApplied", 345323) -- for Frigid Cold
	self:Log("SPELL_AURA_REMOVED", "FrigidColdRemoved", 328181)
end

function mod:OnEngage()
	self:CDBar(320788, 7.0) -- Frozen Binds
	self:CDBar(321368, 12.2) -- Icebound Aegis
	self:CDBar(320772, 18.3) -- Comet Storm
	if not self:Solo() then
		self:CDBar(321894, 25.4) -- Dark Exile
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CometStorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 24.3)
end

do
	local iceboundAegisStart = 0
	function mod:IceboundAegisApplied(args)
		iceboundAegisStart = args.time
		self:Message(321368, "cyan")
		self:PlaySound(321368, "alert")
		-- this will not be recast if the shield is still up when it comes off CD, but in this scenario
		-- it will be cast almost immediately after the shield is finally removed.
		self:CDBar(321368, 24.3)
	end

	function mod:IceboundAegisRemoved(args)
		self:Message(321368, "green", CL.removed_after:format(args.spellName, args.time - iceboundAegisStart))
		self:PlaySound(321368, "info")
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(320788, "orange", name, CL.casting:format(self:SpellName(320788)))
		self:PlaySound(320788, "alert", nil, name)
		if self:Me(guid) then
			self:Say(320788, nil, nil, "Frozen Binds")
		end
	end

	function mod:FrozenBinds(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 24.3)
	end
end

function mod:FrozenBindsApplied(args)
	-- doesn't apply if immune
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:FrozenBindsRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:DarkExile(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "long", nil, args.destName)
	self:CDBar(args.spellId, 35.2)
end

function mod:ChampionsBoonApplied(args)
	if self:Mythic() then
		-- Frigid Cold is removed 5s after gaining Champion's Boon, which drops Razorshard Ice
		self:TargetMessage(328181, "yellow", args.destName) -- Frigid Cold
		self:PlaySound(328181, "alert", nil, args.destName) -- Frigid Cold
		self:TargetBar(328181, 5.0, args.destName) -- Frigid Cold
		if self:Me(args.destGUID) then
			self:SayCountdown(328181, 5.0) -- Frigid Cold
		end
	end
end

function mod:FrigidColdRemoved(args)
	self:StopBar(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end
