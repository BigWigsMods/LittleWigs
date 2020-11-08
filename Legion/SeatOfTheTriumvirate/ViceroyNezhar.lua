
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viceroy Nezhar", 1753, 1981)
if not mod then return end
mod:RegisterEnableMob(122056) -- Viceroy Nezhar
mod.engageId = 2067

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
		248804, -- Dark Bulwark
		248736, -- Eternal Twilight
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
	self:Bar(-15926, 12, L.tentacles) -- Tentacles
	self:Bar(244751, 16) -- Howling Dark
	self:Bar(246324, 32) -- Entropic Force
	if self:Mythic() then
		self:Bar(248804, 53.5, L.guards) -- Guards
		nextDarkBulwark = GetTime() + 53.5
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 249336 then -- Summon Ethereal Guards
		self:MessageOld(248804, "yellow", "info", CL.spawned:format(L.guards))
	end
end

function mod:UpdateInfoBox()
	if tentaclesUp > 0 or guardsUp > 0 then
		self:OpenInfo("infobox", self.displayName)
		if tentaclesUp > 0 then
			self:SetInfo("infobox", 1, L.tentacles)
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
	function mod:TentacleSpawn()
		tentaclesUp = tentaclesUp + 1
		local t = GetTime()
		if t-prev > 3 then
			prev = t
			self:MessageOld(-15926, "yellow", "info", CL.spawned:format(L.tentacles))
			if not self:Mythic() or nextDarkBulwark - GetTime() > 30.5 then
				self:CDBar(-15926, 30.5, L.tentacles)
			end
		end
		self:UpdateInfoBox()
	end
end

function mod:TentacleDeath()
	tentaclesUp = tentaclesUp - 1
	self:UpdateInfoBox()
end

function mod:HowlingDark(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	if not self:Mythic() or nextDarkBulwark - GetTime() > 31.6 then
		self:CDBar(args.spellId, 31.6)
	end
end

function mod:EntropicForce(args)
	self:MessageOld(args.spellId, "red", "long")
	self:Bar(args.spellId, 62)
	self:CastBar(args.spellId, 10)
end

function mod:EntropicForceRemoved(args)
	self:StopBar(CL.cast:format(args.spellId))
	self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
end

function mod:DarkBulwark()
	guardsUp = guardsUp + 1
	self:UpdateInfoBox()
end

function mod:DarkBulwarkRemoved(args)
	guardsUp = guardsUp - 1
	if guardsUp > 0 then
		self:MessageOld(args.spellId, "cyan", nil, CL.mob_remaining:format(args.sourceName, guardsUp))
	else
		self:MessageOld(args.spellId, "cyan", "info", CL.removed:format(args.spellName))
	end
	self:UpdateInfoBox()
end

function mod:EternalTwilight(args)
	self:MessageOld(args.spellId, "cyan", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 10)
	eternalTwilightExplo = GetTime() + 10
	self:CDBar(248804, 57, L.guards) -- Guards
	nextDarkBulwark = GetTime() + 57
end

function mod:Interrupt(args)
	if args.extraSpellId == 248736 then -- Eternal Twilight
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:MessageOld(248736, "green", "long", L.interrupted:format(self:ColorName(args.sourceName), args.extraSpellName, eternalTwilightExplo-GetTime()))
		self:CDBar(-15926, 11, L.tentacles) -- Tentacles
		self:CDBar(244751, 16) -- Howling Dark
	end
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
