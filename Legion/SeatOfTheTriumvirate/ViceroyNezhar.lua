--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viceroy Nezhar", 1753, 1981)
if not mod then return end
mod:RegisterEnableMob(122056) -- Viceroy Nezhar
mod:SetEncounterID(2067)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1263532, sound = "underyou"}, -- Void Storm
	{1263542, sound = "alert"}, -- Mass Void Infusion
	{1268733, sound = "alert"}, -- Mind Flay
})

--------------------------------------------------------------------------------
-- Locals
--

local tentaclesUp = 0
local guardsUp = 0
local eternalTwilightExplo = 0
local nextDarkBulwark = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
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
		{246324, "CASTBAR"}, -- Entropic Force
		244906, -- Collapsing Void
		248804, -- Dark Bulwark
		{248736, "CASTBAR"}, -- Eternal Twilight
	}, {
		["infobox"] = "general",
		[248804] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "TentacleSpawn", 249082)
	self:Death("TentacleDeath", 122827)
	self:Log("SPELL_CAST_START", "HowlingDark", 244751)
	self:Log("SPELL_CAST_START", "EntropicForce", 246324)
	self:Log("SPELL_AURA_REMOVED", "EntropicForceRemoved", 246324)
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
	self:Bar(-15926, 12, CL.tentacles) -- Tentacles
	self:Bar(244751, 16) -- Howling Dark
	self:Bar(246324, 32) -- Entropic Force
	if self:Mythic() then
		self:Bar(248804, 53.5, L.guards) -- Guards
		nextDarkBulwark = GetTime() + 53.5
	end
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1263532, "PRIVATE"}, -- Void Storm
			{1263542, "PRIVATE"}, -- Mass Void Infusion
			{1268733, "PRIVATE"}, -- Mind Flay
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if not self:IsSecret(spellId) and spellId == 249336 then -- Summon Ethereal Guards
		self:Message(248804, "yellow", CL.spawned:format(L.guards))
		self:PlaySound(248804, "info")
	end
end

function mod:UpdateInfoBox()
	if tentaclesUp > 0 or guardsUp > 0 then
		self:OpenInfo("infobox", self.displayName)
		if tentaclesUp > 0 then
			self:SetInfo("infobox", 1, CL.tentacles)
			self:SetInfo("infobox", 2, tentaclesUp)
		end
		if guardsUp > 0 then
			self:SetInfo("infobox", tentaclesUp > 0 and 3 or 1, L.guards)
			self:SetInfo("infobox", tentaclesUp > 0 and 4 or 2, guardsUp)
		end
	else
		self:CloseInfo("infobox")
	end
end

do
	local prev = 0
	function mod:TentacleSpawn(args)
		tentaclesUp = tentaclesUp + 1
		if args.time - prev > 3 then
			prev = args.time
			self:Message(-15926, "yellow", CL.spawned:format(CL.tentacles))
			if not self:Mythic() or nextDarkBulwark - GetTime() > 30.5 then
				self:CDBar(-15926, 30.5, CL.tentacles)
			end
			self:PlaySound(-15926, "info")
		end
		self:UpdateInfoBox()
	end
end

function mod:TentacleDeath()
	tentaclesUp = tentaclesUp - 1
	self:UpdateInfoBox()
end

function mod:HowlingDark(args)
	self:Message(args.spellId, "orange")
	if not self:Mythic() or nextDarkBulwark - GetTime() > 31.6 then
		self:CDBar(args.spellId, 31.6)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:EntropicForce(args)
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, 62)
	self:CastBar(args.spellId, 10)
	self:PlaySound(args.spellId, "long")
end

function mod:EntropicForceRemoved(args)
	self:StopBar(CL.cast:format(args.spellId))
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
end

function mod:DarkBulwark()
	guardsUp = guardsUp + 1
	self:UpdateInfoBox()
end

function mod:DarkBulwarkRemoved(args)
	guardsUp = guardsUp - 1
	if guardsUp > 0 then
		self:Message(args.spellId, "cyan", CL.mob_remaining:format(args.sourceName, guardsUp))
	else
		self:Message(args.spellId, "cyan", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
	self:UpdateInfoBox()
end

function mod:EternalTwilight(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 10)
	eternalTwilightExplo = GetTime() + 10
	self:CDBar(248804, 57, L.guards) -- Guards
	nextDarkBulwark = GetTime() + 57
end

function mod:Interrupt(args)
	if args.extraSpellId == 248736 then -- Eternal Twilight
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:Message(248736, "green", L.interrupted:format(self:ColorName(args.sourceName), args.extraSpellName, eternalTwilightExplo-GetTime()))
		self:CDBar(-15926, 11, CL.tentacles) -- Tentacles
		self:CDBar(244751, 16) -- Howling Dark
		self:PlaySound(248736, "long")
	end
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			if args.time - prev > 1.5 then
				prev = args.time
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end
