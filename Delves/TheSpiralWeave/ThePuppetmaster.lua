--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Puppetmaster", 2688)
if not mod then return end
mod:RegisterEnableMob(220507) -- The Puppetmaster?
mod:SetEncounterID(3006)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.the_puppetmaster = "The Puppetmaster"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.the_puppetmaster
end

function mod:GetOptions()
	return {
		451913, -- Grimweave Orb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GrimweaveOrb", 451913)
end

function mod:OnEngage()
	self:CDBar(451913, 6.3) -- Grimweave Orb
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GrimweaveOrb(args)
	-- this spellId can also be cast by trash
	if self:MobId(args.sourceGUID) == 220507 then -- The Puppetmaster?
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 23.0)
	end
end
