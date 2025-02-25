if select(4, GetBuildInfo()) < 110100 then return end -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Geargrave", 2826)
if not mod then return end
mod:RegisterEnableMob(234949) -- Geargrave
--mod:SetEncounterID(3174) -- encounter events don't fire
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
end

function mod:GetOptions()
	return {
		1215905, -- Carnage Cannon
		1215975, -- Juice It Up!
		1215957, -- Tremor Claw
	}
end

function mod:OnBossEnable()
	-- XXX no boss frames
	self:Log("SPELL_CAST_START", "CarnageCannon", 1215905)
	self:Log("SPELL_CAST_START", "JuiceItUp", 1215975)
	self:Log("SPELL_CAST_START", "TremorClaw", 1215957)
	-- TODO needs Black Blood under you
end

function mod:OnEngage()
	-- XXX no encounter events
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CarnageCannon(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alarm")
end

function mod:JuiceItUp(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 37.7)
	self:PlaySound(args.spellId, "info")
end

function mod:TremorClaw(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 9.7)
	self:PlaySound(args.spellId, "alarm")
end
