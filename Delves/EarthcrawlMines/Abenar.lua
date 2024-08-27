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
	self:SetSpellRename(448443, CL.curse) -- Curse of Agony (Curse)
end

function mod:GetOptions()
	return {
		448443, -- Curse of Agony
		448412, -- Burning Cart
		448444, -- Runic Shackles
	},nil,{
		[448443] = CL.curse, -- Curse of Agony (Curse)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CurseOfAgony", 448443)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Burning Cart
	self:Log("SPELL_CAST_START", "RunicShackles", 448444)
end

function mod:OnEngage()
	self:CDBar(448443, 6.2, CL.curse) -- Curse of Agony
	self:CDBar(448412, 12.5) -- Burning Cart
	self:CDBar(448444, 20.2) -- Runic Shackles
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CurseOfAgony(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23.5, CL.curse)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 448348 then -- Burning Cart
		self:Message(448412, "yellow")
		self:PlaySound(448412, "long")
		self:CDBar(448412, 35.6)
	end
end

function mod:RunicShackles(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 33.2)
end
