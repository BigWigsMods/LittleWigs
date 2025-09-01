--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Geargrave", {2684, 2688, 2826}) -- The Dread Pit, The Spiral Weave, Sidestreet Sluice
if not mod then return end
mod:RegisterEnableMob(
	234949, -- Geargrave (The Dread Pit)
	236531, -- Geargrave (The Spiral Weave)
	247481, -- Geargrave (Sidestreet Sluice)
	249829 -- Geargrave (Sidestreet Sluice)
)
mod:SetEncounterID({3120, 3123, 3174, 3352}) -- The Dread Pit, The Spiral Weave, Sidestreet Sluice, Sidestreet Sluice
--mod:SetRespawnTime(15) resets, doesn't respawn
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.geargrave = "Geargrave"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.geargrave
	self:SetSpellRename(1215975, CL.enrage) -- Juice It Up! (Enrage)
end

function mod:GetOptions()
	return {
		1215957, -- Tremor Claw
		1215905, -- Carnage Cannon
		1215912, -- Black Blood
		1215975, -- Juice It Up!
	},nil,{
		[1215975] = CL.enrage, -- Juice It Up! (Enrage)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TremorClaw", 1215957)
	self:Log("SPELL_CAST_START", "CarnageCannon", 1215905)
	self:Log("SPELL_PERIODIC_DAMAGE", "BlackBloodDamage", 1215912)
	self:Log("SPELL_PERIODIC_MISSED", "BlackBloodDamage", 1215912)
	self:Log("SPELL_CAST_START", "JuiceItUp", 1215975)
end

function mod:OnEngage()
	self:CDBar(1215957, 6.0) -- Tremor Claw
	self:CDBar(1215905, 12.1) -- Carnage Cannon
	self:CDBar(1215975, 18.2, CL.enrage) -- Juice It Up!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TremorClaw(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CarnageCannon(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 21.1)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:BlackBloodDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:JuiceItUp(args)
	self:Message(args.spellId, "red", CL.enrage)
	self:CDBar(args.spellId, 41.3, CL.enrage)
	self:PlaySound(args.spellId, "info")
end
