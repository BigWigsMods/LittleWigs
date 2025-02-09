--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Unk'omon", 2875)
if not mod then return end
mod:RegisterEnableMob(238678) -- Unk'omon
mod:SetEncounterID(3152)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.unkomon = "Unk'omon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.unkomon
end

function mod:GetOptions()
	return {
		{1221577, "DISPEL"}, -- Doom
		1220515, -- Shadow Bolt Volley
		1221578, -- Mark of the Master
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Doom", 1221577)
	self:Log("SPELL_AURA_APPLIED", "DoomApplied", 1221577)
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 1220515)
	self:Log("SPELL_CAST_SUCCESS", "MarkOfTheMaster", 1221578)
end

function mod:OnEngage()
	self:CDBar(1221577, 10.1) -- Doom
	self:CDBar(1220515, 12.4) -- Shadow Bolt Volley
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:Doom(args)
		playerList = {}
		self:CDBar(args.spellId, 30.8)
	end

	function mod:DoomApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 5)
			self:PlaySound(args.spellId, "alarm", nil, playerList)
		end
	end
end

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 238678 then -- Unk'omon
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 14.6)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:MarkOfTheMaster(args)
	-- cast on defeat
	self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
