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
	L["294853_icon"] = "inv_misc_herb_felblossom"
end

--------------------------------------------------------------------------------
-- Initialization
--

local inconspicuousPlantMarker = mod:AddMarkerOption(true, "npc", 8, 294850, 8) -- Inconspicuous Plant
function mod:GetOptions()
	return {
		294853, -- Activate Plant
		inconspicuousPlantMarker,
		{294855, "ME_ONLY"}, -- Blossom Blast
		{285440, "CASTBAR"}, -- "Hidden" Flame Cannon
		{285454, "DISPEL"}, -- Discom-BOMB-ulator
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ActivatePlant", 294853)
	self:Log("SPELL_CAST_SUCCESS", "BlossomBlast", 294855)
	self:Log("SPELL_CAST_START", "HiddenFlameCannon", 285440)
	self:Log("SPELL_CAST_START", "DiscomBOMBulator", 285454)
	self:Log("SPELL_AURA_APPLIED", "DiscomBOMBulatorApplied", 285460)
end

function mod:OnEngage()
	self:CDBar(294853, 6.1, nil, L["294853_icon"]) -- Activate Plant
	self:CDBar(285454, 8.5) -- Discom-BOMB-ulator
	self:CDBar(285440, 12.1) -- "Hidden" Flame Cannon
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local plantSummoned, plantGUID = false, nil

	function mod:ActivatePlant(args)
		plantSummoned = true
		self:Message(args.spellId, "cyan", nil, L["294853_icon"])
		self:CDBar(args.spellId, 46.1, nil, L["294853_icon"])
		if self:GetOption(inconspicuousPlantMarker) then
			self:RegisterTargetEvents("MarkInconspicuousPlant")
		end
		self:PlaySound(args.spellId, "long")
	end

	function mod:BlossomBlast(args)
		if plantSummoned then
			-- grab the GUID from the first Blossom Blast cast after Activate Plant
			plantSummoned = false
			plantGUID = args.sourceGUID
		end
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end

	function mod:MarkInconspicuousPlant(_, unit, guid)
		if plantGUID == guid then
			plantGUID = nil
			self:CustomIcon(inconspicuousPlantMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:HiddenFlameCannon(args)
	self:Message(args.spellId, "red")
	self:CastBar(args.spellId, 14.5)
	self:CDBar(args.spellId, 47.3)
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:DiscomBOMBulator(args)
		playerList = {}
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 20.6)
		self:PlaySound(args.spellId, "info")
	end

	function mod:DiscomBOMBulatorApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Dispeller("magic", nil, 285454) then
			self:TargetsMessage(285454, "red", playerList, 5)
			self:PlaySound(285454, "alert", nil, playerList)
		end
	end
end
