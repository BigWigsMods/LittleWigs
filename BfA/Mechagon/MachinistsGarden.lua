local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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

function mod:GetOptions()
	return {
		294853, -- Activate Plant
		{294855, "ME_ONLY"}, -- Blossom Blast
		{285440, "CASTBAR"}, -- "Hidden" Flame Cannon
		{285454, "DISPEL"}, -- Discom-BOMB-ulator
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ActivatePlant", 294853)
	self:Log("SPELL_CAST_SUCCESS", "BlossomBlast", 294855)
	self:Log("SPELL_CAST_START", "HiddenFlameCannon", 285440)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "DiscomBOMBulator", 285454)
	else -- XXX remove in 11.1
		self:Log("SPELL_CAST_SUCCESS", "DiscomBOMBulator", 285454)
	end
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

function mod:ActivatePlant(args)
	self:Message(args.spellId, "cyan", nil, L["294853_icon"])
	self:CDBar(args.spellId, 46.1, nil, L["294853_icon"])
	self:PlaySound(args.spellId, "long")
end

function mod:BlossomBlast(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
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
		if isElevenDotOne then
			self:CDBar(args.spellId, 20.6)
		else -- XXX remove in 11.1
			self:CDBar(args.spellId, 18.2)
		end
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
