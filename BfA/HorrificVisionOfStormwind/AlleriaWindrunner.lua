
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Alleria Windrunner", 2213)
if not mod then return end
mod:RegisterEnableMob(152718)
mod:SetAllowWin(true)
mod.engageId = 2338

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.alleria_windrunner = "Alleria Windrunner"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		308278, -- Darkened Sky
		309819, -- Void Eruption
		298691, -- Chains of Servitude
	}
end

function mod:OnRegister()
	self.displayName = L.alleria_windrunner
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")

	self:Log("SPELL_CAST_SUCCESS", "DarkenedSky", 308278)
	self:Log("SPELL_CAST_START", "VoidEruption", 309819)
	self:Log("SPELL_CAST_START", "ChainsOfServitude", 298691)
end

function mod:OnEngage()
	self:Bar(308278, 6.8) -- Darkened Sky
	self:Bar(309819, 20.6) -- Void Eruption
end

-- There are no boss frames to trigger the engage
function mod:ENCOUNTER_START(_, encounterId)
	if encounterId == self.engageId then
		self:Engage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkenedSky(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 13.3)
end

function mod:VoidEruption(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 28)
end

function mod:ChainsOfServitude(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
