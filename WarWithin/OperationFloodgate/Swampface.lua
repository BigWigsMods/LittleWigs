if not BigWigsLoader.isTestBuild then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Swampface", 2773, 2650)
if not mod then return end
mod:RegisterEnableMob(226396) -- Swampface
mod:SetEncounterID(3053)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- TODO Razorchoke Vines (Mythic)
		473070, -- Awaken the Swamp
		473114, -- Mudslide
		{469478, "TANK_HEALER"}, -- Sludge Claws
	}
end

function mod:OnBossEnable()
	-- TODO warmup?
	self:Log("SPELL_CAST_START", "AwakenTheSwamp", 473070)
	self:Log("SPELL_CAST_START", "Mudslide", 473114)
	self:Log("SPELL_CAST_START", "SludgeClaws", 469478)
end

function mod:OnEngage()
	self:CDBar(469478, 3.0) -- Sludge Claws
	self:CDBar(473114, 9.0) -- Mudslide
	self:CDBar(473070, 19.0) -- Awaken the Swamp
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AwakenTheSwamp(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 30.0)
	self:PlaySound(args.spellId, "long")
end

function mod:Mudslide(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.0)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SludgeClaws(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 30.0)
	self:PlaySound(args.spellId, "alert")
end
