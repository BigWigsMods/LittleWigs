--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Theka the Martyr", 209, 485)
if not mod then return end
mod:RegisterEnableMob(7272) -- Theka the Martyr
mod:SetEncounterID(596)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{8600, "DISPEL"}, -- Fevered Plague
		17228, -- Shadow Bolt Volley
		{15654, "DISPEL"}, -- Shadow Word: Pain
		{450933, "DISPEL"}, -- Curse of the Martyr
		-- 11089 Shadow Transformation, cast doesn't log, aura is hidden
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FeveredPlague", 8600)
	self:Log("SPELL_AURA_APPLIED", "FeveredPlagueApplied", 8600)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "ShadowBoltVolley", 17228)
		self:Log("SPELL_CAST_SUCCESS", "ShadowWordPain", 15654)
		self:Log("SPELL_AURA_APPLIED", "ShadowWordPainApplied", 15654)
		self:Log("SPELL_CAST_SUCCESS", "CurseOfTheMartyr", 450933)
		self:Log("SPELL_AURA_APPLIED", "CurseOfTheMartyrApplied", 450933)
		if self:Heroic() then -- no encounter events in Timewalking
			self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
			self:Death("Win", 7272)
		end
	end
end

function mod:OnEngage()
	self:CDBar(17228, 7.6) -- Shadow Bolt Volley
	self:CDBar(8600, 11.2) -- Fevered Plague
	self:CDBar(15654, 18.2) -- Shadow Word: Pain
	self:CDBar(450933, 19.5) -- Curse of the Martyr
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			8600, -- Fevered Plague
		}
	end

	function mod:OnEngage()
		self:CDBar(8600, 11.2) -- Fevered Plague
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FeveredPlague(args)
	if self:MobId(args.sourceGUID) == 7272 then -- Theka the Martyr
		self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 8.5)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FeveredPlagueApplied(args)
	if (self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId)) and self:MobId(args.sourceGUID) == 7272 then -- Theka the Martyr
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 7272 then -- Theka the Martyr
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 21.8)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ShadowWordPain(args)
	if self:MobId(args.sourceGUID) == 7272 then -- Theka the Martyr
		self:CDBar(args.spellId, 17.0)
	end
end

function mod:ShadowWordPainApplied(args)
	if self:Dispeller("magic", nil, args.spellId) and self:MobId(args.sourceGUID) == 7272 then -- Theka the Martyr
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:CurseOfTheMartyr(args)
	self:CDBar(args.spellId, 11.0)
end

function mod:CurseOfTheMartyrApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end
