--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Scourgelord Tyrannus", 658, 610)
if not mod then return end
mod:RegisterEnableMob(36658, 36661)
mod:SetEncounterID(mod:Classic() and 837 or 2000)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{1262596, sound = "alarm"}, -- Scourgelord's Brand
		{1262772, sound = "alert"}, -- Rime Blast
		{1262930, sound = "none"}, -- Rotting Strikes
		{1263716, sound = "info"}, -- Frostbite
		{1276648, sound = "alarm"}, -- Bone Infusion
	})
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{69172, "ICON"}, -- Overlord's Brand
		{69275, "ICON", "ME_ONLY_EMPHASIZE"}, -- Mark of Rimefang
		69167, -- Unholy Power
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Brand", 69172)
	self:Log("SPELL_AURA_APPLIED", "Mark", 69275)
	self:Log("SPELL_AURA_REMOVED", "MarkRemoved", 69275)
	self:Log("SPELL_AURA_REMOVED", "BrandRemoved", 69172)
	self:Log("SPELL_AURA_APPLIED", "Power", 69167)
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1262596, "PRIVATE"}, -- Scourgelord's Brand
			{1262772, "PRIVATE"}, -- Rime Blast
			{1262930, "PRIVATE"}, -- Rotting Strikes
			{1263716, "PRIVATE"}, -- Frostbite
			{1276648, "PRIVATE"}, -- Bone Infusion
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Brand(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 8, args.destName)
	self:SecondaryIcon(args.spellId, args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:Mark(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:TargetBar(args.spellId, 7, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:MarkRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
end

function mod:BrandRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:SecondaryIcon(args.spellId)
end

function mod:Power(args)
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, 10)
end
