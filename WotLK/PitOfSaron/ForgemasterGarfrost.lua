--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Garfrost", 658, 608)
if not mod then return end
mod:RegisterEnableMob(36494)
mod:SetEncounterID(mod:Classic() and 833 or 1999)
if mod:Retail() then -- Midnight+
	mod:SetPrivateAuraSounds({
		{1261286, sound = "alarm"}, -- Throw Saronite
		{1261540, sound = "alarm"}, -- Orebreaker
		{1261799, sound = "underyou"}, -- Saronite Sludge
		{1261921, sound = "alert"}, -- Cryoshards
	})
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{70381, "ICON"}, -- Deep Freeze
		68789, -- Throw Saronite
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DeepFreeze", 70381)
	self:Log("SPELL_AURA_REMOVED", "DeepFreezeRemoved", 70381)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{1261286, "PRIVATE"}, -- Throw Saronite
			{1261540, "PRIVATE"}, -- Orebreaker
			{1261799, "PRIVATE"}, -- Saronite Sludge
			{1261921, "PRIVATE"}, -- Cryoshards
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeepFreeze(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, "yellow")
	self:TargetBar(args.spellId, 14, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	self:PlaySound(args.spellId, "alert")
end

function mod:DeepFreezeRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER()
	self:Message(68789, "red", CL.incoming:format(self:SpellName(68789)))
	self:PlaySound(68789, "alarm")
end
