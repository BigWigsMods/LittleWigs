--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Soulbound Goliath", 1862, 2126)
if not mod then return end
mod:RegisterEnableMob(131667) -- Soulbound Goliath
mod:SetEncounterID(2114)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

local soulThornsMarker = mod:AddMarkerOption(true, "npc", 8, 267907, 8) -- Soul Thorns
function mod:GetOptions()
	return {
		{260508, "TANK"}, -- Crush
		260512, -- Soul Harvest
		{267907, "SAY"}, -- Soul Thorns
		soulThornsMarker,
		260541, -- Burning Brush
		260569, -- Wildfire
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "SoulHarvest", 260512)
	self:Log("SPELL_CAST_SUCCESS", "SoulThorns", 260551)
	self:Log("SPELL_SUMMON", "SoulThornsSummon", 267907)
	self:Log("SPELL_AURA_APPLIED", "SoulThornsApplied", 267907)
	self:Log("SPELL_AURA_REMOVED", "SoulThornsRemoved", 267907)
	self:Log("SPELL_CAST_START", "Crush", 260508)
	self:Log("SPELL_AURA_APPLIED", "BurningBrush", 260541)
	self:Log("SPELL_AURA_APPLIED", "WildfireDamage", 260569)
end

function mod:OnEngage()
	self:CDBar(260508, 5.9) -- Crush
	self:CDBar(267907, 9.9) -- Soul Thorns
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SoulHarvest(args)
	if args.amount >= 10 and args.amount % 5 == 0 then
		self:Message(args.spellId, "yellow", CL.stack:format(args.amount, args.spellName, CL.boss))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SoulThorns()
	self:CDBar(267907, 21.8)
end

function mod:SoulThornsApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Soul Thorns")
	end
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:TargetBar(args.spellId, 15, args.destName)
end

do
	local soulThornsGUID = nil

	function mod:SoulThornsSummon(args)
		-- register events to auto-mark Soul Thorns
		if self:GetOption(soulThornsMarker) then
			soulThornsGUID = args.destGUID
			self:RegisterTargetEvents("MarkSoulThorns")
		end
	end

	function mod:MarkSoulThorns(_, unit, guid)
		if soulThornsGUID == guid then
			soulThornsGUID = nil
			self:CustomIcon(soulThornsMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:SoulThornsRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:Crush(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17.0)
end

function mod:BurningBrush(args)
	self:Message(args.spellId, "cyan", CL.other:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "long")
end

function mod:WildfireDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end
