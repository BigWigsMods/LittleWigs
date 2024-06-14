if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anub'ikkaj", 2662, 2581)
if not mod then return end
mod:RegisterEnableMob(211089) -- Anub'ikkaj
mod:SetEncounterID(2838)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427001, -- Terrifying Slam
		426860, -- Dark Orb
		426787, -- Shadowy Decay
		-- Mythic
		452127, -- Animate Shadows
	}, {
		[452127] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingSlam", 427001)
	--self:Log("SPELL_CAST_START", "DarkOrb", 426860) -- private aura for Dark Orb is 426865
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Dark Orb
	self:Log("SPELL_CAST_START", "ShadowyDecay", 426787)

	-- Mythic
	self:Log("SPELL_CAST_START", "AnimateShadows", 452127)
end

function mod:OnEngage()
	self:CDBar(426860, 6.0) -- Dark Orb
	self:CDBar(427001, 15.0) -- Terrifying Slam
	self:CDBar(426787, 22.0) -- Shadowy Decay
	if self:Mythic() then
		self:CDBar(452127, 32.1) -- Animate Shadows
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	-- TODO almost always 26s, but once it was 16s - why?
	self:CDBar(args.spellId, 26.0)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, destName)
	if msg:find("426860", nil, true) then -- Dark Orb
		-- [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Spell_Shadow_SoulGem.blp:20|t %s begins to cast |cFFFF0000|Hspell:426860|h[Dark Orb]|h|r at Foryou!#Anub'ikkaj###playerName
		self:TargetMessage(426860, "orange", destName)
		self:PlaySound(426860, "alarm", nil, destName)
		-- TODO almost always 26s, but once it was 16s - why?
		self:CDBar(426860, 26.0)
	end
end

function mod:ShadowyDecay(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 26.0)
end

-- Mythic

function mod:AnimateShadows(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 40.6)
end
