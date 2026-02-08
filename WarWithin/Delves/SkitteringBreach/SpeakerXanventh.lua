--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Speaker Xanventh", 2685)
if not mod then return end
mod:RegisterEnableMob(
	220130, -- Speaker Xanventh (trash version)
	220119 -- Speaker Xanventh (boss version)
)
mod:SetEncounterID(2947)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.speaker_xanventh = "Speaker Xanventh"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.speaker_xanventh
end

function mod:GetOptions()
	return {
		458874, -- Shadow Wave
		458834, -- Shadowspin
		{458879, "DISPEL"}, -- Blessing of Dusk
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowWave", 458874)
	self:Log("SPELL_CAST_START", "Shadowspin", 458834)
	self:Log("SPELL_CAST_START", "BlessingOfDusk", 458879)
	self:Log("SPELL_AURA_APPLIED", "BlessingOfDuskApplied", 458879)
end

function mod:OnEngage()
	self:CDBar(458874, 4.6) -- Shadow Wave
	self:CDBar(458834, 21.6) -- Shadowspin
	self:CDBar(458879, 31.3) -- Blessing of Dusk
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:MobId(args.sourceGUID) == 220119 then -- boss version
		self:CDBar(args.spellId, 12.2)
	end
end

function mod:Shadowspin(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	if self:MobId(args.sourceGUID) == 220119 then -- boss version
		self:CDBar(args.spellId, 23.0)
	end
end

function mod:BlessingOfDusk(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	if self:MobId(args.sourceGUID) == 220119 then -- boss version
		self:CDBar(args.spellId, 25.4)
	end
end

function mod:BlessingOfDuskApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end
