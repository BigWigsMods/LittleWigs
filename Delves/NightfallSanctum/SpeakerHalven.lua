if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Speaker Halven", 2686)
if not mod then return end
mod:RegisterEnableMob(217570) -- Speaker Halven
mod:SetEncounterID(3007)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.speaker_halven = "Speaker Halven"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.speaker_halven
end

function mod:GetOptions()
	return {
		443837, -- Shadow Sweep
		443908, -- Fire!
		443840, -- Desolate Surge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowSweep", 443837)
	self:Log("SPELL_CAST_START", "Fire", 443908)
	self:RegisterEvent("UNIT_SPELLCAST_START") -- Desolate Surge
end

function mod:OnEngage()
	self:CDBar(443837, 5.9) -- Shadow Sweep
	self:CDBar(443908, 9.5) -- Fire!
	self:CDBar(443840, 20.7) -- Desolate Surge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowSweep(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 13.0)
end

function mod:Fire(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.2)
end

do
	local prev
	function mod:UNIT_SPELLCAST_START(_, _, castGUID, spellId)
		if castGUID ~= prev and spellId == 443840 then -- Desolate Surge
			prev = castGUID
			self:Message(spellId, "yellow")
			self:PlaySound(spellId, "long")
			self:CDBar(spellId, 26.7)
		end
	end
end
