
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thrall", 2212)
if not mod then return end
mod:RegisterEnableMob(152089)
mod:SetAllowWin(true)
mod.engageId = 2332

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.thrall = "Thrall"
end

----------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297746, -- Seismic Slam
		297822, -- Surging Darkness
		304976, -- Cries of the Void
		306828, -- Defiled Ground
	}
end

function mod:OnRegister()
	self.displayName = L.thrall
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SeismicSlam", 297746)
	self:Log("SPELL_CAST_SUCCESS", "SurgingDarkness", 297822)
	self:Log("SPELL_CAST_START", "CriesOfTheVoid", 304976)
	self:Log("SPELL_CAST_START", "DefiledGround", 306828)
end

function mod:OnEngage()
	self:Bar(297746, 5) -- Seismic Slam
	self:Bar(297822, 12) -- Surging Darkness
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SeismicSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 12.1)
end

function mod:SurgingDarkness(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 23)
end

function mod:CriesOfTheVoid(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:DefiledGround(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 12.1)
end
