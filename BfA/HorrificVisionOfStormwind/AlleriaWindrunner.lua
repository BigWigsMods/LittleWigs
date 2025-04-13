--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Alleria Windrunner", 2213)
if not mod then return end
mod:RegisterEnableMob(
	152718, -- Alleria Windrunner
	233675 -- Alleria Windrunner (Revisisted)
)
mod:SetEncounterID({2338, 3081}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.alleria_windrunner = "Alleria Windrunner"
	L["312260_icon"] = 305672 -- Explosive Ordnance
	L["312260_desc"] = 305672 -- Explosive Ordnance
	L.warmup_icon = "spell_arcane_teleportstormwind"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		308278, -- Darkened Sky
		{309819, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Void Eruption
		-- Fallen Servants: Slavemaster Ul'rok
		298691, -- Chains of Servitude
		-- Fallen Servants: Magister Umbric
		309648, -- Tainted Polymorph
		-- Fallen Servants: Therum Deepforge
		312260, -- Explosive Ordnance
		-- Fallen Servants: Overlord Shaw
		{308669, "NAMEPLATE"}, -- Dark Gaze
	}, {
		[298691] = 312228, -- Fallen Servants: Slavemaster Ul'rok
		[309648] = 312230, -- Fallen Servants: Magister Umbric
		[312260] = 312226, -- Fallen Servants: Therum Deepforge
		[308669] = 312229, -- Fallen Servants: Overlord Shaw
	}
end

function mod:OnRegister()
	self.displayName = L.alleria_windrunner
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DarkenedSky", 308278)
	self:Log("SPELL_CAST_START", "VoidEruption", 309819)

	-- Fallen Servants: Slavemaster Ul'rok
	self:Log("SPELL_CAST_START", "ChainsOfServitude", 298691)

	-- Fallen Servants: Magister Umbric
	self:Log("SPELL_CAST_START", "TaintedPolymorph", 309648)

	-- Fallen Servants: Therum Deepforge
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Explosive Ordnance

	-- Fallen Servants: Overlord Shaw
	self:Log("SPELL_CAST_START", "DarkGaze", 308669)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:CDBar(308278, 6.8) -- Darkened Sky
	local bossUnit = self:GetBossId(233675) or self:GetBossId(152718)
	if bossUnit then
		if self:UnitBuff(bossUnit, 312226) then -- Fallen Servants: Therum Deepforge
			self:CDBar(312260, 9.6, nil, L["312260_icon"]) -- Explosive Ordnance
		end
		if self:UnitBuff(bossUnit, 312230) then -- Fallen Servants: Magister Umbric
			self:CDBar(309648, 14.5) -- Tainted Polymorph
		end
	end
	self:CDBar(309819, 20.6) -- Void Eruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 0.00 [CHAT_MSG_MONSTER_YELL] Mother... do not listen to the whispers!#Arator the Redeemer
	-- 14.62 [NAME_PLATE_UNIT_ADDED] Alleria Windrunner#Creature-0-2083-2827-1183-233675
	self:Bar("warmup", 14.6, CL.active, L.warmup_icon)
end

function mod:DarkenedSky(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoidEruption(args)
	self:Message(args.spellId, "yellow")
	self:CastBar(args.spellId, 7)
	self:CDBar(args.spellId, 27.9)
	self:PlaySound(args.spellId, "warning")
end

-- Fallen Servants: Slavemaster Ul'rok

function mod:ChainsOfServitude(args)
	if self:IsEngaged() then -- also in Slavemaster Ul'rok's module
		-- cast once at 50%
		self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
		self:PlaySound(args.spellId, "long")
	end
end

-- Fallen Servants: Magister Umbric

function mod:TaintedPolymorph(args)
	if self:IsEngaged() then -- also in Magister Umbric's module
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 21.9)
		self:PlaySound(args.spellId, "alert")
	end
end

-- Fallen Servants: Therum Deepforge

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 312260 then -- Explosive Ordnance
		self:Message(spellId, "orange", nil, L["312260_icon"])
		self:CDBar(spellId, 20.7, nil, L["312260_icon"])
		self:PlaySound(spellId, "info")
	end
end

-- Fallen Servants: Overlord Shaw

function mod:DarkGaze(args)
	if self:IsEngaged() then -- also in Mathias Shaw's module
		self:Message(args.spellId, "red")
		self:Nameplate(args.spellId, 12.3, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end
end
