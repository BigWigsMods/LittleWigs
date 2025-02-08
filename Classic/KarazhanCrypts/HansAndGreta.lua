--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hans and Greta", 2875)
if not mod then return end
mod:RegisterEnableMob(
	238422, -- Hans
	238423 -- Greta
)
mod:SetEncounterID(3168) -- Opera of Malediction
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hans_and_greta = "Hans and Greta"
	L.hans = "Hans"
	L.greta = "Greta"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.hans_and_greta
end

function mod:GetOptions()
	return {
		-- Hans
		1222570, -- Umbral Slash
		1222567, -- War Stomp
		-- Greta
		1223456, -- Bounding Shadow
		1222578, -- Sleep
	}, {
		[1222570] = L.hans,
		[1223456] = L.greta,
	}
end

function mod:OnBossEnable()
	-- Hans
	self:Log("SPELL_CAST_START", "UmbralSlash", 1222570)
	self:Log("SPELL_CAST_START", "WarStomp", 1222567)
	self:Death("HansDeath", 238422)

	-- Greta
	self:Log("SPELL_CAST_START", "BoundingShadow", 1223456)
	self:Log("SPELL_CAST_START", "Sleep", 1222578)
	self:Log("SPELL_AURA_APPLIED", "SleepApplied", 1222578)
	self:Death("GretaDeath", 238423)
end

--function mod:OnEngage()
	-- can pull either boss first
--end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Hans

function mod:UmbralSlash(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 22.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:WarStomp(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 29.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:HansDeath()
	self:StopBar(1222570) -- Umbral Slash
	self:StopBar(1222567) -- War Stomp
end

-- Greta

function mod:BoundingShadow(args)
	self:Message(args.spellId, "yellow")
	--self:CDBar(args.spellId, 100) -- TODO unknown CD
	self:PlaySound(args.spellId, "alert")
end

function mod:Sleep(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	--self:CDBar(args.spellId, 100) -- TODO unknown CD
	self:PlaySound(args.spellId, "alert")
end

function mod:SleepApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:GretaDeath()
	self:StopBar(1223456) -- Bounding Shadow
	self:StopBar(1222578) -- Sleep
end
