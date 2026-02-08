--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Biggest Bug", 2680)
if not mod then return end
mod:RegisterEnableMob(234376) -- The Biggest Bug
mod:SetEncounterID(3100)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_biggest_bug = "The Biggest Bug"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_biggest_bug
	self:SetSpellRename(448443, CL.curse) -- Curse of Agony (Curse)
end

function mod:GetOptions()
	return {
		448443, -- Curse of Agony
		448444, -- Runic Shackles
	}, nil, {
		[448443] = CL.curse, -- Curse of Agony (Curse)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CurseOfAgony", 448443)
	self:Log("SPELL_CAST_START", "RunicShackles", 448444)
end

function mod:OnEngage()
	self:CDBar(448443, 6.9, CL.curse) -- Curse of Agony
	self:CDBar(448444, 20.6) -- Runic Shackles
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CurseOfAgony(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 24.3, CL.curse)
	self:PlaySound(args.spellId, "alert")
end

function mod:RunicShackles(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 34.0)
	self:PlaySound(args.spellId, "alert")
end
