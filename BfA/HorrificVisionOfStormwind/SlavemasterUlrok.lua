--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Slavemaster Ul'rok", 2213)
if not mod then return end
mod:RegisterEnableMob(
	153541, -- Slavemaster Ul'rok
	233685 -- Slavemaster Ul'rok (Revisited)
)
mod:SetEncounterID({2375, 3083}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local chainsOfServitudeCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.slavemaster_ulrok = "Slavemaster Ul'rok"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		298691, -- Chains of Servitude
		298866, -- Lashing Tendrils
	}
end

function mod:OnRegister()
	self.displayName = L.slavemaster_ulrok
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ChainsOfServitude", 298691)
	self:Log("SPELL_CAST_START", "LashingTendrils", 298866)
end

function mod:OnEngage()
	chainsOfServitudeCount = 1
	self:CDBar(298866, 2.4) -- Lashing Tendrils
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ChainsOfServitude(args)
	if chainsOfServitudeCount == 1 then
		self:Message(args.spellId, "cyan", CL.percent:format(75, args.spellName))
	else
		self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
	end
	chainsOfServitudeCount = chainsOfServitudeCount + 1
	self:PlaySound(args.spellId, "long")
end

function mod:LashingTendrils(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 5.0)
	self:PlaySound(args.spellId, "alarm")
end
