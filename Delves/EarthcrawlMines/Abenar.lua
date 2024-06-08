if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Web General Ab'enar", 2680)
if not mod then return end
mod:RegisterEnableMob(221896) -- Web General Ab'enar
mod:SetEncounterID(2877)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.web_general_abenar = "Web General Ab'enar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.web_general_abenar
end

function mod:GetOptions()
	return {
		448443, -- Curse of Agony
		448412, -- Burning Cart
		448444, -- Runic Shackles
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
	self:Log("SPELL_CAST_START", "CurseOfAgony", 448443)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Burning Cart
	self:Log("SPELL_CAST_START", "RunicShackles", 448444)
end

function mod:OnEngage()
	self:CDBar(448443, 6.2) -- Curse of Agony
	self:CDBar(448412, 13.1) -- Burning Cart
	self:CDBar(448444, 22.0) -- Runic Shackles
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:CurseOfAgony(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 24.3)
end

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if castGUID ~= prev and spellId == 448348 then -- Burning Cart
			prev = castGUID
			self:Message(448412, "yellow")
			self:PlaySound(448412, "long")
			self:CDBar(448412, 35.6)
		end
	end
end

function mod:RunicShackles(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 35.2)
end
