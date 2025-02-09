--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Barian Maryla", 2875)
if not mod then return end
mod:RegisterEnableMob(238234) -- Barian Maryla
mod:SetEncounterID(3172) -- Apprentice
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.barian_maryla = "Barian Maryla"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.barian_maryla
end

function mod:GetOptions()
	return {
		1220515, -- Shadow Bolt Volley
		{1220926, "DISPEL"}, -- Curse of Decay
		1220519, -- Summon Skeletal Servant
		1220517, -- Bone Armor
		1220920, -- Necrotic Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 1220515)
	self:Log("SPELL_CAST_SUCCESS", "CurseOfDecay", 1220926)
	self:Log("SPELL_AURA_APPLIED", "CurseOfDecayApplied", 1220926)
	self:Log("SPELL_CAST_SUCCESS", "SummonSkeletalServant", 1220519)
	self:Log("SPELL_AURA_REMOVED", "BoneArmorRemoved", 1220517)
	self:Log("SPELL_CAST_START", "NecroticBreath", 1220920)
end

function mod:OnEngage()
	self:CDBar(1220515, 8.1) -- Shadow Bolt Volley
	self:CDBar(1220926, 11.3) -- Curse of Decay
	self:CDBar(1220519, 17.8) -- Summon Skeletal Servant
	self:CDBar(1220920, 21.0) -- Necrotic Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 238234 then -- Barian Maryla
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 12.9)
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local playerList = {}

	function mod:CurseOfDecay(args)
		playerList = {}
		self:CDBar(args.spellId, 30.8)
	end

	function mod:CurseOfDecayApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 3)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

function mod:SummonSkeletalServant(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 30.7)
	self:PlaySound(args.spellId, "info")
end

function mod:BoneArmorRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:NecroticBreath(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.7)
	self:PlaySound(args.spellId, "alarm")
end
