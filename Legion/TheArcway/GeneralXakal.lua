
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Xakal", 1516, 1499)
if not mod then return end
mod:RegisterEnableMob(98206)
mod.engageId = 1828

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dread_felbat = -12489
	L.dread_felbat_icon = "inv_felbatmount"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		197776, -- Fel Fissure
		197810, -- Wicked Slam
		212030, -- Shadow Slash
		"dread_felbat", -- Dread Felbat / Bombardment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FelFissure", 197776)
	self:Log("SPELL_CAST_START", "ShadowSlash", 212030)
	self:Log("SPELL_CAST_START", "WickedSlam", 197810)
end

function mod:OnEngage()
	self:CDBar(197776, 6) -- Fel Fissure
	self:CDBar(212030, 13) -- Shadow Slash
	self:CDBar("dread_felbat", 20, L.dread_felbat, L.dread_felbat_icon) -- Dread Felbat
	self:ScheduleTimer("DreadFelbats", 20) -- starts at 20, bat comes down after ~5s, next set +32s
	self:CDBar(197810, 36) -- Wicked Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DreadFelbats()
	self:MessageOld("dread_felbat", "cyan", "info", CL.soon:format(self:SpellName(L.dread_felbat)), false)
	self:CDBar("dread_felbat", 31.5, L.dread_felbat, L.dread_felbat_icon)
	self:ScheduleTimer("DreadFelbats", 31.5)
end

function mod:FelFissure(args)
	self:MessageOld(args.spellId, "yellow")
	self:CDBar(args.spellId, 23)
end

function mod:ShadowSlash(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:CDBar(args.spellId, 25)
end

function mod:WickedSlam(args)
	self:MessageOld(args.spellId, "orange", "alert")
	self:CDBar(args.spellId, 47)
end
