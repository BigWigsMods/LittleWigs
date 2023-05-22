--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Machinist's Garden", 2097, 2348)
if not mod then return end
mod:RegisterEnableMob(144248) -- Head Machinist Sparkflux
mod:SetEncounterID(2259)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.activate_plant = 294853
	L.activate_plant_icon = "inv_misc_herb_felblossom"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"activate_plant", -- Activate Plant
		294855, -- Blossom Blast
		{285440, "CASTBAR"}, -- "Hidden" Flame Cannon
		{285454, "DISPEL"}, -- Discom-BOMB-ulator
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ActivatePlant", 294853)
	self:Log("SPELL_CAST_SUCCESS", "BlossomBlast", 294855)
	self:Log("SPELL_CAST_SUCCESS", "HiddenFlameCannon", 285440)
	self:Log("SPELL_CAST_SUCCESS", "Discombombulator", 285454)
	self:Log("SPELL_AURA_APPLIED", "DiscombombulatorApplied", 285460)
end

function mod:OnEngage()
	self:Bar("activate_plant", 6.1, L.activate_plant, L.activate_plant_icon) -- Activate Plant
	self:Bar(285454, 8.5) -- Discom-BOMB-ulator
	self:Bar(285440, 14.1) -- "Hidden" Flame Cannon
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ActivatePlant(args)
	self:Message("activate_plant", "orange", L.activate_plant, L.activate_plant_icon)
	self:PlaySound("activate_plant", "long")
	self:Bar("activate_plant", 45.1, L.activate_plant, L.activate_plant_icon)
end

function mod:BlossomBlast(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:HiddenFlameCannon(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 12.5)
	self:Bar(args.spellId, 47.3)
end

do
	local playerList = {}

	function mod:Discombombulator(args)
		playerList = {}
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		self:Bar(args.spellId, 18.2)
	end

	function mod:DiscombombulatorApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Dispeller("magic", nil, 285454) then
			self:TargetsMessage(285454, "orange", playerList, 5)
			self:PlaySound(285454, "alert", nil, playerList)
		end
	end
end
