
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viceroy Nezhar", 1178, 1981)
if not mod then return end
mod:RegisterEnableMob(122056) -- Viceroy Nezhar
mod.engageId = 2067

--------------------------------------------------------------------------------
-- Locals
--

local tentaclesUp = 0
local guardsUp = 0
local eternalTwilightExplo = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tentacles = "Tentacles"
	L.guards = "Guards"
	L.interrupted = "%s interrupted %s (%.1fs left)!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"infobox",
		-15926, -- Umbral Tentacles
		244751, -- Howling Dark
		246324, -- Entropic Force
		244906, -- Collapsing Void
		-16424, -- Summon Ethereal Guards (249336)
		248804, -- Dark Bulwark
		248736, -- Eternal Twilight
	}, {
		["infobox"] = "general",
		[-16424] = "mythic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "TentacleSpawn", 249082)
	self:Death("TentacleDeath", 122827)
	self:Log("SPELL_CAST_START", "HowlingDark", 244751)
	self:Log("SPELL_CAST_START", "EntropicForce", 246324)
	self:Log("SPELL_AURA_REMOVED", "EntropicForceRemoved", 246324)
	self:Log("SPELL_CAST_SUCCESS", "SummonEtherealGuards", 249336)
	self:Log("SPELL_AURA_APPLIED", "DarkBulwark", 248804)
	self:Log("SPELL_AURA_REMOVED", "DarkBulwarkRemoved", 248804)
	self:Log("SPELL_CAST_START", "EternalTwilight", 248736)
	self:Log("SPELL_INTERRUPT", "Interrupt", "*")

	self:Log("SPELL_AURA_APPLIED", "GroundEffectDamage", 244906) -- Collapsing Void
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 244906)
	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 244906)
end

function mod:OnEngage()
	tentaclesUp = 0
	guardsUp = 0
	eternalTwilightExplo = 0
	self:Bar(-15926, 12, L.tentacles) -- Tentacles
	self:Bar(244751, 16) -- Howling Dark
	self:Bar(246324, 32) -- Entropic Force
	if self:Mythic() then
		self:Bar(-16424, 53.5, L.guards, 248804) -- Guards
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UpdateInfoBox()
	if tentaclesUp > 0 or guardsUp > 0 then
		self:OpenInfo("infobox", self.displayName)
		if tentaclesUp > 0 then
			self:SetInfo("infobox", 1, L.tentacles)
			self:SetInfo("infobox", 2, tentaclesUp)
		end
		if guardsUp > 0 then
			self:SetInfo("infobox", 3, L.guards)
			self:SetInfo("infobox", 4, guardsUp)
		end
	else
		self:CloseInfo("infobox")
	end
end

do
	local prev = 0
	function mod:TentacleSpawn(args)
		tentaclesUp = tentaclesUp + 1
		local t = GetTime()
		if t-prev > 3 then
			prev = t
			self:Message(-15926, "Attention", "Info", CL.spawned:format(L.tentacles))
			self:CDBar(-15926, 30.5, L.tentacles)
		end
		self:UpdateInfoBox()
	end
end

function mod:TentacleDeath(args)
	tentaclesUp = tentaclesUp - 1
	self:UpdateInfoBox()
end

function mod:HowlingDark(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:CDBar(args.spellId, 33)
end

function mod:EntropicForce(args)
	self:Message(args.spellId, "Important", "Long")
	self:Bar(args.spellId, 62)
	self:CastBar(args.spellId, 10)
end

function mod:EntropicForceRemoved(args)
	self:StopBar(CL.cast:format(args.spellId))
	self:Message(args.spellId, "Positive", nil, CL.over:format(args.spellName))
end

function mod:SummonEtherealGuards(args)
	self:Message(-15926, "Attention", "Info", CL.spawned:format(L.guards))
	--self:Bar(-16424, ???, L.guards, 248804)
end

function mod:DarkBulwark(args)
	guardsUp = guardsUp + 1
	self:UpdateInfoBox()
end

function mod:DarkBulwarkRemoved(args)
	guardsUp = guardsUp - 1
	if guardsUp > 0 then
		self:Message(args.spellId, "Neutral", nil, CL.mob_remaining:format(args.sourceName, guardsUp))
	else
		self:Message(args.spellId, "Neutral", "Info", CL.removed:format(args.spellName))
	end
	self:UpdateInfoBox()
end

function mod:EternalTwilight(args)
	self:Message(args.spellId, "Neutral", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 10)
	eternalTwilightExplo = GetTime() + 10
end

function mod:Interrupt(args)
	if args.extraSpellId == 248736 then -- Eternal Twilight
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:Message(args.extraSpellId, "Positive", "Long", L.interrupted:format(self:ColorName(args.sourceName), args.extraSpellName, eternalTwilightExplo-GetTime()))
	end
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
		end
	end
end
