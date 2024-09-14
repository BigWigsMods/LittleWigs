--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Puppetmaster", 2688)
if not mod then return end
mod:RegisterEnableMob(220507, 220510) -- The Puppetmaster?, The Puppetmaster? (Final Stage)
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
		448663, -- Stinging Swarm
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GrimweaveOrb", 451913)
	self:Log("SPELL_CAST_START", "StingingSwarm", 448663)
end

function mod:OnEngage()
	--self:CDBar(451913, 6.3) -- Grimweave Orb
	self:CDBar(448663, 9.7) -- Stinging Swarm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GrimweaveOrb(args)
	-- this spellId can also be cast by trash
	if self:MobId(args.sourceGUID) == 220507 then -- The Puppetmaster?
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 23.0)
	end
end

function mod:StingingSwarm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 31.6)
end
